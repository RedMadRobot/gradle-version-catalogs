#!/usr/bin/env bash
#
# Squash the cherry-picked bump commits on top of the working branch into one.
#
#   bash squash-commit.sh            # message = subjects of squashed commits
#   bash squash-commit.sh "message"  # explicit message
#
# Squashed range: the contiguous run of commits from HEAD down that do NOT
# touch CHANGELOG.md, stopping at the command base recorded by start-update.sh
# (falling back to origin/main when no valid base is recorded). Commits at or
# below the base, and commits touching CHANGELOG.md, are earlier commands'
# work and are never rewritten (see SKILL.md "Commit rules"). Default message:
# the subjects of the squashed commits, oldest first, one per line — same as
# existing release commits on main.
#
# SAFETY: refuses to run unless HEAD is a dev-update-* branch and the working
# tree is clean.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

cur=$(git branch --show-current)
case "$cur" in
  dev-update-*) ;;
  *) echo "ERROR: not on a dev-update-* branch (on '$cur'). Aborting."; exit 1 ;;
esac

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "ERROR: working tree not clean — commit or stash first."; exit 1
fi

# limit below which nothing may be rewritten: the command base recorded by
# start-update.sh, or origin/main when no valid base is recorded
limit="origin/main"
base_file="$(git rev-parse --git-dir)/update-catalog-base"
if [ -f "$base_file" ]; then
  read -r mbranch msha < "$base_file" || true
  if [ "${mbranch:-}" = "$cur" ] && git cat-file -e "${msha:-}^{commit}" 2>/dev/null \
     && git merge-base --is-ancestor "$msha" HEAD; then
    limit="$msha"
  fi
fi

# contiguous run of commits from HEAD down that do not touch CHANGELOG.md
count=0
for c in $(git rev-list "$limit..HEAD"); do
  if git diff-tree --no-commit-id --name-only -r "$c" | grep -qx 'CHANGELOG.md'; then
    break
  fi
  count=$((count + 1))
done

if [ "$count" -eq 0 ]; then
  echo "Nothing to squash (no bump commits on top of the branch)."
  exit 0
fi
if [ "$count" -eq 1 ]; then
  echo "Only one bump commit on top — nothing to squash."
  git log --oneline -1
  exit 0
fi

base=$(git rev-parse "HEAD~$count")
if [ "$#" -gt 0 ] && [ -n "$1" ]; then
  msg="$1"
else
  msg=$(git log --reverse --format='%s' "$base..HEAD")
fi

echo ">>> squashing $count commits on top of: $(git log --oneline -1 "$base")"
git reset --soft "$base"
git commit -m "$msg"

echo
echo "Commits now on $cur (vs origin/main):"
git log --oneline origin/main..HEAD
