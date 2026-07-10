#!/usr/bin/env bash
#
# Start a command: fetch ALL remote branches (origin/main AND every
# origin/renovate/* branch — the sources of version bumps), then create (or
# switch to / stay on) the dev-update-YYYY-MM-DD working branch off the freshly
# fetched origin/main and record the COMMAND BASE (current HEAD). Local main is
# never modified.
#
#   bash start-update.sh              # today's date
#   bash start-update.sh 2026-07-09   # explicit date
#
# Run ONCE at the start of EVERY command (and not again mid-command):
# squash-commit.sh and commit-release.sh refuse to rewrite commits at or below
# the recorded base, which is what protects earlier commands' commits (see
# SKILL.md "Commit rules").
#
# If already on a dev-update-* branch (any date) and no explicit date is given,
# the script stays on it — earlier commands' commits stay untouched.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

date="${1:-$(date +%F)}"
case "$date" in
  [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) ;;
  *) echo "ERROR: invalid date '$date' (expected YYYY-MM-DD)."; exit 1 ;;
esac
branch="dev-update-$date"

cur=$(git branch --show-current)
# continuing an earlier session's branch: without an explicit date, stay on it
case "$cur" in
  dev-update-*) [ "$#" -eq 0 ] && branch="$cur" ;;
esac

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "WARNING: working tree has uncommitted changes — they will be carried over." >&2
fi

# MANDATORY: fetch ALL remote branches before creating/switching to the working
# branch, so origin/main and every origin/renovate/* branch are up to date.
# The explicit refspec guarantees renovate branches arrive even if the clone's
# remote.origin.fetch refspec is narrowed (e.g. a --single-branch clone).
echo ">>> fetching all branches from origin (incl. renovate/*)"
git fetch --prune origin '+refs/heads/*:refs/remotes/origin/*'

renovate_count=$(git for-each-ref 'refs/remotes/origin/renovate/*' | wc -l)
echo ">>> renovate branches available: $renovate_count"

if [ "$cur" = "$branch" ]; then
  echo ">>> already on $branch — staying on it"
elif git show-ref --verify --quiet "refs/heads/$branch"; then
  echo ">>> branch $branch already exists — switching to it"
  git switch "$branch"
else
  echo ">>> creating $branch off origin/main"
  git switch --no-track -c "$branch" origin/main
fi

if ! git merge-base --is-ancestor origin/main HEAD; then
  echo "WARNING: origin/main has advanced past the base of $branch —" >&2
  echo "         diffs and lint-changelog.sh compare against origin/main and will" >&2
  echo "         include unrelated changes. Consider releasing/merging this branch" >&2
  echo "         and starting a fresh one." >&2
fi

# record the command base: commits at or below this point belong to earlier
# commands and are protected from squash-commit.sh / commit-release.sh --amend
printf '%s %s\n' "$branch" "$(git rev-parse HEAD)" > "$(git rev-parse --git-dir)/update-catalog-base"
echo ">>> command base recorded: $(git log --oneline -1 HEAD)"

echo
echo "HEAD: $(git log --oneline -1)"
echo "Commits ahead of origin/main:"
git log --oneline origin/main..HEAD
