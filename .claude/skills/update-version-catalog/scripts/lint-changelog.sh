#!/usr/bin/env bash
#
# Cross-check the [Unreleased] section of CHANGELOG.md against the actual
# catalog changes of the working branch (origin/main..HEAD) and the format
# rules from SKILL.md:
#
#   - every catalog version change is documented in the right subsection with
#     exact `old` → `new` versions; added deps have :sparkle:, removed :x:;
#     documentation is matched BY ALIAS NAME — a same-versions pair (e.g. all
#     compose-* going 1.11.3 → 1.11.4) only counts when it is unambiguous;
#   - every [libraries]/[plugins] alias added, removed or re-pointed at another
#     module/id is documented too (catches pure module renames);
#   - nested BOM-component entries are cross-checked against the diff as well;
#   - no phantom entries (documenting a change that is not in the diff);
#   - valid symbols, markdown links, real arrow "→" (never "->"), versions in
#     backticks, plugin: prefix format;
#   - sorting (libraries alphabetically, then plugin: entries alphabetically;
#     nested BOM-component entries sorted within their parent),
#     no duplicates, all three subsections present, no stray "*No changes*";
#   - every renovate branch's bump made it into the branch diff, per alias — a
#     branch superseded by a newer bump of the same alias is reported as INFO,
#     not as a problem (skip the whole check with --skip-renovate in add-only
#     sessions).
#
# Prints PROBLEM lines and exits 1, or prints OK. INFO lines are advisory.
# READ-ONLY. Usage: bash lint-changelog.sh [--skip-renovate]
#
# Portable to macOS (bash 3.2 + BSD userland) — see lib.sh for the rules.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

skip_renovate=0
[ "${1:-}" = "--skip-renovate" ] && skip_renovate=1

# This lint reads the COMMIT (HEAD), not the working tree — linting while the
# edits are still uncommitted reports every entry as missing, which reads like a
# changelog problem but is really "you have not run commit-release.sh yet".
if ! git diff --quiet -- CHANGELOG.md 'versions-*/libs.versions.toml'; then
  echo "PROBLEM: CHANGELOG.md / versions-*/libs.versions.toml have UNCOMMITTED changes."
  echo "         This check compares HEAD against origin/main, so it would not see them."
  echo "         Fold them into the commit first:"
  echo "           bash .claude/skills/update-version-catalog/scripts/commit-release.sh"
  echo "         then re-run this script."
  exit 1
fi

problems=()
problem() { problems=("${problems[@]:+${problems[@]}}" "$1"); }
info() { echo "INFO: $1"; }

# ---------- catalog changes on the branch (origin/main..HEAD) ---------------
#
# maps (see lib.sh): OLDV/NEWV      "<sub>|<alias>" -> version
#                    CHG_OLD/CHG_NEW, ADDEDV, REMOVEDV
#                    OLDM/NEWM      "<sub>|<alias>" -> module / plugin id
#                    DIFF_ADD/DIFF_DEL  "<sub>"     -> raw added/removed lines
#                    PAIRCNT/ADDCNT how many aliases share a version pair

sub_of_dir() {
  case "$1" in
    versions-androidx)    echo "AndroidX" ;;
    versions-redmadrobot) echo "red_mad_robot" ;;
    versions-stack)       echo "Stack" ;;
    *)                    echo "" ;;
  esac
}

for f in versions-*/libs.versions.toml; do
  sub=$(sub_of_dir "${f%%/*}"); [ -n "$sub" ] || continue
  while IFS=$'\t' read -r a v; do
    [ -n "$a" ] && map_put OLDV "$sub|$a" "$v"
  done < <(git show "origin/main:$f" 2>/dev/null | toml_versions)
  while IFS=$'\t' read -r a v; do
    [ -n "$a" ] && map_put NEWV "$sub|$a" "$v"
  done < <(git show "HEAD:$f" 2>/dev/null | toml_versions)
  while IFS=$'\t' read -r a m; do
    [ -n "$a" ] && map_put OLDM "$sub|$a" "$m"
  done < <(git show "origin/main:$f" 2>/dev/null | toml_modules)
  while IFS=$'\t' read -r a m; do
    [ -n "$a" ] && map_put NEWM "$sub|$a" "$m"
  done < <(git show "HEAD:$f" 2>/dev/null | toml_modules)
  map_put DIFF_ADD "$sub" "$(git diff origin/main..HEAD -- "$f" | grep -E '^\+[^+]' || true)"
  map_put DIFF_DEL "$sub" "$(git diff origin/main..HEAD -- "$f" | grep -E '^-[^-]' || true)"
done

map_keys NEWV; newv_keys="$REPLY"
map_keys OLDV; oldv_keys="$REPLY"

while IFS= read -r k; do
  [ -n "$k" ] || continue
  map_get NEWV "$k"; nv="$REPLY"
  if map_has OLDV "$k"; then
    map_get OLDV "$k"; ov="$REPLY"
    if [ "$ov" != "$nv" ]; then
      map_put CHG_OLD "$k" "$ov"; map_put CHG_NEW "$k" "$nv"
    fi
  else
    map_put ADDEDV "$k" "$nv"
  fi
done <<< "$newv_keys"

while IFS= read -r k; do
  [ -n "$k" ] || continue
  if ! map_has NEWV "$k"; then
    map_get OLDV "$k"; map_put REMOVEDV "$k" "$REPLY"
  fi
done <<< "$oldv_keys"

map_keys CHG_OLD;  chg_keys="$REPLY"
map_keys ADDEDV;   add_keys="$REPLY"
map_keys REMOVEDV; rem_keys="$REPLY"

# how many aliases share the same (sub, old, new) / (sub, added version): a
# version pair may only stand in for a missing name match when it is unique
while IFS= read -r k; do
  [ -n "$k" ] || continue
  map_get CHG_OLD "$k"; o="$REPLY"; map_get CHG_NEW "$k"; n="$REPLY"
  map_inc PAIRCNT "${k%%|*}|$o|$n"
done <<< "$chg_keys"
while IFS= read -r k; do
  [ -n "$k" ] || continue
  map_get ADDEDV "$k"; v="$REPLY"
  map_inc ADDCNT "${k%%|*}|$v"
done <<< "$add_keys"

# ---------- [Unreleased] entries ---------------------------------------------

unreleased() { # $1=rev
  git show "$1:CHANGELOG.md" 2>/dev/null | awk '
    /^## \[Unreleased\]/ {u=1; next}
    /^## \[/ {u=0}
    u {print}
  '
}

annotate() { # stdin -> "sub<TAB>indent<TAB>entry-line"
  awk '
    /^### /  {s=substr($0,5); next}
    s=="" {next}
    /\*No changes\*/ {next}
    /^- /    {print s "\t0\t" $0}
    /^  - /  {print s "\t1\t" $0}
  '
}

head_unrel=$(unreleased HEAD)
main_unrel=$(unreleased origin/main)
[ -n "$head_unrel" ] || { echo "PROBLEM: no [Unreleased] section in CHANGELOG.md"; exit 1; }

head_ann=$(annotate <<< "$head_unrel")
main_ann=$(annotate <<< "$main_unrel")
if [ -n "$main_ann" ]; then
  new_ann=$(grep -Fxv -f <(printf '%s\n' "$main_ann") <<< "$head_ann" || true)
else
  new_ann="$head_ann"
fi

entry_name() { sed -nE 's/^ *- :[a-z_]+: (plugin: )?\[([^]]+)\].*$/\2/p' <<< "$1"; }
entry_sym()  { sed -nE 's/^ *- :([a-z_]+):.*$/\1/p' <<< "$1"; }
entry_vers() { grep -oE '`[^`]+`' <<< "$1" | tr -d '`' || true; }

# ---------- structural checks -------------------------------------------------

for s in red_mad_robot AndroidX Stack; do
  if ! grep -q "^### $s\$" <<< "$head_unrel"; then
    problem "missing subsection '### $s' in [Unreleased]"
    continue
  fi
  body=$(awk -v s="### $s" '$0==s{f=1;next} /^### /{f=0} f' <<< "$head_unrel")
  n_entries=$(grep -cE '^ *- :' <<< "$body" || true)
  n_nochange=$(grep -cF '*No changes*' <<< "$body" || true)
  if [ "$n_entries" -gt 0 ] && [ "$n_nochange" -gt 0 ]; then
    problem "subsection $s: has entries but still contains '*No changes*'"
  fi
  if [ "$n_entries" -eq 0 ] && [ "$n_nochange" -eq 0 ]; then
    problem "subsection $s: empty — add '- *No changes*'"
  fi
done

dups=$(grep -E '^ *- :' <<< "$head_unrel" | sort | uniq -d || true)
if [ -n "$dups" ]; then
  while IFS= read -r d; do [ -n "$d" ] && problem "duplicate entry: $d"; done <<< "$dups"
fi

# ---------- per-entry format + cross-check ------------------------------------

# nested (BOM-component) entries are cross-checked too, but a component that has
# no alias of its own in the catalog cannot be verified — for those the "nothing
# matching in the diff" verdicts are advisory instead of fatal.
soft() { # $1=indent $2=message
  if [ "$1" = "0" ]; then problem "$2"; else info "nested: $2"; fi
}

while IFS=$'\t' read -r sub indent line; do
  [ -n "$line" ] || continue

  if grep -qF -- '->' <<< "$line"; then
    problem "uses '->' instead of '→': $line"
  fi

  sym=$(entry_sym "$line")
  name=$(entry_name "$line")
  case "$sym" in
    arrow_up) re='^(  )?- :arrow_up: (plugin: )?\[[^]]+\]\([^)]+\) `[^`]+` → `[^`]+`( :warning:)?$' ;;
    sparkle)  re='^(  )?- :sparkle: (plugin: )?\[[^]]+\]\([^)]+\) `[^`]+`( :warning:)?$' ;;
    x)        re='^(  )?- :x: (plugin: )?\[[^]]+\]\([^)]+\)( :warning:)?$' ;;
    memo)     re='^(  )?- :memo: (plugin: )?\[[^]]+\]\([^)]+\) .+$' ;;
    *)        problem "unknown/missing symbol: $line"; continue ;;
  esac
  if ! grep -qE "$re" <<< "$line"; then
    problem "bad $sym entry format: $line"
    continue
  fi

  key="$sub|$name"
  norm_var "$name"; nname="$REPLY"
  case "$sym" in
    arrow_up)
      vers=$(entry_vers "$line")
      old=$(sed -n 1p <<< "$vers")
      new=$(sed -n 2p <<< "$vers")
      matched=""
      if map_has CHG_OLD "$key"; then
        matched="$key"
      else
        while IFS= read -r k; do
          [ -n "$k" ] || continue
          [ "${k%%|*}" = "$sub" ] || continue
          norm_var "${k#*|}"
          if [ "$REPLY" = "$nname" ]; then matched="$k"; break; fi
        done <<< "$chg_keys"
      fi
      if [ -n "$matched" ]; then
        # a mismatch on an alias that exists is always fatal — including for
        # nested BOM-component entries, whose versions are hand-written
        map_get CHG_OLD "$matched"; mold="$REPLY"
        map_get CHG_NEW "$matched"; mnew="$REPLY"
        if [ "$mold" != "$old" ] || [ "$mnew" != "$new" ]; then
          problem "$sub/$name: entry says \`$old\` → \`$new\` but diff says $mold → $mnew"
        fi
      else
        pair=0
        while IFS= read -r k; do
          [ -n "$k" ] || continue
          [ "${k%%|*}" = "$sub" ] || continue
          map_get CHG_OLD "$k"; ko="$REPLY"; map_get CHG_NEW "$k"; kn="$REPLY"
          if [ "$ko" = "$old" ] && [ "$kn" = "$new" ]; then pair=1; break; fi
        done <<< "$chg_keys"
        if [ "$pair" -eq 0 ]; then
          if map_has OLDV "$key" || map_has NEWV "$key"; then
            soft "$indent" "$sub/$name: phantom entry — alias exists but \`$old\` → \`$new\` is not in the branch diff"
          else
            info "$sub/$name: no matching version alias — not cross-checked (BOM component?)"
          fi
        fi
      fi
      ;;
    sparkle)
      v=$(sed -n 1p <<< "$(entry_vers "$line")")
      map_get DIFF_ADD "$sub"; dadd="$REPLY"
      if map_has ADDEDV "$key"; then
        map_get ADDEDV "$key"; av="$REPLY"
        [ "$av" = "$v" ] \
          || problem "$sub/$name: entry says \`$v\` but added alias has $av"
      elif grep -qF "\"$v\"" <<< "$dadd"; then
        : # version literal present in the added diff lines
      elif grep -qiF "$name" <<< "$dadd"; then
        : # library added reusing an existing version alias
      else
        soft "$indent" "$sub/$name: :sparkle: entry but nothing matching added in $sub catalog diff"
      fi
      ;;
    x)
      matched=0
      map_get DIFF_DEL "$sub"; ddel="$REPLY"
      if map_has REMOVEDV "$key"; then
        matched=1
      else
        while IFS= read -r k; do
          [ -n "$k" ] || continue
          [ "${k%%|*}" = "$sub" ] || continue
          norm_var "${k#*|}"
          if [ "$REPLY" = "$nname" ]; then matched=1; break; fi
        done <<< "$rem_keys"
        grep -qiF "$name" <<< "$ddel" && matched=1
      fi
      [ "$matched" -eq 1 ] \
        || soft "$indent" "$sub/$name: :x: entry but nothing matching removed in $sub catalog diff"
      ;;
  esac
done <<< "$new_ann"

# ---------- coverage: every catalog change must be documented ------------------

find_entry() { # $1=sub $2=grep-pattern (fixed string) -> 0 if some new entry matches
  local es ei el
  while IFS=$'\t' read -r es ei el; do
    [ -n "$el" ] || continue
    [ "$es" = "$1" ] || continue
    grep -qF -- "$2" <<< "$el" && return 0
  done <<< "$new_ann"
  return 1
}

find_entry_by_name() { # $1=sub $2=alias (matches top-level AND nested entries)
  local es ei el en want
  norm_var "$2"; want="$REPLY"
  while IFS=$'\t' read -r es ei el; do
    [ -n "$el" ] || continue
    [ "$es" = "$1" ] || continue
    en=$(entry_name "$el")
    [ -n "$en" ] || continue
    norm_var "$en"
    [ "$REPLY" = "$want" ] && return 0
  done <<< "$new_ann"
  return 1
}

while IFS= read -r k; do
  [ -n "$k" ] || continue
  sub="${k%%|*}"; a="${k#*|}"
  find_entry_by_name "$sub" "$a" && continue
  map_get CHG_OLD "$k"; o="$REPLY"; map_get CHG_NEW "$k"; n="$REPLY"
  # a version pair stands in for the name only when no other alias in this
  # subsection moved between the very same versions (compose-* move in lockstep)
  map_get PAIRCNT "$sub|$o|$n"; cnt="${REPLY:-0}"
  if [ "$cnt" -le 1 ] && find_entry "$sub" "\`$o\` → \`$n\`"; then
    info "$sub $a: documented by version pair only — entry name differs from the alias"
    continue
  fi
  problem "not documented: $sub $a $o → $n"
done <<< "$chg_keys"

while IFS= read -r k; do
  [ -n "$k" ] || continue
  sub="${k%%|*}"; a="${k#*|}"
  find_entry_by_name "$sub" "$a" && continue
  map_get ADDEDV "$k"; v="$REPLY"
  map_get ADDCNT "$sub|$v"; cnt="${REPLY:-0}"
  if [ "$cnt" -le 1 ] && find_entry "$sub" "\`$v\`"; then
    info "$sub $a: documented by version only — entry name differs from the alias"
    continue
  fi
  problem "not documented (added): $sub $a $v"
done <<< "$add_keys"

while IFS= read -r k; do
  [ -n "$k" ] || continue
  sub="${k%%|*}"; a="${k#*|}"
  find_entry_by_name "$sub" "$a" \
    || problem "not documented (removed): $sub $a — needs a :x: or :memo: entry"
done <<< "$rem_keys"

# module/plugin-id level coverage: catches an alias added while reusing an
# existing version alias, an alias dropped, and a pure module rename (module
# changed, version untouched — invisible in the [versions] diff)
map_keys NEWM; newm_keys="$REPLY"
map_keys OLDM; oldm_keys="$REPLY"

while IFS= read -r k; do
  [ -n "$k" ] || continue
  sub="${k%%|*}"; a="${k#*|}"
  map_get NEWM "$k"; nm="$REPLY"
  if ! map_has OLDM "$k"; then
    find_entry_by_name "$sub" "$a" \
      || problem "not documented (new alias): $sub $a = $nm — needs a :sparkle: entry"
  else
    map_get OLDM "$k"; om="$REPLY"
    if [ "$om" != "$nm" ]; then
      find_entry_by_name "$sub" "$a" \
        || problem "not documented (module changed): $sub $a $om → $nm — needs a :memo: entry"
    fi
  fi
done <<< "$newm_keys"

while IFS= read -r k; do
  [ -n "$k" ] || continue
  map_has NEWM "$k" && continue
  sub="${k%%|*}"; a="${k#*|}"
  find_entry_by_name "$sub" "$a" \
    || problem "not documented (alias removed): $sub $a — needs a :x: or :memo: entry"
done <<< "$oldm_keys"

# ---------- sorting -------------------------------------------------------------

# nested (BOM-component) entries must be sorted within their parent entry
check_nested() { # uses/clears $nested, reports against $s/$parent
  [ -n "$nested" ] || return 0
  if ! LC_ALL=C sort -fc <<< "${nested%$NL}" 2>/dev/null; then
    problem "$s: nested entries under '$parent' are not sorted alphabetically"
  fi
  nested=""
}

for s in red_mad_robot AndroidX Stack; do
  body=$(awk -v s="### $s" '$0==s{f=1;next} /^### /{f=0} f' <<< "$head_unrel")
  libs=""; plugs=""; seen_plug=0; parent=""; nested=""
  while IFS= read -r line; do
    if grep -qE '^  - :' <<< "$line"; then
      n=$(entry_name "$line"); [ -n "$n" ] && nested="$nested$n$NL"
      continue
    fi
    check_nested
    grep -qE '^- :' <<< "$line" || continue
    n=$(entry_name "$line"); [ -n "$n" ] || continue
    parent="$n"
    if grep -qE '^- :[a-z_]+: plugin: ' <<< "$line"; then
      seen_plug=1; plugs="$plugs$n$NL"
    else
      [ "$seen_plug" -eq 1 ] && problem "$s: library entry after plugin entries: $line"
      libs="$libs$n$NL"
    fi
  done <<< "$body"
  check_nested
  for group in libs plugs; do
    names="${!group}"
    names="${names%$NL}"   # <<< would add an empty last line otherwise
    [ -n "$names" ] || continue
    if ! LC_ALL=C sort -fc <<< "$names" 2>/dev/null; then
      problem "$s: ${group%s} entries are not sorted alphabetically"
    fi
  done
done

# ---------- renovate branches picked --------------------------------------------

# Per renovate branch: compare the [versions] aliases it bumps with what the
# working branch actually has. A branch whose alias sits at an EQUAL version is
# picked; at a NEWER version it was superseded by another branch (INFO, not a
# problem); anything else is genuinely not picked.
if [ "$skip_renovate" -eq 0 ]; then
  branch_added=$(git diff origin/main..HEAD | grep -E '^\+[^+]' || true)
  for b in $(git for-each-ref --format='%(refname:short)' 'refs/remotes/origin/renovate/*' | sort); do
    [ "$(git rev-list --count "origin/main..$b")" -gt 0 ] || continue
    short="${b#origin/renovate/}"

    bump_lines=""
    for f in versions-*/libs.versions.toml; do
      sub=$(sub_of_dir "${f%%/*}"); [ -n "$sub" ] || continue
      while IFS=$'\t' read -r a v; do
        [ -n "$a" ] && bump_lines="$bump_lines$sub$TAB$a$TAB$v$NL"
      done < <(git diff "origin/main...$b" -- "$f" | diff_added_versions)
    done

    if [ -n "$bump_lines" ]; then
      while IFS=$'\t' read -r sub a v; do
        [ -n "$a" ] || continue
        map_get NEWV "$sub|$a"; cur="$REPLY"
        if [ "$cur" = "$v" ]; then
          continue
        elif [ -n "$cur" ] && vge "$cur" "$v"; then
          info "renovate: $short superseded — $sub $a is at $cur (branch bumps to $v)"
        else
          problem "renovate: $short not picked ($sub $a → $v missing; branch has ${cur:-<none>})"
        fi
      done <<< "$bump_lines"
    else
      # non-catalog branch (gradle wrapper, workflows): look for its own changes
      picked=0
      while IFS= read -r l; do
        [ -n "$l" ] || continue
        grep -qF -- "$l" <<< "$branch_added" && { picked=1; break; }
      done <<< "$(git diff "origin/main...$b" | grep -E '^\+[^+]' | grep -vE '^\+[[:space:]]*$' | head -50 || true)"
      [ "$picked" -eq 1 ] || problem "renovate: $short not picked (no catalog bump; none of its changes found in branch diff)"
    fi
  done
fi

# ---------- report ---------------------------------------------------------------

if [ "${#problems[@]}" -eq 0 ]; then
  echo "OK"
else
  for p in "${problems[@]}"; do echo "PROBLEM: $p"; done
  exit 1
fi
