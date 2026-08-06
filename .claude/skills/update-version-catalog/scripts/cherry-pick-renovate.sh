#!/usr/bin/env bash
#
# Cherry-pick renovate branches onto the current working branch.
#
#   bash cherry-pick-renovate.sh                 # ALL origin/renovate/* ahead of origin/main
#   bash cherry-pick-renovate.sh dagger kotest   # only the named ones
#
# Accepts short names (dagger), renovate/dagger, or origin/renovate/dagger.
# Picks EVERY commit a branch has ahead of origin/main (not just its tip).
#
# Safe to re-run — a commit is skipped when it is already on the branch either
# by patch-id (git cherry) OR by commit subject. The subject check matters after
# a CONFLICT was resolved by hand: the resolved commit has a different patch-id,
# so patch-id alone would pick it a second time.
#
# A pick that turns out empty (its change is already present) is skipped instead
# of aborting. A real conflict stops the script with instructions.
#
# SAFETY: refuses to run unless HEAD is a dev-update-* branch. No editor is ever
# opened (GIT_EDITOR=true), so the session cannot hang on a commit-message
# prompt.
set -euo pipefail
export GIT_EDITOR=true GIT_SEQUENCE_EDITOR=true
cd "$(git rev-parse --show-toplevel)"

cur=$(git branch --show-current)
case "$cur" in
  dev-update-*) ;;
  *) echo "ERROR: not on a dev-update-* branch (on '$cur'). Aborting."; exit 1 ;;
esac

git_dir=$(git rev-parse --git-dir)
if [ -e "$git_dir/CHERRY_PICK_HEAD" ] || [ -d "$git_dir/sequencer" ]; then
  echo "ERROR: a cherry-pick is already in progress."
  echo "Resolve the conflict in versions-*/libs.versions.toml (keep the newer version),"
  echo "'git add' the file and run: GIT_EDITOR=true git cherry-pick --continue"
  echo "Then re-run this script."
  exit 1
fi

if [ "$#" -gt 0 ]; then
  inputs=("$@")
else
  inputs=()
  for b in $(git for-each-ref --format='%(refname:short)' 'refs/remotes/origin/renovate/*'); do
    [ "$(git rev-list --count "origin/main..$b")" -gt 0 ] && inputs+=("$b")
  done
fi

[ "${#inputs[@]}" -eq 0 ] && { echo "Nothing to cherry-pick."; exit 0; }

# subjects already on the working branch — a conflict-resolved pick keeps its
# subject but changes its patch-id, so this is what makes re-runs idempotent
subjects_on_branch=$(git log --format='%s' origin/main..HEAD || true)

for b in "${inputs[@]}"; do
  case "$b" in
    origin/*)   ref="$b" ;;
    renovate/*) ref="origin/$b" ;;
    *)          ref="origin/renovate/$b" ;;
  esac
  if ! git rev-parse --verify --quiet "$ref^{commit}" >/dev/null; then
    echo ">>> skip $ref (no such branch — fetch first?)"
    continue
  fi
  # commits of $ref (vs origin/main) not yet in HEAD by patch-id, oldest first
  to_pick=$(git cherry HEAD "$ref" origin/main | awk '$1 == "+" { print $2 }')
  if [ -z "$to_pick" ]; then
    echo ">>> skip $ref (already applied)"
    continue
  fi

  for sha in $to_pick; do
    subject=$(git log -1 --format=%s "$sha")
    if grep -Fxq -- "$subject" <<< "$subjects_on_branch"; then
      echo ">>> skip $(git log --oneline -1 "$sha") (same subject already on branch)"
      continue
    fi
    echo ">>> cherry-pick $(git log --oneline -1 "$sha")"
    if ! git cherry-pick "$sha"; then
      # empty pick (change already present) → skip it and continue
      if { [ -e "$git_dir/CHERRY_PICK_HEAD" ] || [ -d "$git_dir/sequencer" ]; } \
         && git diff --quiet && git diff --cached --quiet; then
        echo ">>> nothing to apply (already present) — skipping this commit"
        git cherry-pick --skip
        continue
      fi
      echo
      echo "CONFLICT while picking $sha ($subject)."
      echo "Resolve it in versions-*/libs.versions.toml (keep the NEWER version), then:"
      echo "  git add versions-*/libs.versions.toml"
      echo "  GIT_EDITOR=true git cherry-pick --continue"
      echo "Then re-run this script — everything already applied is skipped."
      exit 1
    fi
    subjects_on_branch+=$'\n'"$subject"
  done
done

echo
echo "Commits now on $cur (vs origin/main):"
git log --oneline "origin/main..HEAD"
