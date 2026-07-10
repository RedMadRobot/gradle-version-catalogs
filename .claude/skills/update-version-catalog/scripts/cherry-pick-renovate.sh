#!/usr/bin/env bash
#
# Cherry-pick renovate branches onto the current working branch.
#
#   bash cherry-pick-renovate.sh                 # ALL origin/renovate/* ahead of origin/main
#   bash cherry-pick-renovate.sh dagger kotest   # only the named ones
#
# Accepts short names (dagger), renovate/dagger, or origin/renovate/dagger.
# Picks EVERY commit a branch has ahead of origin/main (not just its tip).
# Commits already applied to HEAD (by patch-id) are skipped individually, so
# the script is safe to re-run after a conflict was resolved.
#
# SAFETY: refuses to run unless HEAD is a dev-update-* branch. On a conflict it
# stops (git leaves the cherry-pick in progress) so it can be resolved manually,
# then simply re-run it — already-picked branches are skipped.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

cur=$(git branch --show-current)
case "$cur" in
  dev-update-*) ;;
  *) echo "ERROR: not on a dev-update-* branch (on '$cur'). Aborting."; exit 1 ;;
esac

if [ "$#" -gt 0 ]; then
  inputs=("$@")
else
  inputs=()
  for b in $(git for-each-ref --format='%(refname:short)' 'refs/remotes/origin/renovate/*'); do
    [ "$(git rev-list --count "origin/main..$b")" -gt 0 ] && inputs+=("$b")
  done
fi

[ "${#inputs[@]}" -eq 0 ] && { echo "Nothing to cherry-pick."; exit 0; }

for b in "${inputs[@]}"; do
  case "$b" in
    origin/*)   ref="$b" ;;
    renovate/*) ref="origin/$b" ;;
    *)          ref="origin/renovate/$b" ;;
  esac
  # Commits of $ref (vs origin/main) not yet in HEAD by patch-id, oldest first.
  to_pick=$(git cherry HEAD "$ref" origin/main | awk '$1 == "+" { print $2 }')
  if [ -z "$to_pick" ]; then
    echo ">>> skip $ref (already applied)"
    continue
  fi
  echo ">>> cherry-pick $ref"
  # shellcheck disable=SC2086 — intentional word splitting, one SHA per word
  git cherry-pick $to_pick
done

echo
echo "Commits now on $cur (vs origin/main):"
git log --oneline "origin/main..HEAD"
