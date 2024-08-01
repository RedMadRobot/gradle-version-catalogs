# Releasing

1. Switch to a release branch.

2. Run the script `release.sh`:
   ```bash
   ./release.sh
   ````

3. The script will ask you if you want to push the changes and create a release tag.

4. Ensure `CHANGELOG.md` looks good and is ready to be published.
   Delete sections that don't contain changes.

5. Type "yes" to the console if everything is okay.
   Tag push triggers a GitHub Actions workflow,
   which publishes the release artifacts to Maven Central and creates a GitHub release.

6. Click the link displayed in the console to create a Pull Request for release branch.

7. Merge the Pull Request as soon as the "Check" workflow succeeds.
   It is recommended to use fast-forward merge to merge release branches.

## Manual release preparation

To prepare a release manually, follow the steps the script does:

1. Ensure the repository is up to date, and the release branch is checked out.

2. Update the version in `gradle.properties` and `README.md` ("Usage" section) using the current date as a version.

3. Update the `CHANGELOG.md`:
   1. Replace `Unreleased` section with the release version
   2. Add a link to the diff between the previous and the new version
   3. Add a new empty `Unreleased` section on the top

4. Commit the changes, create a tag on the latest commit, and push it to the remote repository.
   The tag should follow the format `[version]`.

5. Merge
