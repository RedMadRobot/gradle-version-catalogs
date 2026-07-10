#!/usr/bin/env bash
#
# Find the latest version of Maven artifacts in Google Maven, Maven Central
# and the Gradle Plugin Portal.
#
#   bash find-latest-version.sh group:artifact [group:artifact ...]
#
# For a Gradle plugin pass its marker artifact:
#   <plugin.id>:<plugin.id>.gradle.plugin
#
# Per artifact prints one line per repository that has it (latest and latest
# stable version), then a verdict line:
#   LATEST_STABLE <v>                     latest available version is stable
#   STABLE <v> NEWER_PRERELEASE <v>       stable exists, but a pre-release with a
#                                         genuinely NEWER base version too — ask
#                                         the user. Pre-releases of the stable
#                                         version itself (or older) do not count.
#   UNSTABLE candidates: <v…>             only pre-release versions exist — ask the user
#   NOT_FOUND                             artifact is in no repository — ask the user
#
# Stable = no pre-release qualifier (alpha/beta/rc/M/dev/eap/snapshot/preview/cr).
# READ-ONLY.
set -euo pipefail

[ "$#" -ge 1 ] || { echo "Usage: bash find-latest-version.sh <group:artifact>…"; exit 1; }

PRE_RE='(alpha|beta|rc|snapshot|dev|eap|preview|milestone|[-.]M[0-9]|[-.]cr[0-9]?)'

stable_only() { grep -ivE "$PRE_RE" || true; }

fetch_versions() { # $1 = repo base url, $2 = group, $3 = artifact
  curl -sfL --max-time 20 "$1/${2//./\/}/$3/maven-metadata.xml" 2>/dev/null \
    | grep -oE '<version>[^<]+</version>' \
    | sed -E 's#</?version>##g' || true
}

status=0
for coord in "$@"; do
  group="${coord%%:*}"; artifact="${coord#*:}"
  if [ -z "$group" ] || [ -z "$artifact" ] || [ "$group" = "$coord" ]; then
    echo "ERROR: '$coord' is not of the form group:artifact"; status=1; continue
  fi
  echo "=== $coord"

  combined=""
  while read -r name base; do
    versions=$(fetch_versions "$base" "$group" "$artifact")
    [ -n "$versions" ] || continue
    latest=$(sort -V <<< "$versions" | tail -1)
    stable=$(stable_only <<< "$versions" | sort -V | tail -1)
    echo "  $name: latest=$latest latest_stable=${stable:-<none>}"
    combined+="$versions"$'\n'
  done <<'EOF'
google         https://dl.google.com/android/maven2
maven-central  https://repo1.maven.org/maven2
plugin-portal  https://plugins.gradle.org/m2
EOF

  if [ -z "$combined" ]; then
    echo "  NOT_FOUND"
    status=1
    continue
  fi

  all=$(sort -uV <<< "$combined" | sed '/^$/d')
  best_any=$(tail -1 <<< "$all")
  best_stable=$(stable_only <<< "$all" | tail -1)

  if [ -z "$best_stable" ]; then
    echo "  UNSTABLE candidates: $(tail -8 <<< "$all" | tr '\n' ' ')"
  elif [ "$best_stable" = "$best_any" ]; then
    echo "  LATEST_STABLE $best_stable"
  else
    # sort -V puts `X-rc1` AFTER `X`, so best_any may be a pre-release of the
    # stable version itself (or of an older one) — that is not "newer". Only a
    # pre-release whose leading numeric base exceeds best_stable counts.
    base_any=$(grep -oE '^[0-9]+(\.[0-9]+)*' <<< "$best_any" || true)
    if [ -n "$base_any" ] \
       && [ "$(printf '%s\n%s\n' "$best_stable" "$base_any" | sort -V | tail -1)" = "$best_stable" ]; then
      echo "  LATEST_STABLE $best_stable"
    else
      echo "  STABLE $best_stable NEWER_PRERELEASE $best_any"
    fi
  fi
done
exit "$status"
