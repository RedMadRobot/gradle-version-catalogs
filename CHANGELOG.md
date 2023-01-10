> **Symbols:** \
> :sparkle: - Added dependency \
> :arrow_up: - Updated dependency \
> :x: - Removed dependency \
> :memo: - Dependency or version name changed \
> :warning: - Be careful on update. Update may contain breaking changes or behaviour changes.

## [Unreleased]

> #### :information_source: Note
>
> This update changes Kotlin version to `1.8.0` which is not compatible with compose-compiler `1.4.0-alpha02`.
> If you use Jetpack Compose in your project, you can either:
> - [overwrite version](https://docs.gradle.org/current/userguide/platforms.html#sec:overwriting-catalog-versions) of Kotlin in `settings.gradle`
> - or use [prerelease version of compose-compiler](https://androidx.dev/storage/compose-compiler/repository)

### AndroidX

- :arrow_up: [test-espresso](https://developer.android.com/jetpack/androidx/releases/test#espresso-3.5.1) `3.5.0` → `3.5.1`
- :arrow_up: [test-ext-junit](https://developer.android.com/jetpack/androidx/releases/test#ext.junit-1.1.5) `1.1.4` → `1.1.5`
- :arrow_up: [test-monitor](https://developer.android.com/jetpack/androidx/releases/test#monitor-1.6.1) `1.6.0` → `1.6.1`
- :arrow_up: [test-runner](https://developer.android.com/jetpack/androidx/releases/test#runner-1.5.2) `1.5.0` → `1.5.2`

### Stack

- **dagger-hilt:**
  - :memo: `dagger-hilt-testing` → `dagger-hilt-android-testing` - renamed to follow package name
  - :sparkle: `dagger-hilt-android-compiler`
  - :sparkle: plugin [dagger-hilt-android](https://dagger.dev/hilt/gradle-setup#hilt-gradle-plugin) and library `dagger-hilt-android-gradlePlugin`
- :arrow_up: [gradle-android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases/tag/v2.6.1) `2.6.0` → `2.6.1`
- :arrow_up: [kotlin](https://kotlinlang.org/docs/whatsnew18.html) `1.7.21` → `1.8.0` *(:warning:)*
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.8.0-1.0.8) `1.7.21-1.0.8` → `1.8.0-1.0.8`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases) `7.4.1` → `7.4.4`

## Changelogs for previous years

- [2022](CHANGELOG-2022.md)

[unreleased]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.12.13..main
