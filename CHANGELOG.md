> **Symbols:** \
> :sparkle: - Added dependency \
> :arrow_up: - Updated dependency \
> :x: - Removed dependency \
> :memo: - Dependency or version name changed \
> :warning: - Be careful on update. Update may contain breaking changes or behaviour changes.

## [Unreleased]

### AndroidX

- **room:** (issue [b/269010533](https://issuetracker.google.com/issues/269010533) fixed)
  - :sparkle: `room-paging-guava`
  - :sparkle: `room-paging-rxjava2`
  - :sparkle: `room-paging-rxjava3`

### Stack

- :arrow_up: [gradle-android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases/tag/v2.7.0) `2.6.5` → `2.7.0`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases/tag/v8.1.2) `8.0.2` → `8.1.2`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v31-2-2) `31.2.0` → `31.2.2`
  - :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-3-5) `18.3.3` → `18.3.5`
  - :arrow_up: [firebase-crashlytics-gradle](https://firebase.google.com/support/release-notes/android#crashlytics_gradle_plugin_v2-9-4) `2.9.2` → `2.9.4`
- :arrow_up: [kotlinx-binaryCompatibilityValidator](https://github.com/Kotlin/binary-compatibility-validator/releases/tag/0.13.0) `0.12.1` → `0.13.0`
- :arrow_up: [kotlinx-serialization](https://github.com/Kotlin/kotlinx.serialization/releases/tag/v1.5.0-RC) `1.5.0-RC` → `1.5.0`
- :arrow_up: [versionsPlugin](https://github.com/ben-manes/gradle-versions-plugin/releases/tag/v0.46.0) `0.45.0` → `0.46.0`

## [2023.02.13]

### AndroidX

- :sparkle: [work](https://developer.android.com/topic/libraries/architecture/workmanager) `2.8.0`
  - :sparkle: [work-gcm](https://developer.android.com/guide/background/persistent/migrate-from-legacy/gcm)
  - :sparkle: [work-multiprocess](https://developer.android.com/topic/libraries/architecture/workmanager)
  - :sparkle: [work-runtime](https://developer.android.com/guide/background/persistent/getting-started)
  - :sparkle: [work-rxjava2](https://developer.android.com/guide/background/persistent/threading/rxworker)
  - :sparkle: [work-rxjava3](https://developer.android.com/guide/background/persistent/threading/rxworker)
  - :sparkle: [work-testing](https://developer.android.com/guide/background/testing/persistent/integration-testing)
- **room:**
  - :x: room-paging-guava (see [b/269010533](https://issuetracker.google.com/issues/269010533))
  - :x: room-paging-rxjava2 (see [b/269010533](https://issuetracker.google.com/issues/269010533))
  - :x: room-paging-rxjava3 (see [b/269010533](https://issuetracker.google.com/issues/269010533))
- :arrow_up: [appcompat](https://developer.android.com/jetpack/androidx/releases/appcompat#1.6.1) `1.6.0` → `1.6.1`
- :arrow_up: [browser](https://developer.android.com/jetpack/androidx/releases/browser#1.5.0) `1.4.0` → `1.5.0`
- :arrow_up: [camera](https://developer.android.com/jetpack/androidx/releases/camera#1.2.1) `1.2.0` → `1.2.1`
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.4.2) `1.4.0` → `1.4.2`

### Stack

- :arrow_up: [gradle-android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases) `2.6.2` → `2.6.5`
- :arrow_up: [dagger](https://github.com/google/dagger/releases/tag/dagger-2.45) `2.44.2` → `2.45`
- :arrow_up: [kotlin](https://github.com/JetBrains/kotlin/releases/tag/v1.8.10) `1.8.0` → `1.8.10` :warning:
- :arrow_up: [kotlinx-serialization](https://github.com/Kotlin/kotlinx.serialization/releases/tag/v1.5.0-RC) `1.4.1` → `1.5.0-RC` :warning:
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.8.10-1.0.9) `1.8.0-1.0.8` → `1.8.10-1.0.9`
- :arrow_up: [kotest](https://github.com/kotest/kotest/releases/tag/v5.5.5) `5.5.4` → `5.5.5`
- :arrow_up: [mockk](https://github.com/mockk/mockk/releases/tag/v1.13.4) `1.13.3` → `1.13.4`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases/tag/v8.0.2) `8.0.1` → `8.0.2`
- :arrow_up: [versionsPlugin](https://github.com/ben-manes/gradle-versions-plugin/releases/tag/v0.45.0) `0.44.0` → `0.45.0`

## [2023.01.25]

### AndroidX

- :arrow_up: [appcompat](https://developer.android.com/jetpack/androidx/releases/appcompat#1.6.0) `1.5.1` → `1.6.0`
- :arrow_up: [compose-bom](https://developer.android.com/jetpack/compose/setup#bom-version-mapping) `2022.12.00` → `2023.01.00`
  - :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.3.3) `1.3.2` → `1.3.3`
  - :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.3.3) `1.3.2` → `1.3.3`
  - :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.3.3) `1.3.2` → `1.3.3`
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.4.0) `1.4.0-alpha02` → `1.4.0`
- :arrow_up: [room](https://developer.android.com/jetpack/androidx/releases/room#2.5.0) `2.4.3` → `2.5.0`
  - :sparkle: `room-paging-guava`
  - :sparkle: `room-paging-rxjava2`
  - :sparkle: `room-paging-rxjava3`

### Stack

- :arrow_up: [gradle-android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases/tag/v2.6.2) `2.6.1` → `2.6.2`
- :arrow_up: [junit](https://junit.org/junit5/docs/5.9.2/release-notes/) `5.9.1` → `5.9.2`
- :arrow_up: [material](https://github.com/material-components/material-components-android/releases/tag/1.8.0) `1.7.0` → `1.8.0` :warning:
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases/tag/v8.0.0) `7.4.4` → `8.0.1` _(:warning: Breaking changes!)_
- :arrow_up: [reactivex-rxjava3](https://github.com/ReactiveX/RxJava/releases/tag/v3.1.6) `3.1.5` → `3.1.6`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v31-2-0) `31.1.1` → `31.2.0`
  - :arrow_up: [firebase-config](https://firebase.google.com/support/release-notes/android#remote-config_v21-2-1) `21.2.0` → `21.2.1`
  - :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-3-3) `18.3.2` → `18.3.3`
- :arrow_up: [gms-googleServices](https://firebase.google.com/support/release-notes/android#google-services_plugin_v4-3-15) `4.3.14` → `4.3.15`

## [2023.01.10]

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

[unreleased]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2023.02.13..main
[2023.02.13]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2023.01.25..2023.02.13
[2023.01.25]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2023.01.10..2023.01.25
[2023.01.10]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.12.13..2023.01.10
