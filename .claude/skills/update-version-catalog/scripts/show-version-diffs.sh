#!/usr/bin/env bash
#
# Show the catalog version diffs contained in the release commit (HEAD):
# a compact per-file list of changed lines (old version = "-" lines, new
# version = "+" lines), an automatic version-FORMAT guard, and the full patch
# for context (renames, [libraries]/[plugins] edits).
#
# The format guard implements SKILL.md step 4: it flags every alias whose new
# version has a different SHAPE than the old one (pre-release suffix appeared or
# disappeared, semver → calendar, plain → dash-compound, segment count changed
# without shared leading segments). A flagged bump must be confirmed by the
# maintainer before it is documented. Merely gaining or losing a trailing patch
# segment (2.60 → 2.60.1) is not a format change.
#
# READ-ONLY. Usage: bash show-version-diffs.sh
# Portable to macOS (bash 3.2 + BSD userland) — see lib.sh.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

echo "Release commit: $(git log --oneline -1 HEAD)"
echo

patch=$(git show HEAD --format= -- 'versions-*/libs.versions.toml')
if [ -z "$patch" ]; then
  echo "No catalog changes in HEAD."
  exit 0
fi

echo "=== changed lines ==="
grep -E '^(diff --git|[-+][^-+])' <<< "$patch"
echo

# ---------- version format guard ------------------------------------------------

num_head() { sed -E 's/^([0-9]+(\.[0-9]+)*).*$/\1/' <<< "$1"; }

suffix_class() { # "" | prerelease | numeric | other
  local s="$1"
  [ -z "$s" ] && { echo ""; return; }
  if [[ "$s" =~ ^[-._+]?[A-Za-z] ]]; then echo "prerelease"
  elif [[ "$s" =~ ^[-._+][0-9] ]]; then echo "numeric"
  else echo "other"; fi
}

is_calendar() { # first segment looks like a year
  local first="${1%%.*}"
  [ "${#first}" -eq 4 ] && [ "$first" -ge 2000 ] 2>/dev/null
}

format_reason() { # $1=old $2=new -> reason if the format changed, else nothing
  local o="$1" n="$2" oh nh os ns oc nc
  oh=$(num_head "$o"); nh=$(num_head "$n")
  os="${o#"$oh"}";     ns="${n#"$nh"}"
  oc=$(suffix_class "$os"); nc=$(suffix_class "$ns")

  if [ "$oc" != "$nc" ]; then
    if [ -z "$oc" ]; then echo "suffix '$ns' appeared"; else
      if [ -z "$nc" ]; then echo "suffix '$os' disappeared"; else echo "suffix kind changed ($oc → $nc)"; fi
    fi
    return
  fi
  if is_calendar "$oh" && ! is_calendar "$nh"; then echo "calendar → plain version"; return; fi
  if ! is_calendar "$oh" && is_calendar "$nh"; then echo "plain → calendar version"; return; fi

  local -a oa na
  IFS='.' read -r -a oa <<< "$oh"
  IFS='.' read -r -a na <<< "$nh"
  if [ "${#oa[@]}" -ne "${#na[@]}" ]; then
    local min="${#oa[@]}"; [ "${#na[@]}" -lt "$min" ] && min="${#na[@]}"
    local i
    for ((i = 0; i < min; i++)); do
      if [ "${oa[$i]}" != "${na[$i]}" ]; then
        echo "segment count changed (${#oa[@]} → ${#na[@]}) and the leading segments differ"
        return
      fi
    done
  fi
}

# pair "-alias = version" with "+alias = version" from the [versions] sections
while IFS=$'\t' read -r a v; do
  [ -n "$a" ] && map_put POLD "$a" "$v"
done < <(grep -E '^-[^-]' <<< "$patch" | sed 's/^-/+/' | diff_added_versions || true)
while IFS=$'\t' read -r a v; do
  [ -n "$a" ] && map_put PNEW "$a" "$v"
done < <(diff_added_versions <<< "$patch" || true)

echo "=== version format guard ==="
flagged=0
map_keys PNEW; pnew_keys="$REPLY"
while IFS= read -r a; do
  [ -n "$a" ] || continue
  map_has POLD "$a" || continue                # added dependency — guard N/A
  map_get POLD "$a"; o="$REPLY"
  map_get PNEW "$a"; n="$REPLY"
  [ "$o" = "$n" ] && continue
  reason=$(format_reason "$o" "$n")
  if [ -n "$reason" ]; then
    echo "FORMAT_CHANGE  $a  $o → $n  ($reason)"
    flagged=$((flagged + 1))
  fi
done <<< "$(LC_ALL=C sort <<< "$pnew_keys")"
if [ "$flagged" -eq 0 ]; then
  echo "OK — no version-format changes"
else
  echo
  echo "$flagged bump(s) changed the version FORMAT. Per SKILL.md step 4, STOP and ask"
  echo "the maintainer to confirm each of them (showing old → new) before documenting."
fi
echo

echo "=== full patch ==="
printf '%s\n' "$patch"
