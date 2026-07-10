#!/usr/bin/env bash
#
# Reachability check for release-notes URLs added to CHANGELOG.md in the current
# release commit. Prints "HTTP_CODE  URL" per unique added URL. When the final
# URL after redirects differs from the requested one, it is appended as
# "(redirected to: …)" — a redirect landing on a different page usually means
# the requested page is wrong or gone (some sites redirect missing pages to a
# generic page and answer 200), so verify such links.
#
# NOTE: this covers step 9b check #1 (reachability) only. The version-presence
# check (does the page mention the new version?) is done by the agent via
# WebFetch — see SKILL.md step 9.
#
# READ-ONLY. Usage: bash check-changelog-urls.sh
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

urls=$(git show HEAD -- CHANGELOG.md \
  | grep -E '^\+' \
  | grep -oE 'https?://[^)[:space:]]+' \
  | sort -u || true)

if [ -z "$urls" ]; then
  echo "No URLs added to CHANGELOG.md in HEAD — nothing to check."
  exit 0
fi

while read -r url; do
  # `|| res=…` keeps the loop going on network errors (DNS, timeout, …);
  # it must REPLACE, not append — on failure curl still emits its own -w output.
  res=$(curl -s -o /dev/null -L --max-time 15 -w '%{http_code} %{url_effective}' "$url") || res="000 $url"
  code="${res%% *}"; final="${res#* }"
  # compare without fragments — they are client-side only and curl keeps the
  # requested one in url_effective even when nothing redirected
  final="${final%%#*}"; req="${url%%#*}"
  if [ "${final%/}" != "${req%/}" ]; then
    echo "$code  $url  (redirected to: $final)"
  else
    echo "$code  $url"
  fi
done <<< "$urls"
