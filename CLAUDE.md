# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Gradle Version Catalogs for the red_mad_robot Android team, published to Maven Central under `com.redmadrobot.versions`. Consumer projects import them in `settings.gradle.kts` to synchronize dependency versions.

There is no application code here — the "product" is three `libs.versions.toml` files plus the build machinery that validates and publishes them:

- **versions-androidx** — AndroidX libraries (catalog name in consumers: `androidx`)
- **versions-redmadrobot** — red_mad_robot open-source libraries (`rmr`)
- **versions-stack** — internal tech stack of the team (`stack`)

## Architecture

Multi-module build with two composite builds (`includeBuild` in `settings.gradle.kts`):

- `build-logic/` — convention plugins:
  - `convention.catalog.gradle.kts` — applied by every `versions-*` module; wires the module's `libs.versions.toml` into the `version-catalog` plugin and adds a disambiguation rule preferring the `androidJvm` Kotlin platform variant over `jvm`
  - `convention.publish.gradle.kts` — Maven Central publishing (vanniktech maven-publish + signing)
- `version-catalog-extensions/` — standalone plugin `com.redmadrobot.version-catalog-extensions` providing the `validateCatalog` task: it resolves every library and plugin declared in the catalog (so a typo'd coordinate or nonexistent version fails the build) and warns about unused version aliases. It is wired into `check`.

Each `versions-*` module contains only a `libs.versions.toml` and a two-line `build.gradle.kts` applying `convention.catalog`.

## Common Commands

```bash
# Full verification — what CI runs on every PR (includes validateCatalog)
./gradlew check

# Validate catalogs only (resolves every declared library/plugin)
./gradlew validateCatalog

# Validate a single catalog
./gradlew :versions-stack:validateCatalog

# Generate catalog TOML files (output: <module>/build/version-catalog/libs.versions.toml)
./gradlew generateCatalogAsToml

# Publish to local Maven for testing in a consumer project
./gradlew publishToMavenLocal
```

There are no unit tests; `validateCatalog` is the test suite.

## Catalog Update Workflow

Renovate keeps each dependency bump on its own remote branch `origin/renovate/<dep>`. The bi-weekly update collects those bumps onto a `dev-update-YYYY-MM-DD` branch, records them in `CHANGELOG.md`, and validates with `./gradlew validateCatalog`.

**Use the `update-version-catalog` skill for this** — it also handles adding new dependencies by Maven coordinates. All changelog formatting rules (entry format, release-note links, section structure) are inlined in that skill. Key changelog conventions:

- Sections per release: `### red_mad_robot`, `### AndroidX`, `### Stack`
- Entry format: ``- :arrow_up: [alias](release-notes-url) `old` → `new` ``
- Symbols: `:sparkle:` added, `:arrow_up:` updated, `:x:` removed, `:memo:` renamed, `:warning:` attention required (breaking/behaviour changes)

## Editing Catalogs

- Only stable versions; RC allowed for major-issue fixes or compatibility, pre-release allowed when no stable version exists
- All dependencies in one catalog release must be compatible with each other
- Library aliases follow Maven coordinates (`androidx.core:core` → `core` in the androidx catalog); drop module names duplicating the group; in the stack catalog a unique library name may omit the group (`com.jakewharton.timber:timber` → `timber`)
- Every library needs a version alias named after the library alias, so consumers can override versions; shared versions are named after the main dependency
- Plugin aliases follow the plugin ID; plugin artifacts are also declared in `[libraries]` for buildSrc/composite-build use
- Avoid Gradle reserved words (e.g. `extensions`) in aliases
- Full naming rules with examples: README.md "Naming and Structure"

## Releases

- Versions are dates: `YYYY.MM.DD`, kept in `gradle.properties` and the README "Usage" snippet (both updated by the script)
- `./release.sh` bumps the version, rewrites the `Unreleased` changelog section, commits, tags, and pushes; the tag push triggers `.github/workflows/release.yml`, which publishes to Maven Central and creates a GitHub release with notes extracted from `CHANGELOG.md`
- Details and manual steps: RELEASING.md
- Past changelogs are archived per year (`CHANGELOG-2025.md` etc.); only current entries live in `CHANGELOG.md`
