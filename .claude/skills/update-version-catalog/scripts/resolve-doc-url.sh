#!/usr/bin/env bash
#
# Resolve the documentation URL for a dependency — never invent it.
#
#   bash resolve-doc-url.sh <group:artifact> <version>
#
# For a Gradle plugin pass its marker artifact:
#   <plugin.id>:<plugin.id>.gradle.plugin
#
# Resolution order (matches SKILL.md step 6 / "Adding a new dependency" step 5):
#   1. known-doc-urls.tsv — if the coordinates are listed there, its URL
#      template wins (that is where deps whose docs have no per-version page
#      live, e.g. AppsFlyer / Firebase BOM).
#   2. Read the HomePage of the artifact from its POM (<url>, falling back to
#      <scm>) in Google Maven / Maven Central / the Gradle Plugin Portal.
#   3. If the HomePage is a GitHub repository, look for a TAG matching <version>
#      via `git ls-remote --tags` — no API, no rate limit — and print its
#      /releases/tag/<tag> page (which is the release page when a release
#      exists). The GitHub API is only a fallback when ls-remote is unavailable.
#   4. If no matching tag exists, print the repository HomePage itself.
#   5. If the HomePage is not GitHub, print it verbatim.
#
# Prints one verdict line:
#   KNOWN     <url>   from known-doc-urls.tsv (use as-is)
#   RELEASE   <url>   github release page for the version (best)
#   TAG       <url>   github tag/release page for the version
#   HOMEPAGE  <url>   repo/home page, no per-version release or tag found
#   NO_HOMEPAGE      POM has no <url>/<scm> (common for plugin markers — use
#                    the Gradle Plugin Portal route in SKILL.md, then re-run
#                    with the real group:artifact)
#   NOT_FOUND        artifact POM is in no repository
#   GH_RATE_LIMITED <repo-url>   the GitHub API fallback was rate limited and
#                    ls-remote was unavailable — NOT the same as "no release
#                    exists"; set GITHUB_TOKEN/GH_TOKEN (or wait) and re-run
#
# A GitHub token in $GITHUB_TOKEN / $GH_TOKEN is used by the API fallback if
# present but is not required. READ-ONLY.
set -euo pipefail

[ "$#" -eq 2 ] || { echo "Usage: bash resolve-doc-url.sh <group:artifact> <version>"; exit 1; }

coord="$1"; version="$2"
group="${coord%%:*}"; artifact="${coord#*:}"
if [ -z "$group" ] || [ -z "$artifact" ] || [ "$group" = "$coord" ]; then
  echo "ERROR: '$coord' is not of the form group:artifact"; exit 1
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
known_file="$script_dir/known-doc-urls.tsv"

# --- 0. known-doc-urls.tsv --------------------------------------------------
# columns: alias-glob<TAB>coordinate-glob<TAB>url-template<TAB>flags
# first row whose coordinate-glob matches wins; template "-" means "no template,
# resolve as usual" (the row only carries verification flags for check-doc-links)
if [ -f "$known_file" ]; then
  while IFS=$'\t' read -r _alias cglob tpl _flags; do
    case "${_alias:-}" in ''|'#'*) continue ;; esac
    [ -n "${cglob:-}" ] || continue
    # shellcheck disable=SC2254 — $cglob is intentionally a glob pattern
    case "$coord" in
      $cglob)
        [ "${tpl:-}" = "-" ] && break        # flags only — resolve normally
        [ -n "${tpl:-}" ] || break
        url="${tpl//\{version\}/$version}"
        url="${url//\{version-dashes\}/${version//./-}}"
        url="${url//\{version-nodots\}/${version//./}}"
        echo "KNOWN  $url"
        exit 0
        ;;
    esac
  done < "$known_file"
fi

# --- 1. fetch the POM and read its HomePage --------------------------------
fetch_pom() { # $1 = repo base url
  curl -sfL --max-time 20 \
    "$1/${group//./\/}/$artifact/$version/$artifact-$version.pom" 2>/dev/null || true
}

pom=""
while read -r _name base; do
  pom=$(fetch_pom "$base")
  [ -n "$pom" ] && break
done <<'EOF'
google         https://dl.google.com/android/maven2
maven-central  https://repo1.maven.org/maven2
plugin-portal  https://plugins.gradle.org/m2
EOF

if [ -z "$pom" ]; then
  echo "NOT_FOUND"
  exit 1
fi

# Project <url> first, then <scm><url>/<connection>. Take the first <url> that
# is not the parent/license block — simplest robust heuristic: prefer a github
# URL anywhere in the POM, else the first project-level <url>.
homepage=$(grep -oE '<url>[^<]+</url>' <<< "$pom" | sed -E 's#</?url>##g' \
  | grep -iE 'github\.com' | head -1 || true)
if [ -z "$homepage" ]; then
  homepage=$(grep -oE '<connection>[^<]+</connection>' <<< "$pom" \
    | sed -E 's#</?connection>##g; s#^scm:git:##; s#\.git$##' \
    | grep -iE 'github\.com' | head -1 || true)
fi
if [ -z "$homepage" ]; then
  # non-github project url (take the first <url> that is not a license/apache one)
  homepage=$(grep -oE '<url>[^<]+</url>' <<< "$pom" | sed -E 's#</?url>##g' \
    | grep -ivE 'apache\.org|opensource\.org|license' | head -1 || true)
fi

if [ -z "$homepage" ]; then
  echo "NO_HOMEPAGE"
  exit 1
fi

# resolve redirects so the printed URL is the canonical one (e.g. the old
# JetBrains/compose-jb home redirects to JetBrains/compose-multiplatform) — a
# stored redirecting URL would trip check-doc-links.sh.
canonical() { # $1 = url
  local final
  final=$(curl -s -o /dev/null -L --max-time 15 -w '%{url_effective}' "$1" 2>/dev/null) || final="$1"
  echo "${final%/}"
}

# --- 2. non-github homepage: return as-is ----------------------------------
if ! grep -qiE 'github\.com' <<< "$homepage"; then
  echo "HOMEPAGE  $(canonical "$homepage")"
  exit 0
fi

# normalise to github.com/{org}/{repo}
slug=$(sed -E 's#^.*github\.com[/:]+##; s#\.git$##; s#/+$##' <<< "$homepage")
org="${slug%%/*}"; repo=$(cut -d/ -f2 <<< "$slug")
if [ -z "$org" ] || [ -z "$repo" ] || [ "$org" = "$slug" ]; then
  echo "HOMEPAGE  $(canonical "https://github.com/$slug")"
  exit 0
fi
# canonicalise the repo once (e.g. compose-jb → compose-multiplatform) so both
# the tag lookup and the printed release/tag URLs use the real repo.
repo_url=$(canonical "https://github.com/$org/$repo")
slug=$(sed -E 's#^.*github\.com[/:]+##; s#\.git$##; s#/+$##' <<< "$repo_url")
org="${slug%%/*}"; repo=$(cut -d/ -f2 <<< "$slug")

# --- 3. look for a tag / release matching the version ----------------------
vesc=$(sed -E 's/[.]/\\./g' <<< "$version")
# a tag matches the version if, ignoring an optional leading `v` and any
# `prefix-`/`prefix_`/`prefix/` before it, it equals the version exactly.
# `.` is excluded from the boundary so version 2.60 does not match tag 1.2.60.
tag_matches='(^|[^0-9.])v?'"$vesc"'$'

# of several matching tags prefer the plainest: exact version, then v<version>,
# then the shortest name (e.g. `2.60` over `dagger-parent-2.60`)
pick_tag() { # stdin = candidate tag names
  awk -v v="$version" '
    { c[NR] = $0 }
    END {
      for (i = 1; i <= NR; i++) if (c[i] == v)       { print c[i]; exit }
      for (i = 1; i <= NR; i++) if (c[i] == "v" v)   { print c[i]; exit }
      best = ""
      for (i = 1; i <= NR; i++) if (best == "" || length(c[i]) < length(best)) best = c[i]
      if (best != "") print best
    }'
}

# 3a. ls-remote: no API, no rate limit
ls_tags=$(git ls-remote --tags "$repo_url" 2>/dev/null \
  | sed -E 's#^.*refs/tags/##; s#\^\{\}$##' | sort -u || true)
if [ -n "$ls_tags" ]; then
  tag=$(grep -E "$tag_matches" <<< "$ls_tags" | pick_tag || true)
  if [ -n "$tag" ]; then
    echo "TAG  $repo_url/releases/tag/$tag"
    exit 0
  fi
  echo "HOMEPAGE  $repo_url"
  exit 0
fi

# 3b. fallback: GitHub API (only when ls-remote could not run at all)
gh_api() { # $1 = path (no -f: the rate-limit error body must stay readable)
  # no array for the auth header: expanding an EMPTY "${arr[@]}" aborts under
  # `set -u` in the bash 3.2 that macOS ships
  local token="${GITHUB_TOKEN:-${GH_TOKEN:-}}"
  if [ -n "$token" ]; then
    curl -sL --max-time 20 -H "Authorization: Bearer $token" \
      -H 'Accept: application/vnd.github+json' \
      "https://api.github.com/repos/$org/$repo/$1" 2>/dev/null || true
  else
    curl -sL --max-time 20 \
      -H 'Accept: application/vnd.github+json' \
      "https://api.github.com/repos/$org/$repo/$1" 2>/dev/null || true
  fi
}
rate_limited() { grep -qi 'rate limit exceeded' <<< "$1"; }

releases=$(gh_api "releases?per_page=100")
if rate_limited "$releases"; then
  echo "GH_RATE_LIMITED  $repo_url"
  exit 1
fi
rel_tag=$(grep -oE '"tag_name":[[:space:]]*"[^"]+"' <<< "$releases" \
  | sed -E 's/.*"tag_name":[[:space:]]*"([^"]+)"/\1/' \
  | grep -E "$tag_matches" | pick_tag || true)
if [ -n "$rel_tag" ]; then
  echo "RELEASE  $repo_url/releases/tag/$rel_tag"
  exit 0
fi

tags=$(gh_api "tags?per_page=100")
if rate_limited "$tags"; then
  echo "GH_RATE_LIMITED  $repo_url"
  exit 1
fi
tag=$(grep -oE '"name":[[:space:]]*"[^"]+"' <<< "$tags" \
  | sed -E 's/.*"name":[[:space:]]*"([^"]+)"/\1/' \
  | grep -E "$tag_matches" | pick_tag || true)
if [ -n "$tag" ]; then
  echo "TAG  $repo_url/releases/tag/$tag"
  exit 0
fi

# --- 4. no per-version anchor: repo homepage -------------------------------
echo "HOMEPAGE  $(canonical "$repo_url")"
