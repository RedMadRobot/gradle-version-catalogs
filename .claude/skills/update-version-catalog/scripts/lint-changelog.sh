#!/usr/bin/env bash
#
# Cross-check the [Unreleased] section of CHANGELOG.md against the actual
# catalog changes of the working branch (origin/main..HEAD) and the format
# rules from SKILL.md:
#
#   - every catalog version change is documented in the right subsection with
#     exact `old` → `new` versions; added deps have :sparkle:, removed :x:;
#   - no phantom entries (documenting a change that is not in the diff);
#   - valid symbols, markdown links, real arrow "→" (never "->"), versions in
#     backticks, plugin: prefix format;
#   - sorting (libraries alphabetically, then plugin: entries alphabetically;
#     nested BOM-component entries sorted within their parent),
#     no duplicates, all three subsections present, no stray "*No changes*";
#   - every renovate branch's topic version made it into the branch diff
#     (skip with --skip-renovate in add-only sessions).
#
# Prints PROBLEM lines and exits 1, or prints OK. INFO lines are advisory.
# READ-ONLY. Usage: bash lint-changelog.sh [--skip-renovate]
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

skip_renovate=0
[ "${1:-}" = "--skip-renovate" ] && skip_renovate=1

problems=()
problem() { problems+=("$1"); }
info() { echo "INFO: $1"; }

norm() { local s="${1,,}"; echo "${s//[^a-z0-9]/}"; }

# ---------- catalog changes on the branch (origin/main..HEAD) ---------------

declare -A OLDV NEWV            # "<sub>|<alias>" -> version
declare -A CHG_OLD CHG_NEW      # updated aliases
declare -A ADDEDV REMOVEDV      # added / removed aliases
declare -A DIFF_ADD DIFF_DEL    # per subsection: raw added/removed diff lines

sub_of_dir() {
  case "$1" in
    versions-androidx)    echo "AndroidX" ;;
    versions-redmadrobot) echo "red_mad_robot" ;;
    versions-stack)       echo "Stack" ;;
    *)                    echo "" ;;
  esac
}

versions_map() { # $1=rev $2=file -> "alias<TAB>version" lines from [versions]
  git show "$1:$2" 2>/dev/null \
    | sed -nE '/^\[versions\]/,/^\[(libraries|plugins|bundles)\]/p' \
    | sed -nE 's/^([A-Za-z0-9_.-]+)[[:space:]]*=[[:space:]]*"([^"]+)".*$/\1\t\2/p'
}

for f in versions-*/libs.versions.toml; do
  sub=$(sub_of_dir "${f%%/*}"); [ -n "$sub" ] || continue
  while IFS=$'\t' read -r a v; do
    [ -n "$a" ] && OLDV["$sub|$a"]="$v"
  done < <(versions_map origin/main "$f")
  while IFS=$'\t' read -r a v; do
    [ -n "$a" ] && NEWV["$sub|$a"]="$v"
  done < <(versions_map HEAD "$f")
  DIFF_ADD["$sub"]=$(git diff origin/main..HEAD -- "$f" | grep -E '^\+[^+]' || true)
  DIFF_DEL["$sub"]=$(git diff origin/main..HEAD -- "$f" | grep -E '^-[^-]' || true)
done

for k in "${!NEWV[@]}"; do
  if [ "${OLDV[$k]+x}" = x ]; then
    if [ "${OLDV[$k]}" != "${NEWV[$k]}" ]; then
      CHG_OLD["$k"]="${OLDV[$k]}"; CHG_NEW["$k"]="${NEWV[$k]}"
    fi
  else
    ADDEDV["$k"]="${NEWV[$k]}"
  fi
done
for k in "${!OLDV[@]}"; do
  [ "${NEWV[$k]+x}" = x ] || REMOVEDV["$k"]="${OLDV[$k]}"
done

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

  # diff cross-check — top-level entries only (nested = BOM components)
  [ "$indent" = "0" ] || continue
  key="$sub|$name"
  case "$sym" in
    arrow_up)
      old=$(sed -n 1p <<< "$(entry_vers "$line")")
      new=$(sed -n 2p <<< "$(entry_vers "$line")")
      matched=""
      if [ "${CHG_OLD[$key]+x}" = x ]; then
        matched="$key"
      else
        for k in "${!CHG_OLD[@]}"; do
          [ "${k%%|*}" = "$sub" ] || continue
          [ "$(norm "${k#*|}")" = "$(norm "$name")" ] && { matched="$k"; break; }
        done
      fi
      if [ -n "$matched" ]; then
        if [ "${CHG_OLD[$matched]}" != "$old" ] || [ "${CHG_NEW[$matched]}" != "$new" ]; then
          problem "$sub/$name: entry says \`$old\` → \`$new\` but diff says ${CHG_OLD[$matched]} → ${CHG_NEW[$matched]}"
        fi
      else
        pair=0
        for k in "${!CHG_OLD[@]}"; do
          [ "${k%%|*}" = "$sub" ] && [ "${CHG_OLD[$k]}" = "$old" ] && [ "${CHG_NEW[$k]}" = "$new" ] && { pair=1; break; }
        done
        if [ "$pair" -eq 0 ]; then
          if [ "${OLDV[$key]+x}" = x ] || [ "${NEWV[$key]+x}" = x ]; then
            problem "$sub/$name: phantom entry — alias exists but \`$old\` → \`$new\` is not in the branch diff"
          else
            info "$sub/$name: no matching version alias — not cross-checked (BOM component?)"
          fi
        fi
      fi
      ;;
    sparkle)
      v=$(sed -n 1p <<< "$(entry_vers "$line")")
      if [ "${ADDEDV[$key]+x}" = x ]; then
        [ "${ADDEDV[$key]}" = "$v" ] \
          || problem "$sub/$name: entry says \`$v\` but added alias has ${ADDEDV[$key]}"
      elif grep -qF "\"$v\"" <<< "${DIFF_ADD[$sub]:-}"; then
        : # version literal present in the added diff lines
      elif grep -qiF "$name" <<< "${DIFF_ADD[$sub]:-}"; then
        : # library added reusing an existing version alias
      else
        problem "$sub/$name: :sparkle: entry but nothing matching added in $sub catalog diff"
      fi
      ;;
    x)
      matched=0
      if [ "${REMOVEDV[$key]+x}" = x ]; then
        matched=1
      else
        for k in "${!REMOVEDV[@]}"; do
          [ "${k%%|*}" = "$sub" ] || continue
          [ "$(norm "${k#*|}")" = "$(norm "$name")" ] && { matched=1; break; }
        done
        grep -qiF "$name" <<< "${DIFF_DEL[$sub]:-}" && matched=1
      fi
      [ "$matched" -eq 1 ] \
        || problem "$sub/$name: :x: entry but nothing matching removed in $sub catalog diff"
      ;;
  esac
done <<< "$new_ann"

# ---------- coverage: every catalog change must be documented ------------------

find_entry() { # $1=sub $2=grep-pattern (fixed string) -> 0 if some new entry matches
  while IFS=$'\t' read -r es ei el; do
    [ -n "$el" ] || continue
    [ "$es" = "$1" ] || continue
    grep -qF -- "$2" <<< "$el" && return 0
  done <<< "$new_ann"
  return 1
}

find_entry_by_name() { # $1=sub $2=alias
  while IFS=$'\t' read -r es ei el; do
    [ -n "$el" ] || continue
    [ "$es" = "$1" ] || continue
    en=$(entry_name "$el")
    [ -n "$en" ] && [ "$(norm "$en")" = "$(norm "$2")" ] && return 0
  done <<< "$new_ann"
  return 1
}

for k in "${!CHG_OLD[@]}"; do
  sub="${k%%|*}"; a="${k#*|}"
  find_entry "$sub" "\`${CHG_OLD[$k]}\` → \`${CHG_NEW[$k]}\`" && continue
  find_entry_by_name "$sub" "$a" && continue
  problem "not documented: $sub $a ${CHG_OLD[$k]} → ${CHG_NEW[$k]}"
done
for k in "${!ADDEDV[@]}"; do
  sub="${k%%|*}"; a="${k#*|}"
  find_entry "$sub" "\`${ADDEDV[$k]}\`" && continue
  find_entry_by_name "$sub" "$a" && continue
  problem "not documented (added): $sub $a ${ADDEDV[$k]}"
done
for k in "${!REMOVEDV[@]}"; do
  sub="${k%%|*}"; a="${k#*|}"
  find_entry_by_name "$sub" "$a" \
    || problem "not documented (removed): $sub $a — needs a :x: or :memo: entry"
done

# ---------- sorting -------------------------------------------------------------

# nested (BOM-component) entries must be sorted within their parent entry
check_nested() { # uses/clears $nested, reports against $s/$parent
  [ -n "$nested" ] || return 0
  if ! LC_ALL=C sort -fc <<< "${nested%$'\n'}" 2>/dev/null; then
    problem "$s: nested entries under '$parent' are not sorted alphabetically"
  fi
  nested=""
}

for s in red_mad_robot AndroidX Stack; do
  body=$(awk -v s="### $s" '$0==s{f=1;next} /^### /{f=0} f' <<< "$head_unrel")
  libs=""; plugs=""; seen_plug=0; parent=""; nested=""
  while IFS= read -r line; do
    if grep -qE '^  - :' <<< "$line"; then
      n=$(entry_name "$line"); [ -n "$n" ] && nested+="$n"$'\n'
      continue
    fi
    check_nested
    grep -qE '^- :' <<< "$line" || continue
    n=$(entry_name "$line"); [ -n "$n" ] || continue
    parent="$n"
    if grep -qE '^- :[a-z_]+: plugin: ' <<< "$line"; then
      seen_plug=1; plugs+="$n"$'\n'
    else
      [ "$seen_plug" -eq 1 ] && problem "$s: library entry after plugin entries: $line"
      libs+="$n"$'\n'
    fi
  done <<< "$body"
  check_nested
  for group in libs plugs; do
    names="${!group}"
    names="${names%$'\n'}"   # <<< would add an empty last line otherwise
    [ -n "$names" ] || continue
    if ! LC_ALL=C sort -fc <<< "$names" 2>/dev/null; then
      problem "$s: ${group%s} entries are not sorted alphabetically"
    fi
  done
done

# ---------- renovate branches picked --------------------------------------------

if [ "$skip_renovate" -eq 0 ]; then
  branch_added=$(git diff origin/main..HEAD | grep -E '^\+[^+]' || true)
  for b in $(git for-each-ref --format='%(refname:short)' 'refs/remotes/origin/renovate/*' | sort); do
    [ "$(git rev-list --count "origin/main..$b")" -gt 0 ] || continue
    short="${b#origin/renovate/}"
    versions=$(git log --format='%s' "origin/main..$b" \
      | awk '{t=$NF} t ~ /[0-9]/ {sub(/^v/,"",t); print t}' | sort -u)
    if [ -n "$versions" ]; then
      while IFS= read -r v; do
        [ -n "$v" ] || continue
        grep -qF -- "$v" <<< "$branch_added" \
          || problem "renovate: $short not picked (version $v not in branch diff)"
      done <<< "$versions"
    else
      picked=0
      while IFS= read -r l; do
        [ -n "$l" ] || continue
        grep -qF -- "$l" <<< "$branch_added" && { picked=1; break; }
      done <<< "$(git diff "origin/main...$b" | grep -E '^\+[^+]' | grep -vE '^\+\s*$' | head -50 || true)"
      [ "$picked" -eq 1 ] || problem "renovate: $short not picked (no topic version; none of its changes found in branch diff)"
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
