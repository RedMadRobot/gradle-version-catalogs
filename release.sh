#!/usr/bin/env bash
#
# Prepares the catalogs for release.
#
# Usage: ./release.sh
#
# Original release script: https://github.com/RedMadRobot/android-library-template/blob/main/release.sh

set -euo pipefail

# The script could be run from any directory.
cd "$(dirname "$0")"

# Configure the script
properties="gradle.properties"
changelog="CHANGELOG.md"
readme="README.md"
files_to_update_version=("$properties" "$readme")
github_repository_url="https://github.com/RedMadRobot/gradle-version-catalogs"

#region Utils
function property {
  grep "^${1}=" "$properties" | cut -d'=' -f2
}

function replace() {
  # Escape linebreaks
  local replacement=${2//$'\n'/\\\n}
  # Portable in-place edit.
  # See: https://stackoverflow.com/a/4247319
  sed -i".bak" -E "s~$1~$replacement~g" "$3"
  rm "$3.bak"
}

function diff_link() {
  echo -n "$github_repository_url/compare/${1}...${2}"
}
#endregion

# 0. Fetch remote changes
echo "️⏳ Updating local repository..."
git pull --quiet --rebase origin main
echo "✅ Repository updated."
echo

# 1. Calculate version values for later
last_version=$(property "version")
version=$(date "+%Y.%m.%d")
if [[ "$last_version" == "$version" ]]; then
  echo "🤔 Version $version is already set."
  exit 0
fi
echo "🚀 Update $last_version → $version"
echo

# 2. Update version everywhere
for file in "${files_to_update_version[@]}" ; do
  replace "$last_version" "$version" "$file"
  echo "✅ Updated version in $file"
done

# 3. Update header in CHANGELOG.md
header_replacement=\
"## [Unreleased]

### red_mad_robot

- *No changes*

### AndroidX

- *No changes*

### Stack

- *No changes*

## [$version]"
replace "^## \[Unreleased\].*" "$header_replacement" "$changelog"
echo "✅ Updated CHANGELOG.md header"

# 4. Add link to version diff
unreleased_diff_link="[unreleased]: $(diff_link "$version" "main")"
version_diff_link="[$version]: $(diff_link "$last_version" "$version")"
replace "^\[unreleased\]:.*" "$unreleased_diff_link\n$version_diff_link" "$changelog"
echo "✅ Added a diff link to CHANGELOG.md"

# 5. Ask if the changes should be pushed to remote branch
echo
echo "Do you want to commit the changes and create a release tag?"
echo "The release tag push will trigger a release workflow on CI."
read -p " Enter 'yes' to continue: " -r input
if [[ "$input" != "yes" ]]; then
  echo "👌 DONE."
  exit 0
fi

# 6. Push changes and trigger release on CI
echo
echo "⏳ Pushing the changes to the remote repository..."
git add "$readme" "$changelog" "$properties"
git commit --quiet --message "version: $version"
git tag "$version"
git push --quiet origin HEAD "$version"
echo "🎉 DONE."
echo "Create a Pull Request: $(diff_link "main" "$version")"
