#!/usr/bin/env bash
#
# Fetch and list every origin/renovate/* branch that has commits ahead of
# origin/main: branch name, commit topics, catalog version changes and any
# other touched files.
#
# READ-ONLY (only fetches from origin). Usage: bash list-renovate-updates.sh
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

git fetch --prune origin >/dev/null 2>&1 \
  || echo "WARNING: git fetch failed — listing may be stale." >&2

found=0
for b in $(git for-each-ref --format='%(refname:short)' 'refs/remotes/origin/renovate/*' | sort); do
  [ "$(git rev-list --count "origin/main..$b")" -gt 0 ] || continue
  found=1
  echo "=== ${b#origin/renovate/}"
  git log --format='    %h %s' "origin/main..$b"
  # catalog version changes (vs merge-base, so an outdated base does not show
  # unrelated changes)
  cat_diff=$(git diff "origin/main...$b" -- 'versions-*/libs.versions.toml' \
    | grep -E '^(diff --git|[-+][^-+])' || true)
  if [ -n "$cat_diff" ]; then
    echo "  catalog changes:"
    sed 's/^/    /' <<< "$cat_diff"
  fi
  other=$(git diff --name-only "origin/main...$b" -- . ':!versions-*/libs.versions.toml' || true)
  if [ -n "$other" ]; then
    echo "  other changed files:"
    sed 's/^/    /' <<< "$other"
  fi
  echo
done

[ "$found" -eq 1 ] || echo "No renovate branches ahead of origin/main."
