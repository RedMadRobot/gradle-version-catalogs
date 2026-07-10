#!/usr/bin/env bash
#
# Show the catalog version diffs contained in the release commit (HEAD):
# a compact per-file list of changed lines (old version = "-" lines, new
# version = "+" lines) followed by the full patch for context (renames,
# [libraries]/[plugins] edits).
#
# READ-ONLY. Usage: bash show-version-diffs.sh
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

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
echo "=== full patch ==="
printf '%s\n' "$patch"
