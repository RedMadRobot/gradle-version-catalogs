#!/usr/bin/env bash
#
# Diff the component versions of two releases of a BOM, straight from the BOMs'
# POMs (<dependencyManagement>) — no release-notes page reading, no guessing.
#
#   bash bom-diff.sh <group:artifact> <old-version> <new-version>
#
#   bash bom-diff.sh androidx.compose:compose-bom 2026.06.00 2026.06.01
#   bash bom-diff.sh com.google.firebase:firebase-bom 34.16.0 34.17.0
#
# Prints one line per component whose version differs:
#   CHANGED  <group:artifact>  <old> → <new>
#   ADDED    <group:artifact>  <new>
#   REMOVED  <group:artifact>  <old>
# followed by a count. Use it for the nested CHANGELOG entries of a BOM update
# whose components do NOT have their own alias in the catalog (when they do, the
# catalog diff from show-version-diffs.sh is the source of truth).
#
# READ-ONLY (network reads only). Portable to macOS — see lib.sh.
set -euo pipefail
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

[ "$#" -eq 3 ] || { echo "Usage: bash bom-diff.sh <group:artifact> <old-version> <new-version>"; exit 1; }

coord="$1"; oldv="$2"; newv="$3"
group="${coord%%:*}"; artifact="${coord#*:}"
if [ -z "$group" ] || [ -z "$artifact" ] || [ "$group" = "$coord" ]; then
  echo "ERROR: '$coord' is not of the form group:artifact"; exit 1
fi

fetch_pom() { # $1 = version -> POM on stdout
  local v="$1" base
  while read -r _name base; do
    if curl -sfL --max-time 25 "$base/${group//./\/}/$artifact/$v/$artifact-$v.pom" 2>/dev/null; then
      return 0
    fi
  done <<'EOF'
google         https://dl.google.com/android/maven2
maven-central  https://repo1.maven.org/maven2
plugin-portal  https://plugins.gradle.org/m2
EOF
  return 1
}

components() { # stdin = POM -> "group:artifact<TAB>version" per managed dependency
  # everything is done in awk: BSD sed cannot put a newline in a replacement, and
  # a multi-character RS is a GNU awk extension — split() on a string works
  # everywhere.
  tr -d '\r' | tr '\n' ' ' | awk '
    function tag(s, name,   re, v) {
      re = "<" name ">[^<]+</" name ">"
      if (!match(s, re)) return ""
      v = substr(s, RSTART, RLENGTH)
      sub("<" name ">", "", v); sub("</" name ">", "", v)
      return v
    }
    {
      n = split($0, blocks, "</dependency>")
      for (i = 1; i <= n; i++) {
        b = blocks[i]
        # keep only what follows the LAST <dependency> opening tag, so the POM
        # header (the BOM'"'"'s own groupId/artifactId/version) is not mistaken
        # for a component
        if (match(b, /.*<dependency>/)) b = substr(b, RSTART + RLENGTH)
        else continue
        g = tag(b, "groupId"); a = tag(b, "artifactId"); v = tag(b, "version")
        if (g != "" && a != "" && v != "") print g ":" a "\t" v
      }
    }'
}

old_pom=$(fetch_pom "$oldv") || { echo "NOT_FOUND: $coord:$oldv"; exit 1; }
new_pom=$(fetch_pom "$newv") || { echo "NOT_FOUND: $coord:$newv"; exit 1; }

n_old=0; n_new=0
while IFS=$'\t' read -r c v; do
  [ -n "$c" ] || continue
  map_put OLD "$c" "$v"; n_old=$(( n_old + 1 ))
done <<< "$(components <<< "$old_pom")"
while IFS=$'\t' read -r c v; do
  [ -n "$c" ] || continue
  map_put NEW "$c" "$v"; n_new=$(( n_new + 1 ))
done <<< "$(components <<< "$new_pom")"

if [ "$n_old" -eq 0 ] || [ "$n_new" -eq 0 ]; then
  echo "ERROR: could not read <dependencyManagement> components (old=$n_old new=$n_new)."
  exit 1
fi

echo "=== $coord $oldv → $newv (components: $n_old → $n_new)"

out=""
map_keys NEW; new_keys="$REPLY"
map_keys OLD; old_keys="$REPLY"

while IFS= read -r c; do
  [ -n "$c" ] || continue
  map_get NEW "$c"; nv="$REPLY"
  if map_has OLD "$c"; then
    map_get OLD "$c"; ov="$REPLY"
    [ "$ov" = "$nv" ] || out="${out}CHANGED  $c  $ov → $nv$NL"
  else
    out="${out}ADDED    $c  $nv$NL"
  fi
done <<< "$new_keys"

while IFS= read -r c; do
  [ -n "$c" ] || continue
  if ! map_has NEW "$c"; then
    map_get OLD "$c"; out="${out}REMOVED  $c  $REPLY$NL"
  fi
done <<< "$old_keys"

if [ -z "$out" ]; then
  echo "no component version changed"
  exit 0
fi
LC_ALL=C sort -k2,2 <<< "${out%$NL}"
echo
echo "changed components: $(grep -c . <<< "${out%$NL}")"
