# Releasing

1. Run the script `release.sh`:
   ```bash
   ./release.sh
   ````
2. The script will ask you if you want to push the changes and create a release tag.
3. Ensure `CHANGELOG.md` looks good and is ready to be published.
   Delete sections that don't contain changes.
4. Type "yes" to console if everything is okay.

Tag push will trigger GitHub Actions workflow, which will publish the release artifacts to Maven Central and create a GitHub release.

## Manual release preparation

To prepare a release manually, follow the steps the script does:

1. Ensure the repository is up-to-date, and the main branch is checked out.
2. Update the version in `gradle.properties` and `README.md` ("Usage" section) using the current date as a version.
3. Update the `CHANGELOG.md`:
   1. Replace `Unreleased` section with the release version
   2. Add a link to the diff between the previous and the new version
   3. Add a new empty `Unreleased` section on the top
4. Commit the changes, create a tag on the commit and push it to the remote repository
