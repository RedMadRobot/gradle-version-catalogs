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
#   bash commit-release.sh --new-commit "message"
#                                     # intentionally create a SECOND commit in
#                                     # the same command (normally refused)
#
# SAFETY: refuses to run unless HEAD is a dev-update-* branch; never amends a
# commit reachable from origin/main, a release commit ("version: …"), or a
# commit at or below the command base recorded by start-update.sh (i.e. a
# commit created before the current command). One command creates at most one
# message-commit: re-running with a DIFFERENT message (a rephrased subject after
# a lint fix, for instance) is refused instead of silently producing a second
# addition commit. Never opens an editor.
set -euo pipefail
export GIT_EDITOR=true GIT_SEQUENCE_EDITOR=true
cd "$(git rev-parse --show-toplevel)"

allow_second=0
msg=""
for arg in "$@"; do
  case "$arg" in
    --new-commit) allow_second=1 ;;
    *) if [ -z "$msg" ]; then msg="$arg"; else
         echo "ERROR: more than one message given."; exit 1
       fi ;;
  esac
done

cur=$(git branch --show-current)
case "$cur" in
  dev-update-*) ;;
  *) echo "ERROR: not on a dev-update-* branch (on '$cur'). Aborting."; exit 1 ;;
esac

git_dir=$(git rev-parse --git-dir)
base_file="$git_dir/update-catalog-base"
commit_file="$git_dir/update-catalog-commit"

base_sha=""
if [ -f "$base_file" ]; then
  read -r mbranch msha < "$base_file" || true
  if [ "${mbranch:-}" = "$cur" ] && git cat-file -e "${msha:-}^{commit}" 2>/dev/null; then
    base_sha="$msha"
  fi
fi

# report changes that will NOT be part of the commit, so nothing is lost silently
leftovers=$(git status --porcelain -- . \
  | grep -vE '^.. (CHANGELOG\.md|versions-[a-z]+/libs\.versions\.toml)$' || true)

git add -- CHANGELOG.md 'versions-*/libs.versions.toml'

head_subject=$(git log -1 --format=%s HEAD)

if [ -n "$msg" ] && [ "$head_subject" != "$msg" ]; then
  # ---- new commit on top (addition flow; never mixed into the update commit)
  if [ -f "$commit_file" ] && [ "$allow_second" -eq 0 ]; then
    read -r cbranch cbase csubject < "$commit_file" || true
    if [ "${cbranch:-}" = "$cur" ] && [ "${cbase:-}" = "${base_sha:-}" ] \
       && [ -n "${csubject:-}" ] && [ "$csubject" != "$msg" ]; then
      echo "ERROR: this command already created the commit:"
      echo "         $csubject"
      echo "A command produces ONE update commit and at most ONE addition commit."
      echo "To amend that commit, re-run with its exact message:"
      echo "         bash commit-release.sh \"$csubject\""
      echo "If a second commit is really intended, re-run with --new-commit."
      exit 1
    fi
  fi
  if git diff --cached --quiet; then
    echo "ERROR: nothing staged — no catalog/CHANGELOG changes to commit."; exit 1
  fi
  git commit -m "$msg"
  printf '%s %s %s\n' "$cur" "${base_sha:-none}" "$msg" > "$commit_file"
else
  # ---- amend flow — only the commit created by the current command
  if git merge-base --is-ancestor HEAD origin/main; then
    echo "ERROR: HEAD is on origin/main — nothing to amend. Pass a message to create a commit."
    exit 1
  fi
  case "$head_subject" in
    version:*) echo "ERROR: HEAD is a release commit ('$head_subject') — refusing to amend."; exit 1 ;;
  esac
  if [ -n "$base_sha" ] && git merge-base --is-ancestor HEAD "$base_sha"; then
    echo "ERROR: HEAD pre-dates the current command's base ($(git log --oneline -1 "$base_sha"))."
    echo "Refusing to amend an earlier command's commit — pass a message to create a new one."
    exit 1
  fi
  if git diff --cached --quiet; then
    echo "Nothing staged — HEAD left unchanged."
  else
    git commit --amend --no-edit
  fi
  # remember the amended commit's subject only if this command created it
  if [ -n "$msg" ]; then
    printf '%s %s %s\n' "$cur" "${base_sha:-none}" "$msg" > "$commit_file"
  fi
fi

echo
git show HEAD --stat --format=oneline

if [ -n "$leftovers" ]; then
  echo
  echo "WARNING: these changes are NOT part of the commit (only CHANGELOG.md and"
  echo "         versions-*/libs.versions.toml are staged):"
  sed 's/^/         /' <<< "$leftovers"
fi
