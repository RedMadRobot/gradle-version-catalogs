#!/usr/bin/env bash
#
# Create or amend the current command's release commit with the catalog and
# CHANGELOG.md changes.
#
#   bash commit-release.sh            # amend HEAD — update flow (fold the
#                                     # CHANGELOG into the squashed commit) and
#                                     # re-runs after lint/link fixes
#   bash commit-release.sh "message"  # NEW commit with this message — addition
#                                     # flow; if HEAD already has exactly this
#                                     # subject, it is amended instead
#                                     # (idempotent re-runs)
#
# SAFETY: refuses to run unless HEAD is a dev-update-* branch; never amends a
# commit reachable from origin/main, a release commit ("version: …"), or a
# commit at or below the command base recorded by start-update.sh (i.e. a
# commit created before the current command).
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

cur=$(git branch --show-current)
case "$cur" in
  dev-update-*) ;;
  *) echo "ERROR: not on a dev-update-* branch (on '$cur'). Aborting."; exit 1 ;;
esac

git add -- CHANGELOG.md 'versions-*/libs.versions.toml'

msg="${1:-}"
head_subject=$(git log -1 --format=%s HEAD)

if [ -n "$msg" ] && [ "$head_subject" != "$msg" ]; then
  # addition flow: new commit on top (never mixed into the update commit)
  if git diff --cached --quiet; then
    echo "ERROR: nothing staged — no catalog/CHANGELOG changes to commit."; exit 1
  fi
  git commit -m "$msg"
else
  # amend flow — only the commit created by the current command
  if git merge-base --is-ancestor HEAD origin/main; then
    echo "ERROR: HEAD is on origin/main — nothing to amend. Pass a message to create a commit."
    exit 1
  fi
  case "$head_subject" in
    version:*) echo "ERROR: HEAD is a release commit ('$head_subject') — refusing to amend."; exit 1 ;;
  esac
  base_file="$(git rev-parse --git-dir)/update-catalog-base"
  if [ -f "$base_file" ]; then
    read -r mbranch msha < "$base_file" || true
    if [ "${mbranch:-}" = "$cur" ] && git cat-file -e "${msha:-}^{commit}" 2>/dev/null \
       && git merge-base --is-ancestor HEAD "$msha"; then
      echo "ERROR: HEAD pre-dates the current command's base ($(git log --oneline -1 "$msha"))."
      echo "Refusing to amend an earlier command's commit — pass a message to create a new one."
      exit 1
    fi
  fi
  if git diff --cached --quiet; then
    echo "Nothing staged — HEAD left unchanged."
  else
    git commit --amend --no-edit
  fi
fi

echo
git show HEAD --stat --format=oneline
