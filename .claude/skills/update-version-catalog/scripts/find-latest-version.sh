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
# READ-ONLY. Portable to macOS (bash 3.2 + BSD userland) — see lib.sh: macOS
# `sort` may not support -V, so version ordering goes through vsort/vge.
set -euo pipefail
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

[ "$#" -ge 1 ] || { echo "Usage: bash find-latest-version.sh <group:artifact>…"; exit 1; }

# A qualifier only counts when it starts a version segment — otherwise a version
# that merely CONTAINS the letters (e.g. "…-source" contains "rc") would be
# thrown away as a pre-release.
PRE_RE='(^|[-._+0-9])(alpha|beta|rc|snapshot|dev|eap|preview|milestone|M[0-9]|cr[0-9]?)'

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
    latest=$(vsort <<< "$versions" | tail -1)
    stable=$(stable_only <<< "$versions" | vsort | tail -1)
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

  all=$(sort -u <<< "$combined" | sed '/^$/d' | vsort)
  best_any=$(tail -1 <<< "$all")
  best_stable=$(stable_only <<< "$all" | tail -1)

  if [ -z "$best_stable" ]; then
    echo "  UNSTABLE candidates: $(tail -8 <<< "$all" | tr '\n' ' ')"
  elif [ "$best_stable" = "$best_any" ]; then
    echo "  LATEST_STABLE $best_stable"
  else
    # version sort puts `X-rc1` AFTER `X`, so best_any may be a pre-release of the
    # stable version itself (or of an older one) — that is not "newer". Only a
    # pre-release whose leading numeric base exceeds best_stable counts.
    base_any=$(grep -oE '^[0-9]+(\.[0-9]+)*' <<< "$best_any" || true)
    if [ -n "$base_any" ] && vge "$best_stable" "$base_any"; then
      echo "  LATEST_STABLE $best_stable"
    else
      echo "  STABLE $best_stable NEWER_PRERELEASE $best_any"
    fi
  fi
done
exit "$status"
