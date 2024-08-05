> **Symbols:** \
> :sparkle: - Added dependency \
> :arrow_up: - Updated dependency \
> :x: - Removed dependency \
> :memo: - Dependency or version name changed \
> :warning: - Be careful on update. Update may contain breaking changes or behaviour changes.

## [Unreleased]

### red_mad_robot

- *No changes*

### AndroidX

- *No changes*

### Stack

- :arrow_up: [dagger](https://github.com/google/dagger/releases/tag/dagger-2.52) `2.51.1` → `2.51.2` :warning: *(Dagger KSP now requires at least KSP 1.9.24-1.0.20)*
- :arrow_up: plugin: [kotlinx-binaryCompatibilityValidator](https://github.com/Kotlin/binary-compatibility-validator/releases/tag/0.16.3) `0.16.2` → `0.16.3`

## [2024.08.01]

### red_mad_robot

- :sparkle: [konfeature](https://github.com/RedMadRobot/Konfeature) `0.1.0`
- :arrow_up: [infrastructure](https://github.com/RedMadRobot/gradle-infrastructure/releases/tag/v0.19) `0.18.1` → `0.19.1` :warning: *(a lot of breaking changes)*

### AndroidX

- :arrow_up: [activity](https://developer.android.com/jetpack/androidx/releases/activity#1.9.1) `1.9.0` → `1.9.1`
- :arrow_up: [annotation](https://developer.android.com/jetpack/androidx/releases/annotation#1.8.1) `1.8.0` → `1.8.1`
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.8.2) `1.8.1` → `1.8.2`
- :arrow_up: [lifecycle](https://developer.android.com/jetpack/androidx/releases/lifecycle#2.8.4) `2.8.3` → `2.8.4`
- :arrow_up: [media3](https://developer.android.com/jetpack/androidx/releases/media3#1.4.0) `1.3.1` → `1.4.0` :warning:
- :arrow_up: [paging](https://developer.android.com/jetpack/androidx/releases/paging#3.3.1) `3.3.0` → `3.3.1`

### Stack

- :sparkle: [Android Gradle Plugin](https://developer.android.com/build/releases/gradle-plugin) `8.5.1`
  - :sparkle: `android-tools-build-gradle`
  - :sparkle: `android-tools-build-gradle-api`
  - :sparkle: plugin: `android-application`
  - :sparkle: plugin: `android-dynamicFeature`
  - :sparkle: plugin: `android-kotlinMultiplatformLibrary`
  - :sparkle: plugin: `android-library`
- **kotlin** `2.0.0`:
  - :sparkle: [kotlin-composeCompiler-gradlePlugin](https://plugins.gradle.org/plugin/org.jetbrains.kotlin.plugin.compose/2.0.0)
  - :sparkle: plugin: [kotlin-compose](https://plugins.gradle.org/plugin/org.jetbrains.kotlin.plugin.compose/2.0.0)
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/2.0.0-1.0.24) `2.0.0-1.0.22` → `2.0.0-1.0.24`
- :arrow_up: [coil](https://github.com/coil-kt/coil/blob/main/CHANGELOG.md#270---july-17-2024) `2.6.0` → `2.7.0`
- :arrow_up: [mockk](https://github.com/mockk/mockk/releases/tag/1.13.12) `1.13.11` → `1.13.12`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v33-1-2) `33.1.1` → `33.1.2`
  - :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v19-0-3) `19.0.2` → `19.0.3`
- :arrow_up: plugin: [kotlinx-binaryCompatibilityValidator](https://github.com/Kotlin/binary-compatibility-validator/releases/tag/0.16.2) `0.15.0` → `0.16.2`
- :arrow_up: plugin: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/blob/main/CHANGELOG.md#version-1003-2024-07-16) `10.0.2` → `10.0.3`

## [2024.07.08]

### red_mad_robot

- *No changes*

### AndroidX

- :arrow_up: [camera](https://developer.android.com/jetpack/androidx/releases/camera#1.3.4) `1.3.3` → `1.3.4`
- :arrow_up: [compose-bom](https://developer.android.com/jetpack/compose/bom/bom-mapping) `2024.05.00` → `2024.06.00`
  - :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.6.8) `1.6.7` → `1.6.8` *(no changes)*
  - :arrow_up: [compose-foundation](https://developer.android.com/jetpack/androidx/releases/compose-foundation#1.6.8) `1.6.7` → `1.6.8` *(no changes)*
  - :arrow_up: [compose-material](https://developer.android.com/jetpack/androidx/releases/compose-material#1.6.8) `1.6.7` → `1.6.8` *(no changes)*
  - :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.6.8) `1.6.7` → `1.6.8` *(no changes)*
  - :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.6.8) `1.6.7` → `1.6.8`
  - :x: `compose-compiler` removed, use compose compiler gradle plugin instead. [Migration guide](https://www.jetbrains.com/help/kotlin-multiplatform-dev/compose-compiler.html#migrating-a-jetpack-compose-project) might be helpful.
- :arrow_up: [core-remote-views](https://developer.android.com/jetpack/androidx/releases/core#core_remote_views_version_11_2) `1.0.0` → `1.1.0`
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.8.1) `1.7.1` → `1.8.1`
- :arrow_up: [lifecycle](https://developer.android.com/jetpack/androidx/releases/lifecycle#2.8.3) `2.8.1` → `2.8.3`
- :arrow_up: [test-core](https://developer.android.com/jetpack/androidx/releases/test#core-1.6.1) `1.5.0` → `1.6.1`
- :arrow_up: [test-espresso](https://developer.android.com/jetpack/androidx/releases/test#espresso-3.6.1) `3.5.1` → `3.6.1`
  - :sparkle: [test-espresso-device](https://developer.android.com/jetpack/androidx/releases/test#espresso-device-1.0.0) `1.0.1`
- :arrow_up: [test-ext-junit](https://developer.android.com/jetpack/androidx/releases/test#ext.junit-1.2.1) `1.1.5` → `1.2.0`
- :arrow_up: [test-ext-truth](https://developer.android.com/jetpack/androidx/releases/test#ext.truth-1.6.0) `1.5.0` → `1.6.0`
- :arrow_up: [test-monitor](https://developer.android.com/jetpack/androidx/releases/test#monitor-1.7.1) `1.6.1` → `1.7.1`
- :arrow_up: [test-orchestrator](https://developer.android.com/jetpack/androidx/releases/test#orchestrator-1.5.0) `1.4.2` → `1.5.0`
- :arrow_up: [test-rules](https://developer.android.com/jetpack/androidx/releases/test#rules-1.6.1) `1.5.0` → `1.6.1`
- :arrow_up: [test-runner](https://developer.android.com/jetpack/androidx/releases/test#runner-1.6.1) `1.5.2` → `1.6.1`
- :arrow_up: [test-services](https://developer.android.com/jetpack/androidx/releases/test#services-1.5.0) `1.4.2` → `1.5.0`

### Stack

- :arrow_up: [kotest](https://github.com/kotest/kotest/releases/tag/v5.9.1) `5.9.0` → `5.9.1`
- :arrow_up: [kotlin](https://github.com/JetBrains/kotlin/releases/tag/v2.0.0) `1.9.24` → `2.0.0` :warning: *(breaking changes)*
  - [What’s new in the Kotlin 2.0.0](https://kotlinlang.org/docs/whatsnew20.html)
  - :x: `kotlin-stdlib-common`, `kotlin-stdlib-jdk7` and `kotlin-stdlib-jdk8` removed, use `kotlin-stdlib` instead
  - :x: `kotlin-test-annotations-common` and `kotlin-test-common` removed, use `kotlin-test` instead
- :arrow_up: [kotlinx-coroutines](https://github.com/Kotlin/kotlinx.coroutines/releases/tag/1.9.0-RC) `1.8.1` → `1.9.0-RC` :warning: *(breaking changes)*
- :arrow_up: [kotlinx-serialization](https://github.com/Kotlin/kotlinx.serialization/releases/tag/v1.7.1) `1.6.3` → `1.7.1` :warning:
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/2.0.0-1.0.22) `1.9.24-1.0.20` → `2.0.0-1.0.22` :warning: *(breaking changes)*
- :arrow_up: [tink](https://github.com/tink-crypto/tink-java/releases/tag/v1.14.0) `1.13.0` → `1.14.0`
- :arrow_up: [junit](https://junit.org/junit5/docs/5.10.3/release-notes/) `5.10.2` → `5.10.3`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v33-1-1) `33.1.0` → `33.1.1`
  - :arrow_up: [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v22-0-2) `22.0.1` → `22.0.2`
  - :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v19-0-2) `19.0.1` → `19.0.2`
  - :arrow_up: [firebase-crashlytics-gradle](https://firebase.google.com/support/release-notes/android#crashlytics_gradle_plugin_v3-0-2) `3.0.1` → `3.0.2`
- :arrow_up: plugin: [kotlinx-binaryCompatibilityValidator](https://github.com/Kotlin/binary-compatibility-validator/releases/tag/0.15.0) `0.14.0` → `0.15.0` :warning: *(breaking changes)*
- :arrow_up: plugin: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/blob/main/CHANGELOG.md#version-1002-2024-07-06) `9.2.0` → `10.0.2` :warning: *(breaking changes)*

## [2024.06.03]

> [!NOTE]
> This is the last release of the catalogs before Kotlin is moved to 2.0.

### AndroidX

- :arrow_up: [annotation](https://developer.android.com/jetpack/androidx/releases/annotation#1.8.0) `1.7.1` → `1.8.0`
- :arrow_up: [appcompat](https://developer.android.com/jetpack/androidx/releases/appcompat#1.7.0) `1.6.1` → `1.7.0`
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.5.14) `1.5.13` → `1.5.14`
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.7.1) `1.7.0` → `1.7.1`
- :arrow_up: [lifecycle](https://developer.android.com/jetpack/androidx/releases/lifecycle#2.8.0) `2.7.0` → `2.8.1` :warning: *(potentially breaking changes, KMP support)*
  - :x: `lifecycle-common-java8` removed, use `lifecycle-common` instead
- :arrow_up: [paging](https://developer.android.com/jetpack/androidx/releases/paging#3.3.0) `3.2.1` → `3.3.0` (KMP support)

### Stack

- :arrow_up: [kotlin](https://github.com/JetBrains/kotlin/releases/tag/v1.9.24) `1.9.23` → `1.9.24` :warning:
- :arrow_up: [kotlinx-coroutines](https://github.com/Kotlin/kotlinx.coroutines/releases/tag/1.8.1) `1.8.0` → `1.8.1`
- :arrow_up: [kotlinx-datetime](https://github.com/Kotlin/kotlinx-datetime/releases/tag/v0.6.0) `0.5.0` → `0.6.0` :warning: *(breaking changes)*
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.9.24-1.0.20) `1.9.23-1.0.20` → `1.9.24-1.0.20`
- :arrow_up: [kotest](https://github.com/kotest/kotest/releases/tag/v5.9.0) `5.8.1` → `5.9.0`
- :arrow_up: [mockk](https://github.com/mockk/mockk/releases/tag/1.13.11) `1.13.9` → `1.13.11`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/blob/main/CHANGELOG.md#version-920-2024-05-15) `9.1.0` → `9.2.0`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v33-1-0) `33.0.0` → `33.1.0`
  - :arrow_up: [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v22-0-1) `22.0.0` → `22.0.1`
  - :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v19-0-1) `19.0.0` → `19.0.1`
  - :arrow_up: [firebase-crashlytics-gradle](https://firebase.google.com/support/release-notes/android#crashlytics_gradle_plugin_v3-0-1) `3.0.0` → `3.0.1`
- :arrow_up: [gms-googleServices](https://developers.google.com/android/guides/releases#may_29_2024) `4.4.1` → `4.4.2`

### red_mad_robot

- :sparkle: [textvalue](https://github.com/RedMadRobot/textvalue) `1.0.0`

## [2024.05.05]

### AndroidX

- :arrow_up: [activity](https://developer.android.com/jetpack/androidx/releases/activity#1.9.0) `1.8.2` → `1.9.0`
- :arrow_up: [camera](https://developer.android.com/jetpack/androidx/releases/camera#1.3.3) `1.3.2` → `1.3.3`
- :arrow_up: [compose-bom](https://developer.android.com/jetpack/compose/bom/bom-mapping) `2024.04.00` → `2024.05.00`
  - :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.6.7) `1.6.5` → `1.6.7` *(no changes)*
  - :arrow_up: [compose-foundation](https://developer.android.com/jetpack/androidx/releases/compose-foundation#1.6.7) `1.6.5` → `1.6.7`
  - :arrow_up: [compose-material](https://developer.android.com/jetpack/androidx/releases/compose-material#1.6.7) `1.6.5` → `1.6.7` *(no changes)*
  - :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.6.7) `1.6.5` → `1.6.7` *(no changes)*
  - :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.6.7) `1.6.5` → `1.6.7`
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.5.13) `1.5.11` → `1.5.13` :warning: *(Strong Skipping Mode is not experimental anymore)*
- :arrow_up: [core](https://developer.android.com/jetpack/androidx/releases/core#1.13.1) `1.12.0` → `1.13.1` :warning: *(`minSdk` bumped to 19, `FingerprintManagerCompat` removed)*
- :arrow_up: [datastore](https://developer.android.com/jetpack/androidx/releases/datastore#1.1.1) `1.0.0` → `1.1.1` :warning: *(added KMP support)*
  - :sparkle: `datastore-core-okio` - KMP interfaces and implementations for datastores
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.7.0) `1.6.2` → `1.7.0`
  - :sparkle: [fragment-compose](https://developer.android.com/jetpack/androidx/releases/fragment#1.7.0)
- :arrow_up: [webkit](https://developer.android.com/jetpack/androidx/releases/webkit#1.11.0) `1.10.0` → `1.11.0`

### Stack

- :arrow_up: [leakcanary](https://square.github.io/leakcanary/changelog/#version-214-2024-04-17) `2.13` → `2.14`
- :arrow_up: [material](https://github.com/material-components/material-components-android/releases/tag/1.12.0) `1.11.0` → `1.12.0` :warning: *(`minSdk` bumped to 19)*
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v33-0-0) `32.8.0` → `33.0.0` :warning: *(`compileSdk` = 34, `minSdk` = 21)*
  - :arrow_up: [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v22-0-0) `21.6.1` → `22.0.0`
  - :arrow_up: [firebase-config](https://firebase.google.com/support/release-notes/android#remote-config_v22-0-0) `21.6.3` → `22.0.0`
  - :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v19-0-0) `18.6.3` → `19.0.0`
  - :arrow_up: [firebase-crashlytics-gradle](https://firebase.google.com/support/release-notes/android#crashlytics_gradle_plugin_v3-0-0) `2.9.9` → `3.0.0` :warning: *(breaking changes, requires AGP 8.1+)*
  - :arrow_up: [firebase-messaging](https://firebase.google.com/support/release-notes/android#messaging_v24-0-0) `23.4.1` → `24.0.0`
- :arrow_up: **plugin:** [doctor](https://runningcode.github.io/gradle-doctor/changelog/#0100) `0.9.2` → `0.10.0`

## [2024.04.10]

### AndroidX

- :arrow_up: [annotation-experimental](https://developer.android.com/jetpack/androidx/releases/annotation#annotation-experimental-1.4.1) `1.3.1` → `1.4.1`
- :arrow_up: [compose-bom](https://developer.android.com/jetpack/compose/bom/bom-mapping) `2024.03.00` → `2024.04.00`
  - :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.6.5) `1.6.4` → `1.6.5` *(no changes)*
  - :arrow_up: [compose-foundation](https://developer.android.com/jetpack/androidx/releases/compose-foundation#1.6.5) `1.6.4` → `1.6.5`
  - :arrow_up: [compose-material](https://developer.android.com/jetpack/androidx/releases/compose-material#1.6.5) `1.6.4` → `1.6.5` *(no changes)*
  - :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.6.5) `1.6.4` → `1.6.5` *(no changes)*
  - :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.6.5) `1.6.4` → `1.6.5` *(no changes)*
- :arrow_up: [media3](https://developer.android.com/jetpack/androidx/releases/media3#1.3.1) `1.3.0` → `1.3.1`
- :arrow_up: [navigation](https://developer.android.com/jetpack/androidx/releases/navigation#2.7.7) `2.7.6` → `2.7.7`

### Stack

- :arrow_up: [dagger](https://github.com/google/dagger/releases/tag/dagger-2.51.1) `2.51` → `2.51.1`
- :arrow_up: [detekt](https://github.com/detekt/detekt/releases/tag/v1.23.6) `1.23.5` → `1.23.6`
- :arrow_up: [kotlinx-collections-immutable](https://github.com/Kotlin/kotlinx.collections.immutable/releases/tag/v0.3.7) `0.3.5` → `0.3.7`
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.9.23-1.0.20) `1.9.23-1.0.19` → `1.9.23-1.0.20`
- :arrow_up: [leakcanary](https://square.github.io/leakcanary/changelog/#version-213-2024-01-03) `2.12` → `2.13`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/blob/main/CHANGELOG.md#version-910-2024-03-31) `9.0.10` → `9.1.0`
- :arrow_up: [retrofit](https://github.com/square/retrofit/releases/tag/2.11.0) `2.10.0` → `2.11.0`
- :arrow_up: [tink](https://github.com/tink-crypto/tink-java/releases) `1.7.0` → `1.13.0` :warning: *(huge version jump)*
- :arrow_up: **plugin:** [doctor](https://runningcode.github.io/gradle-doctor/changelog/#092) `0.9.1` → `0.9.2`

## [2024.03.22]

### AndroidX

- :arrow_up: [browser](https://developer.android.com/jetpack/androidx/releases/browser#1.8.0) `1.7.0` → `1.8.0`
- :arrow_up: [camera](https://developer.android.com/jetpack/androidx/releases/camera#1.3.2) `1.3.1` → `1.3.2`
- :arrow_up: [compose-bom](https://developer.android.com/jetpack/compose/bom/bom-mapping) `2024.02.01` → `2024.03.00`
  - :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.6.4) `1.6.2` → `1.6.4` *(no changes)*
  - :arrow_up: [compose-foundation](https://developer.android.com/jetpack/androidx/releases/compose-foundation#1.6.4) `1.6.2` → `1.6.4`
  - :arrow_up: [compose-material](https://developer.android.com/jetpack/androidx/releases/compose-material#1.6.4) `1.6.2` → `1.6.4`
  - :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.2.1) `1.2.0` → `1.2.1`
  - :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.6.4) `1.6.2` → `1.6.4` *(no changes)*
  - :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.6.4) `1.6.2` → `1.6.4` *(no changes)*
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.5.11) `1.5.10` → `1.5.11`
- :arrow_up: [media3](https://developer.android.com/jetpack/androidx/releases/media3#1.3.0) `1.2.1` → `1.3.0`

### Stack

- :arrow_up: [kotlin](https://github.com/JetBrains/kotlin/releases/tag/v1.9.23) `1.9.22` → `1.9.23` :warning:
- :arrow_up: [kotest](https://github.com/kotest/kotest/releases/tag/v5.8.1) `5.8.0` → `5.8.1`
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.9.23-1.0.19) `1.9.22-1.0.17` → `1.9.23-1.0.19`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/blob/main/CHANGELOG.md#version-9010-2024-03-15) `9.0.7` → `9.0.10`
- :arrow_up: [retrofit](https://github.com/square/retrofit/releases/tag/2.10.0) `2.9.0` → `2.10.0` :warning: *(read the changelog)*
  - :sparkle: [retrofit-bom](https://github.com/square/retrofit/tree/2.10.0/retrofit-bom)
  - :sparkle: [retrofit-converter-jabx3](https://github.com/square/retrofit/tree/2.10.0/retrofit-converters/jaxb3)
  - :x: version: `retrofit-converter-kotlinxSerialization` - this converter was moved to retrofit repository and shares version with retrofit
  - :warning: Packages of kotlinx.serialization converter was changed:
    ```diff
    -import com.jakewharton.retrofit2.converter.kotlinx.serialization.*
    +import retrofit2.converter.kotlinx.serialization.*
    ```
- :arrow_up: [turbine](https://github.com/cashapp/turbine/releases/tag/1.1.0) `1.0.0` → `1.1.0` :warning: *(may require tests fixing)*
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v32-8-0) `32.7.3` → `32.8.0`
  - :arrow_up: [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v21-6-1) `21.5.1` → `21.6.1`
  - :arrow_up: [firebase-config](https://firebase.google.com/support/release-notes/android#remote-config_v21-6-3) `21.6.2` → `21.6.3`
  - :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-6-3) `18.6.2` → `18.6.3`

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

[unreleased]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.08.01...main
[2024.08.01]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.07.08...2024.08.01
[2024.07.08]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.06.03...2024.07.08
[2024.06.03]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.05.05...2024.06.03
[2024.05.05]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.04.10...2024.05.05
[2024.04.10]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.03.22...2024.04.10
[2024.03.22]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.03.04...2024.03.22
[2024.03.04]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.02.07...2024.03.04
[2024.02.07]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2024.01.19...2024.02.07
[2024.01.19]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2023.12.21...2024.01.19
