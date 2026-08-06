#!/usr/bin/env bash
#
# Verify every documentation link added to CHANGELOG.md in the current release
# commit (HEAD). Replaces the old check-changelog-urls.sh and additionally does
# what SKILL.md step 9b used to ask the agent to do by hand:
#
#   1. host policy — a Maven artifact/repository listing is never a valid link;
#   2. version-specific — the URL itself must carry the entry's new version
#      (path, tag or #anchor), unless the alias is listed in known-doc-urls.tsv;
#   3. reachability — HTTP 2xx after redirects; a redirect to a different page is
#      reported (some sites answer 200 for missing pages);
#   4. version presence — the fetched page mentions the new version (accepting
#      dot/dash/underscore/no-separator variants and a leading `v`);
#   5. anchor exists — when the URL has a #fragment, the HTML really contains
#      that id/name (a wrong anchor is invisible otherwise: the fragment is
#      client-side and the page still answers 200).
#
# Checks 2, 4 and 5 are skipped for aliases listed in known-doc-urls.tsv with
# the matching flag — that file is the single place where "this vendor has no
# per-version page" is recorded.
#
#   bash check-doc-links.sh            # links added to CHANGELOG.md in HEAD
#   bash check-doc-links.sh --all      # every link in the [Unreleased] section
#
# Prints one line per entry, then a summary. Exits 1 if anything failed.
# READ-ONLY (network reads only).
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

mode="head"
[ "${1:-}" = "--all" ] && mode="all"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
known_file="$script_dir/known-doc-urls.tsv"

FORBIDDEN_HOSTS='mvnrepository\.com|search\.maven\.org|central\.sonatype\.com|maven\.google\.com|repo1\.maven\.org|plugins\.gradle\.org/m2|dl\.google\.com'

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# ---------- collect the entries to check --------------------------------------

if [ -n "${CHECK_DOC_LINKS_INPUT:-}" ]; then
  # test hook: check the entry lines from this file instead of the git history
  lines=$(cat "$CHECK_DOC_LINKS_INPUT")
elif [ "$mode" = "head" ]; then
  lines=$(git show HEAD -- CHANGELOG.md | sed -nE 's/^\+( *- :.*)$/\1/p' || true)
else
  lines=$(git show HEAD:CHANGELOG.md | awk '
    /^## \[Unreleased\]/ {u=1; next}
    /^## \[/ {u=0}
    u && /^ *- :/ {print}' || true)
fi

if [ -z "$lines" ]; then
  echo "No CHANGELOG entries with links to check${mode:+ ($mode)}."
  exit 0
fi

# ---------- helpers ------------------------------------------------------------

flags_for() { # $1 = entry name -> flags from known-doc-urls.tsv (first match)
  [ -f "$known_file" ] || return 0
  local name="$1" glob flags rest
  while IFS=$'\t' read -r glob _coord _tpl flags rest; do
    case "$glob" in ''|'#'*) continue ;; esac
    # shellcheck disable=SC2254 — $glob is intentionally a glob pattern
    case "$name" in $glob) echo "${flags:-}"; return 0 ;; esac
  done < "$known_file"
  return 0
}

has_flag() { grep -qw -- "$2" <<< "${1//,/ }"; }

version_variants() { # $1 = version
  local v="$1"
  printf '%s\n' "$v" "${v//./-}" "${v//./_}" "${v//./}" "v$v" | sort -u
}

problems=0
checked=0

# Hosts disagree about who may fetch them: Zendesk-based ones (AppsFlyer) answer
# 403 to a bare curl, while developer.android.com sends a browser UA into a
# consent redirect loop. So: plain request first, browser UA only as a retry.
UA='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0 Safari/537.36'

fetch() { # $1 = url -> prints "code<TAB>final-url<TAB>body-file"
  local url="$1" key body meta code
  key=$(cksum <<< "$url" | tr -d ' ')
  body="$tmp/body-$key"; meta="$tmp/meta-$key"
  if [ ! -f "$meta" ]; then
    curl -sL --max-time 25 --max-redirs 10 -o "$body" -w '%{http_code}\t%{url_effective}' "$url" > "$meta" 2>/dev/null \
      || printf '000\t%s' "$url" > "$meta"
    code=$(cut -f1 "$meta")
    case "$code" in
      2*) ;;
      *)  # retry pretending to be a browser
          curl -sL --max-time 25 --max-redirs 10 -A "$UA" -o "$body.ua" \
               -w '%{http_code}\t%{url_effective}' "$url" > "$meta.ua" 2>/dev/null \
            || printf '000\t%s' "$url" > "$meta.ua"
          if [[ "$(cut -f1 "$meta.ua")" == 2* ]]; then
            mv "$meta.ua" "$meta"; mv "$body.ua" "$body"
          fi
          rm -f "$meta.ua" "$body.ua"
          ;;
    esac
  fi
  printf '%s\t%s\n' "$(cat "$meta")" "$body"
}

# ---------- check each entry ---------------------------------------------------

while IFS= read -r line; do
  [ -n "$line" ] || continue
  grep -qF '*No changes*' <<< "$line" && continue

  name=$(sed -nE 's/^ *- :[a-z_]+: (plugin: )?\[([^]]+)\].*$/\2/p' <<< "$line")
  url=$(sed -nE 's/^ *- :[a-z_]+: (plugin: )?\[[^]]+\]\(([^)]+)\).*$/\2/p' <<< "$line")
  [ -n "$url" ] || { echo "PROBLEM  ${name:-?}  — no link in entry: $line"; problems=$((problems + 1)); continue; }
  # new version = last backticked value on the line (empty for :x: / :memo:)
  version=$(grep -oE '`[^`]+`' <<< "$line" | tr -d '`' | tail -1 || true)

  flags=$(flags_for "$name")
  checked=$((checked + 1))
  entry_problems=()
  notes=()

  # 1. host policy
  if grep -qiE "$FORBIDDEN_HOSTS" <<< "$url"; then
    entry_problems+=("forbidden host — a Maven artifact/repository page is not a documentation link")
  fi

  # 2. the URL must carry the version (unless exempted)
  if [ -n "$version" ] && ! has_flag "$flags" skip-version-check; then
    in_url=0
    while IFS= read -r cand; do
      grep -qiF -- "$cand" <<< "$url" && { in_url=1; break; }
    done < <(version_variants "$version")
    [ "$in_url" -eq 1 ] \
      || entry_problems+=("version-less URL — link must point at $version (tag, path or #anchor), or add the alias to known-doc-urls.tsv")
  fi

  # 3. reachability
  IFS=$'\t' read -r code final body < <(fetch "$url")
  if has_flag "$flags" skip-reachability; then
    notes+=("HTTP $code — reachability check skipped via known-doc-urls.tsv")
  else
    case "$code" in
      2*) ;;
      000) entry_problems+=("unreachable (network error / timeout)") ;;
      *)   entry_problems+=("HTTP $code — if the host blocks robots, add skip-reachability to known-doc-urls.tsv") ;;
    esac
  fi
  req_nofrag="${url%%#*}"; final_nofrag="${final%%#*}"
  if [ "${final_nofrag%/}" != "${req_nofrag%/}" ]; then
    notes+=("redirected to: $final_nofrag")
  fi

  if [ "$code" = "000" ] || [ ! -s "$body" ]; then
    :
  else
    # 4. version presence on the page
    if [ -n "$version" ] && ! has_flag "$flags" skip-version-check; then
      found=0
      while IFS= read -r cand; do
        grep -qiF -- "$cand" "$body" && { found=1; break; }
      done < <(version_variants "$version")
      [ "$found" -eq 1 ] \
        || entry_problems+=("page does not mention $version (wrong page, or JS-rendered → add the alias to known-doc-urls.tsv)")
    fi

    # 5. anchor exists
    frag="${url##*#}"
    if [ "$frag" != "$url" ] && [ -n "$frag" ] && ! has_flag "$flags" skip-anchor-check; then
      if ! grep -qiE "(id|name)=[\"']?${frag//./\\.}[\"' >]" "$body"; then
        entry_problems+=("anchor '#$frag' not found on the page (fragments are client-side — a wrong one still answers 200)")
      fi
    fi
  fi

  # NB: an empty array must never be expanded with "${a[@]}" — under `set -u`
  # bash 3.2 (macOS) treats that as an unbound variable and aborts.
  label="$name${version:+ $version}"
  if [ "${#entry_problems[@]}" -eq 0 ]; then
    printf 'OK       %s  %s' "$label" "$url"
    [ "${#notes[@]}" -gt 0 ] && printf '  (%s)' "${notes[0]}"
    printf '\n'
  else
    problems=$((problems + 1))
    printf 'PROBLEM  %s  %s\n' "$label" "$url"
    for p in "${entry_problems[@]}"; do printf '         → %s\n' "$p"; done
    if [ "${#notes[@]}" -gt 0 ]; then
      for n in "${notes[@]}"; do printf '         → %s\n' "$n"; done
    fi
  fi
done <<< "$lines"

echo
if [ "$problems" -eq 0 ]; then
  echo "OK — $checked link(s) verified"
else
  echo "$problems of $checked link(s) failed — fix them, re-amend with commit-release.sh and re-run."
  echo "If a vendor genuinely has no per-version page (or renders it with JS), add the"
  echo "alias to $known_file instead of downgrading the link."
  exit 1
fi
