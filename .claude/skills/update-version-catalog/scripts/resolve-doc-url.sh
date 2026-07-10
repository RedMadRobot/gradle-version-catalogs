#!/usr/bin/env bash
#
# Resolve the documentation URL for a newly added dependency — never invent it.
#
#   bash resolve-doc-url.sh <group:artifact> <version>
#
# For a Gradle plugin pass its marker artifact:
#   <plugin.id>:<plugin.id>.gradle.plugin
#
# Resolution order (matches SKILL.md step 6 / "Adding a new dependency" step 5):
#   1. Read the HomePage of the artifact from its POM (<url>, falling back to
#      <scm><url>) in Google Maven / Maven Central / the Gradle Plugin Portal.
#   2. If the HomePage is a GitHub repository, query the GitHub API for a
#      RELEASE or TAG whose name matches <version> (accepting a leading `v` and
#      any `name-`/`name_`/`name/` prefix, e.g. `v1.11.1`, `dagger-2.60`,
#      `lifecycle-viewmodel-compose-2.10.0`) and print that release/tag page.
#   3. If no matching release/tag exists, print the repository HomePage itself.
#   4. If the HomePage is not GitHub, print it verbatim.
#
# Prints one verdict line:
#   RELEASE   <url>   github release page for the version (best)
#   TAG       <url>   github tag page for the version
#   HOMEPAGE  <url>   repo/home page, no per-version release or tag found
#   NO_HOMEPAGE      POM has no <url>/<scm> (common for plugin markers — use
#                    the Gradle Plugin Portal route in SKILL.md, then re-run
#                    with the real group:artifact)
#   NOT_FOUND        artifact POM is in no repository
#   GH_RATE_LIMITED <repo-url>   the GitHub API rate limit blocked the
#                    release/tag lookup — NOT the same as "no release exists";
#                    set GITHUB_TOKEN/GH_TOKEN (or wait) and re-run
#
# A GitHub token in $GITHUB_TOKEN / $GH_TOKEN is used if present (higher rate
# limit) but is not required. READ-ONLY.
set -euo pipefail

[ "$#" -eq 2 ] || { echo "Usage: bash resolve-doc-url.sh <group:artifact> <version>"; exit 1; }

coord="$1"; version="$2"
group="${coord%%:*}"; artifact="${coord#*:}"
if [ -z "$group" ] || [ -z "$artifact" ] || [ "$group" = "$coord" ]; then
  echo "ERROR: '$coord' is not of the form group:artifact"; exit 1
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
# stored redirecting URL would trip check-changelog-urls.sh.
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
# the GitHub API calls and the printed release/tag URLs use the real repo.
repo_url=$(canonical "https://github.com/$org/$repo")
slug=$(sed -E 's#^.*github\.com[/:]+##; s#\.git$##; s#/+$##' <<< "$repo_url")
org="${slug%%/*}"; repo=$(cut -d/ -f2 <<< "$slug")

# --- 3. look for a release / tag matching the version ----------------------
gh_api() { # $1 = path (no -f: the rate-limit error body must stay readable)
  local auth=()
  [ -n "${GITHUB_TOKEN:-}" ] && auth=(-H "Authorization: Bearer $GITHUB_TOKEN")
  [ -z "${GITHUB_TOKEN:-}" ] && [ -n "${GH_TOKEN:-}" ] && auth=(-H "Authorization: Bearer $GH_TOKEN")
  curl -sL --max-time 20 "${auth[@]}" \
    -H 'Accept: application/vnd.github+json' \
    "https://api.github.com/repos/$org/$repo/$1" 2>/dev/null || true
}

# A rate-limited lookup must not silently degrade to HOMEPAGE (which would
# make the agent ask the user for a URL that actually exists).
rate_limited() { grep -qi 'rate limit exceeded' <<< "$1"; }

vesc=$(sed -E 's/[.]/\\./g' <<< "$version")
# tag matches version if, ignoring an optional leading `v` and any
# `prefix-`/`prefix_`/`prefix/` before it, it equals the version exactly.
# `.` is excluded from the boundary so version 2.60 does not match tag 1.2.60.
tag_matches='(^|[^0-9.])v?'"$vesc"'$'

# releases (paginated, first 100 is plenty for a recent version)
releases=$(gh_api "releases?per_page=100")
if rate_limited "$releases"; then
  echo "GH_RATE_LIMITED  $repo_url"
  exit 1
fi
rel_tag=$(grep -oE '"tag_name":[[:space:]]*"[^"]+"' <<< "$releases" \
  | sed -E 's/.*"tag_name":[[:space:]]*"([^"]+)"/\1/' \
  | grep -E "$tag_matches" | head -1 || true)
if [ -n "$rel_tag" ]; then
  echo "RELEASE  $repo_url/releases/tag/$rel_tag"
  exit 0
fi

# plain tags
tags=$(gh_api "tags?per_page=100")
if rate_limited "$tags"; then
  echo "GH_RATE_LIMITED  $repo_url"
  exit 1
fi
tag=$(grep -oE '"name":[[:space:]]*"[^"]+"' <<< "$tags" \
  | sed -E 's/.*"name":[[:space:]]*"([^"]+)"/\1/' \
  | grep -E "$tag_matches" | head -1 || true)
if [ -n "$tag" ]; then
  echo "TAG  $repo_url/releases/tag/$tag"
  exit 0
fi

# --- 4. no per-version anchor: repo homepage -------------------------------
echo "HOMEPAGE  $(canonical "$repo_url")"
