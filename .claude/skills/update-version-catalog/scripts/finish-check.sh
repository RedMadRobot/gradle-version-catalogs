#!/usr/bin/env bash
#
# Final gate of a command — run this instead of self-checking by hand. It is the
# single place that answers "am I done?":
#
#   1. HEAD is a dev-update-* branch, no cherry-pick/rebase left in progress;
#   2. the working tree is clean (nothing forgotten outside the commit);
#   3. the commits ahead of origin/main are exactly what the command should have
#      produced (--expect-commits N; a combined update-and-add command → 2);
#   4. every command commit carries its CHANGELOG.md entries;
#   5. lint-changelog.sh passes;
#   6. check-doc-links.sh passes (host policy, version-specific URL, anchor,
#      version present on the page);
#   7. optional: ./gradlew validateCatalog (--with-gradle);
#   8. advisory list of ":warning: candidates" — major/minor bumps documented
#      without the :warning: mark, for the maintainer to decide on.
#
#   bash finish-check.sh                                  # update command
#   bash finish-check.sh --skip-renovate                  # add-only command
#   bash finish-check.sh --expect-commits 2               # update + add command
#   bash finish-check.sh --with-gradle                    # also run validateCatalog
#
# Prints FAIL lines and exits 1, or prints ALL CHECKS PASSED. READ-ONLY.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

skip_renovate=""
expect_commits=""
with_gradle=0
while [ "$#" -gt 0 ]; do
  case "$1" in
    --skip-renovate)  skip_renovate="--skip-renovate" ;;
    --expect-commits) expect_commits="${2:-}"; shift ;;
    --with-gradle)    with_gradle=1 ;;
    *) echo "ERROR: unknown argument '$1'"; exit 1 ;;
  esac
  shift
done

fails=()
fail() { fails+=("$1"); echo "FAIL: $1"; }
ok()   { echo "ok:   $1"; }

# ---------- 1. branch & git state ---------------------------------------------

cur=$(git branch --show-current)
case "$cur" in
  dev-update-*) ok "on working branch $cur" ;;
  *) fail "not on a dev-update-* branch (on '$cur')" ;;
esac

git_dir=$(git rev-parse --git-dir)
if [ -e "$git_dir/CHERRY_PICK_HEAD" ] || [ -d "$git_dir/sequencer" ] \
   || [ -d "$git_dir/rebase-merge" ] || [ -d "$git_dir/rebase-apply" ]; then
  fail "a cherry-pick/rebase is still in progress — finish it first"
else
  ok "no cherry-pick/rebase in progress"
fi

# ---------- 2. clean tree ------------------------------------------------------

dirty=$(git status --porcelain || true)
if [ -n "$dirty" ]; then
  fail "working tree is not clean — these changes are in no commit:"
  sed 's/^/        /' <<< "$dirty"
else
  ok "working tree clean"
fi

# ---------- 3. commits produced ------------------------------------------------

commits=$(git log --oneline origin/main..HEAD || true)
n_commits=$(grep -c . <<< "${commits:-}" || true)
echo "      commits ahead of origin/main ($n_commits):"
if [ -n "$commits" ]; then sed 's/^/        /' <<< "$commits"; fi

if [ -n "$expect_commits" ]; then
  if [ "$n_commits" = "$expect_commits" ]; then
    ok "commit count matches --expect-commits $expect_commits"
  else
    fail "expected $expect_commits commit(s) ahead of origin/main, found $n_commits — a combined update-and-add command must produce BOTH the update commit and the addition commit"
  fi
elif [ "$n_commits" -eq 0 ]; then
  fail "nothing committed on top of origin/main"
fi

# ---------- 4. every commit carries its CHANGELOG entries ---------------------

for c in $(git rev-list origin/main..HEAD); do
  files=$(git diff-tree --no-commit-id --name-only -r "$c")
  has_cat=$(grep -cE '^versions-[a-z]+/libs\.versions\.toml$' <<< "$files" || true)
  has_log=$(grep -cx 'CHANGELOG.md' <<< "$files" || true)
  if [ "$has_cat" -gt 0 ] && [ "$has_log" -eq 0 ]; then
    echo "WARN: $(git log --oneline -1 "$c") changes catalogs but contains no CHANGELOG.md —"
    echo "      fold the changelog into that commit with commit-release.sh"
  fi
done

# ---------- 5. changelog lint --------------------------------------------------

echo
echo "--- lint-changelog.sh ${skip_renovate}"
if bash "$script_dir/lint-changelog.sh" ${skip_renovate:+$skip_renovate}; then
  ok "changelog lint"
else
  fail "changelog lint (see PROBLEM lines above)"
fi

# ---------- 6. documentation links --------------------------------------------

echo
echo "--- check-doc-links.sh"
if bash "$script_dir/check-doc-links.sh"; then
  ok "documentation links"
else
  fail "documentation links (see PROBLEM lines above)"
fi

# ---------- 7. gradle ---------------------------------------------------------

if [ "$with_gradle" -eq 1 ]; then
  echo
  echo "--- ./gradlew validateCatalog"
  if ./gradlew validateCatalog; then
    ok "validateCatalog"
  else
    fail "./gradlew validateCatalog"
  fi
else
  echo
  echo "NOTE: ./gradlew validateCatalog was NOT run (pass --with-gradle to include it)."
fi

# ---------- 8. :warning: candidates (advisory) --------------------------------

echo
echo "--- :warning: candidates (maintainer's call — this skill never adds the mark)"
candidates=$(git show HEAD:CHANGELOG.md | awk '
  /^## \[Unreleased\]/ {u=1; next}
  /^## \[/ {u=0}
  u && /- :arrow_up:/ && !/:warning:/ {print}
' | while IFS= read -r line; do
      old=$(grep -oE '`[^`]+`' <<< "$line" | tr -d '`' | sed -n 1p)
      new=$(grep -oE '`[^`]+`' <<< "$line" | tr -d '`' | sed -n 2p)
      [ -n "$old" ] && [ -n "$new" ] || continue
      om="${old%%.*}"; nm="${new%%.*}"
      omin=$(cut -d. -f2 <<< "$old"); nmin=$(cut -d. -f2 <<< "$new")
      if [ "$om" != "$nm" ] || [ "${omin:-}" != "${nmin:-}" ]; then
        sed -E 's/^ *//' <<< "$line"
      fi
    done)
if [ -n "$candidates" ]; then
  sed 's/^/      /' <<< "$candidates"
  echo "      (major/minor bumps — check their release notes if a :warning: is due)"
else
  echo "      none"
fi

# ---------- report -------------------------------------------------------------

echo
if [ "${#fails[@]}" -eq 0 ]; then
  echo "ALL CHECKS PASSED"
else
  echo "${#fails[@]} check(s) failed:"
  for f in "${fails[@]}"; do echo "  - $f"; done
  exit 1
fi
