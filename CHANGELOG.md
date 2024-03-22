> **Symbols:** \
> :sparkle: - Added dependency \
> :arrow_up: - Updated dependency \
> :x: - Removed dependency \
> :memo: - Dependency or version name changed \
> :warning: - Be careful on update. Update may contain breaking changes or behaviour changes.

## [Unreleased]

### Stack

- :arrow_up: [kotlin](https://github.com/JetBrains/kotlin/releases/tag/v1.9.23) `1.9.22` → `1.9.23` :warning:
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.9.23-1.0.19) `1.9.22-1.0.17` → `1.9.23-1.0.19`
- :arrow_up: [retrofit](https://github.com/square/retrofit/releases/tag/2.10.0) `2.9.0` → `2.10.0` :warning: *(read the changelog)*
  - :sparkle: [retrofit-bom](https://github.com/square/retrofit/tree/2.10.0/retrofit-bom)
  - :sparkle: [retrofit-converter-jabx3](https://github.com/square/retrofit/tree/2.10.0/retrofit-converters/jaxb3)
  - :x: version: `retrofit-converter-kotlinxSerialization` - this converter was moved to retrofit repository and shares version with retrofit
  - :warning: Packages of kotlinx.serialization converter was changed:
    ```diff
    -import com.jakewharton.retrofit2.converter.kotlinx.serialization.*
    +import retrofit2.converter.kotlinx.serialization.*
    ```

## [2024.03.04]

### AndroidX

- :arrow_up: [compose-bom](https://developer.android.com/jetpack/compose/bom/bom-mapping) `2024.01.00` → `2024.02.01` :warning:
  - :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.6.2) `1.6.0` → `1.6.2`
  - :arrow_up: [compose-foundation](https://developer.android.com/jetpack/androidx/releases/compose-foundation#1.6.2) `1.6.0` → `1.6.2`
  - :arrow_up: [compose-material](https://developer.android.com/jetpack/androidx/releases/compose-material#1.6.2) `1.6.0` → `1.6.2`
  - :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.2.0) `1.2.0-rc01` → `1.2.0` :warning: *(many new components)* \
    Article: [Material Design 3 for Compose 1.2](https://material.io/blog/material-3-compose-1-2)
  - :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.6.2) `1.6.0` → `1.6.2`
  - :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.6.2) `1.6.0` → `1.6.2`
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.5.10) `1.5.8` → `1.5.10`
- :arrow_up: [hilt](https://developer.android.com/jetpack/androidx/releases/hilt#hilt_version_12_2) `1.1.0` → `1.2.0`

### Stack

- :arrow_up: [coil](https://github.com/coil-kt/coil/blob/main/CHANGELOG.md#260---february-23-2024) `2.5.0` → `2.6.0`
- :arrow_up: [dagger](https://github.com/google/dagger/releases/tag/dagger-2.51) `2.50` → `2.51` :warning: *(potentially breaking changes)*
- :arrow_up: [dokka](https://github.com/Kotlin/dokka/releases/tag/v1.9.20) `1.9.10` → `1.9.20`
- :arrow_up: [kotlinx-coroutines](https://github.com/Kotlin/kotlinx.coroutines/releases/tag/1.8.0) `1.8.0-RC2` → `1.8.0`
- :arrow_up: [kotlinx-serialization](https://github.com/Kotlin/kotlinx.serialization/releases/tag/v1.6.3) `1.6.2` → `1.6.3`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v32-7-2) `32.7.1` → `32.7.3`
  - :arrow_up: [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v21-5-1) `21.5.0` → `21.5.1`
  - :arrow_up: [firebase-config](https://firebase.google.com/support/release-notes/android#remote-config_v21-6-2) `21.6.0` → `21.6.2`
  - :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-6-2) `18.6.1` → `18.6.2`
  - :arrow_up: [firebase-messaging](https://firebase.google.com/support/release-notes/android#messaging_v23-4-1) `23.4.0` → `23.4.1`
- :arrow_up: [gms-googleServices](https://developers.google.com/android/guides/releases#february_08_2024) `4.4.0` → `4.4.1`
- :arrow_up: plugin: [gradle-android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases/tag/v3.0.1) `3.0` → `3.0.1`

Skipped versions:

- [mockk](https://github.com/mockk/mockk/releases/tag/1.13.10) `1.13.10` - because of [mockk/mockk#1225](https://github.com/mockk/mockk/issues/1225)

## [2024.02.07]

### AndroidX

- :sparkle: [webkit](https://developer.android.com/develop/ui/views/layout/webapps/managing-webview) `1.10.0`
- :arrow_up: [compose-bom](https://developer.android.com/jetpack/compose/bom/bom-mapping) `2023.10.01` → `2024.01.00` :warning:
  - [What’s new in the Jetpack Compose January ’24 release](https://android-developers.googleblog.com/2024/01/whats-new-in-jetpack-compose-january-24-release.html)
  - :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.6.0) `1.5.4` → `1.6.0`
  - :arrow_up: [compose-foundation](https://developer.android.com/jetpack/androidx/releases/compose-foundation#1.6.0) `1.5.4` → `1.6.0`
  - :arrow_up: [compose-material](https://developer.android.com/jetpack/androidx/releases/compose-material#1.6.0) `1.5.4` → `1.6.0`
  - :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.2.0-rc01) `1.1.2` → `1.2.0-rc01` :warning: *(workaround for the issue: [#322214617](https://issuetracker.google.com/issues/322214617))*
  - :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.6.0) `1.5.4` → `1.6.0`
  - :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.6.0) `1.5.4` → `1.6.0`

### Stack

- :arrow_up: [accompanist](https://github.com/google/accompanist/releases/tag/v0.34.0) `0.32.0` → `0.34.0`
  - :x: Removed deprecated artifacts implemented in Compose 1.4 - `accompanist-flowlayout`, `accompanist-pager-*`
- :arrow_up: [detekt](https://detekt.dev/changelog#1235---2024-01-31) `1.23.4` → `1.23.5`
- :arrow_up: [epoxy](https://github.com/airbnb/epoxy/releases/tag/5.1.4) `5.1.3` → `5.1.4`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v32-7-1) `32.7.0` → `32.7.1`
  - :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-6-1) `18.6.0` → `18.6.1`
- :arrow_up: [junit](https://junit.org/junit5/docs/5.10.2/release-notes/) `5.10.1` → `5.10.2` :warning: *(breaking changes)*
- :arrow_up: [moshi](https://github.com/square/moshi/blob/master/CHANGELOG.md#version-1151) `1.15.0` → `1.15.1`
- :arrow_up: plugin: [kotlinx-binaryCompatibilityValidator](https://github.com/Kotlin/binary-compatibility-validator/releases/tag/0.14.0) `0.13.2` → `0.14.0` :warning: *(changes potentially affecting dump's content)*
- :arrow_up: plugin: [versions](https://github.com/ben-manes/gradle-versions-plugin/releases/tag/v0.51.0) `0.50.0` → `0.51.0`

## [2024.01.19]

### AndroidX

- :sparkle: [core-performance](https://developer.android.com/jetpack/androidx/releases/core#core_performance_version_10_2) `1.0.0`
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.5.8) `1.5.7` → `1.5.8`
- :arrow_up: [lifecycle](https://developer.android.com/jetpack/androidx/releases/lifecycle#2.7.0) `2.6.2` → `2.7.0` :warning: (proguard rules changed)
- :arrow_up: [media3](https://developer.android.com/jetpack/androidx/releases/media3#version_121_2) `1.2.0` → `1.2.1`

### Stack

- :arrow_up: [kotlin](https://github.com/JetBrains/kotlin/releases/tag/v1.9.22) `1.9.21` → `1.9.22`
- :arrow_up: [kotlinx-coroutines](https://github.com/Kotlin/kotlinx.coroutines/releases/tag/1.8.0-RC2) `1.8.0-RC` → `1.8.0-RC2`
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.9.22-1.0.16) `1.9.21-1.0.16` → `1.9.22-1.0.17`
- :arrow_up: [leakcanary](https://square.github.io/leakcanary/changelog/#version-213-2024-01-03) `2.11` → `2.13`
- :arrow_up: [mockk](https://github.com/mockk/mockk/releases/tag/1.13.9) `1.13.8` → `1.13.9`
- :arrow_up: [turbine](https://github.com/cashapp/turbine/releases/tag/1.0.0) `0.13.0` → `1.0.0`
- :arrow_up: plugin: [kotlinx-binaryCompatibilityValidator](https://github.com/Kotlin/binary-compatibility-validator/releases/tag/0.13.2) `0.13.1` → `0.13.2`
- :arrow_up: plugin: [doctor](https://runningcode.github.io/gradle-doctor/changelog/#091) `0.8.1` → `0.9.1`
- :arrow_up: plugin: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/blob/main/CHANGELOG.md#version-909-2024-01-17) `9.0.7` → `9.0.9`

## Changelogs for previous years

- [2023](CHANGELOG-2023.md)
- [2022](CHANGELOG-2022.md)

[unreleased]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.03.04.main
[2024.03.04]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.02.07..2024.03.04
[2024.02.07]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.01.19..2024.02.07
[2024.01.19]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2023.12.21..2024.01.19
