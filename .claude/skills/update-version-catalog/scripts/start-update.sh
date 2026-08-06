#!/usr/bin/env bash
#
# Start a command: fetch ALL remote branches (origin/main AND every
# origin/renovate/* branch — the sources of version bumps), then create (or
# switch to / stay on) the dev-update-YYYY-MM-DD working branch off the freshly
# fetched origin/main and record the COMMAND BASE (current HEAD). Local main is
# never modified.
#
#   bash start-update.sh                  # today's date
#   bash start-update.sh 2026-07-09       # explicit date
#   bash start-update.sh --new-command    # move the command base to HEAD (see below)
#   bash start-update.sh --force          # ignore an unexpected branch / dirty tree
#
# Run ONCE at the start of EVERY command (and not again mid-command):
# squash-commit.sh and commit-release.sh refuse to rewrite commits at or below
# the recorded base, which is what protects earlier commands' commits (see
# SKILL.md "Commit rules").
#
# GUARDS (mechanical, so they cannot be forgotten):
#   * refuses to run on any branch other than main / master / dev-update-*
#     (pass --force to override);
#   * refuses to run with a dirty working tree — uncommitted changes would be
#     folded into the release commit by commit-release.sh (pass --force);
#   * NEVER moves an already-recorded command base of this branch: a re-run in
#     the middle of a command would otherwise land the base on the commit still
#     being built and permanently block commit-release.sh. Starting a genuinely
#     NEW command on a branch that already carries commits → pass --new-command.
#
# If already on a dev-update-* branch (any date) and no explicit date is given,
# the script stays on it — earlier commands' commits stay untouched.
set -euo pipefail
export GIT_EDITOR=true GIT_SEQUENCE_EDITOR=true
cd "$(git rev-parse --show-toplevel)"

force=0
new_command=0
date=""
for arg in "$@"; do
  case "$arg" in
    --force)       force=1 ;;
    --new-command) new_command=1 ;;
    [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) date="$arg" ;;
    *) echo "ERROR: unknown argument '$arg' (expected YYYY-MM-DD, --new-command, --force)."; exit 1 ;;
  esac
done

explicit_date=1
if [ -z "$date" ]; then
  date="$(date +%F)"
  explicit_date=0
fi
branch="dev-update-$date"

cur=$(git branch --show-current)

# --- guard: only main / dev-update-* are valid starting points --------------
case "$cur" in
  main|master|dev-update-*) ;;
  *)
    if [ "$force" -eq 1 ]; then
      echo "WARNING: starting from unexpected branch '$cur' (--force given)." >&2
    else
      echo "ERROR: current branch is '$cur'."
      echo "This skill only works from 'main' or an existing 'dev-update-*' branch."
      echo "Ask which branch to work on, or re-run with --force if this is intended."
      exit 1
    fi
    ;;
esac

# continuing an earlier session's branch: without an explicit date, stay on it
case "$cur" in
  dev-update-*) [ "$explicit_date" -eq 0 ] && branch="$cur" ;;
esac

# --- guard: dirty tree ------------------------------------------------------
if ! git diff --quiet || ! git diff --cached --quiet; then
  git status --short
  if [ "$force" -eq 1 ]; then
    echo "WARNING: working tree has uncommitted changes — they will be carried over (--force given)." >&2
  else
    echo "ERROR: working tree has uncommitted changes (listed above)."
    echo "commit-release.sh stages versions-*/libs.versions.toml and CHANGELOG.md blindly,"
    echo "so these changes would silently end up in the release commit."
    echo "Commit, stash or discard them first — or re-run with --force if they belong to this update."
    exit 1
  fi
fi

# MANDATORY: fetch ALL remote branches before creating/switching to the working
# branch, so origin/main and every origin/renovate/* branch are up to date.
# The explicit refspec guarantees renovate branches arrive even if the clone's
# remote.origin.fetch refspec is narrowed (e.g. a --single-branch clone).
echo ">>> fetching all branches from origin (incl. renovate/*)"
git fetch --prune origin '+refs/heads/*:refs/remotes/origin/*'

renovate_count=$(git for-each-ref 'refs/remotes/origin/renovate/*' | grep -c . || true)
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

# --- command base ----------------------------------------------------------
# Commits at or below the base belong to earlier commands and are protected from
# squash-commit.sh / commit-release.sh --amend. An existing base of THIS branch
# is never moved silently: a mid-command re-run would otherwise put the base on
# the commit being built and block every later amend.
base_file="$(git rev-parse --git-dir)/update-catalog-base"
head_sha=$(git rev-parse HEAD)
recorded_branch=""; recorded_sha=""
if [ -f "$base_file" ]; then
  read -r recorded_branch recorded_sha < "$base_file" || true
fi

keep_base=0
if [ "${recorded_branch:-}" = "$branch" ] && git cat-file -e "${recorded_sha:-}^{commit}" 2>/dev/null \
   && git merge-base --is-ancestor "$recorded_sha" HEAD; then
  if [ "$recorded_sha" = "$head_sha" ]; then
    keep_base=1                       # same base, nothing to decide
  elif [ "$new_command" -eq 1 ]; then
    keep_base=0                       # explicitly starting a new command
  else
    keep_base=1
    echo
    echo "NOTE: a command base is already recorded for $branch and HEAD has moved past it:"
    echo "      base: $(git log --oneline -1 "$recorded_sha")"
    echo "      HEAD: $(git log --oneline -1 HEAD)"
    echo "      Keeping the recorded base — this is what lets commit-release.sh keep"
    echo "      amending the commit of a command that is still in progress."
    echo "      If this really is a NEW command on an existing branch, re-run:"
    echo "        bash .claude/skills/update-version-catalog/scripts/start-update.sh --new-command"
  fi
fi

if [ "$keep_base" -eq 1 ]; then
  printf '%s %s\n' "$branch" "$recorded_sha" > "$base_file"
  echo ">>> command base (kept): $(git log --oneline -1 "$recorded_sha")"
else
  printf '%s %s\n' "$branch" "$head_sha" > "$base_file"
  # a new base starts a new command: forget the commit this command created
  rm -f "$(git rev-parse --git-dir)/update-catalog-commit"
  echo ">>> command base recorded: $(git log --oneline -1 HEAD)"
fi

echo
echo "HEAD: $(git log --oneline -1)"
echo "Commits ahead of origin/main:"
git log --oneline origin/main..HEAD
