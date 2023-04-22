> **Symbols:** \
> :sparkle: - Added dependency \
> :arrow_up: - Updated dependency \
> :x: - Removed dependency \
> :memo: - Dependency or version name changed \
> :warning: - Be careful on update. Update may contain breaking changes or behaviour changes.

## [Unreleased]

### red_mad_robot

- :arrow_up: [infrastructure](https://github.com/RedMadRobot/gradle-infrastructure/releases/tag/v0.18.1) `0.18` → `0.18.1`
- :arrow_up: [inputmask](https://github.com/RedMadRobot/input-mask-android/releases) `6.1.0` → `7.2.4` *:warning:*

### AndroidX

- :arrow_up: [activity](https://developer.android.com/jetpack/androidx/releases/activity#1.7.1) `1.7.0` → `1.7.1`
- :arrow_up: [compose-bom](https://developer.android.com/jetpack/compose/bom/bom-mapping) `2023.04.00` → `2023.04.01`
  - :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.4.2) `1.4.1` → `1.4.2` *(no changes)*
  - :arrow_up: [compose-foundation](https://developer.android.com/jetpack/androidx/releases/compose-foundation#1.4.2) `1.4.1` → `1.4.2` *(no changes)*
  - :arrow_up: [compose-material](https://developer.android.com/jetpack/androidx/releases/compose-material#1.4.2) `1.4.1` → `1.4.2` *(no changes)*
  - :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.4.2) `1.4.1` → `1.4.2`
  - :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.4.2) `1.4.1` → `1.4.2`
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.4.6) `1.4.5` → `1.4.6` *(Depends on JDK 11 instead of JDK 17)*
- :arrow_up: [core-splashscreen](https://developer.android.com/jetpack/androidx/releases/core#core-splashscreen-1.0.1) `1.0.0` → `1.0.1`
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.5.7) `1.5.6` → `1.5.7`
- :arrow_up: [media3](https://developer.android.com/jetpack/androidx/releases/media3#1.0.1) `1.0.0` → `1.0.1`

### Stack

- :arrow_up: [kotest](https://kotest.io/docs/changelog.html#561-april-2023) `5.6.0` → `5.6.1`
- :arrow_up: [kotlinx-binaryCompatibilityValidator](https://github.com/Kotlin/binary-compatibility-validator/releases/tag/0.13.1) `0.13.0` → `0.13.1`
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.8.20-1.0.11) `1.8.20-1.0.10` → `1.8.20-1.0.11`
- :arrow_up: [retrofit-converter-kotlinxSerialization](https://github.com/JakeWharton/retrofit2-kotlinx-serialization-converter/releases/tag/1.0.0) `0.8.0` → `1.0.0`

## [2023.04.17]

### AndroidX

- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.4.5) `1.4.4` → `1.4.5` *(:warning: Kotlin 1.8.20 support, requires Java 17+)*
- :arrow_up: [compose-bom](https://developer.android.com/jetpack/compose/bom/bom-mapping) `2023.03.00` → `2023.04.00`
  - :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.4.1) `1.4.0` → `1.4.1`
  - :arrow_up: [compose-foundation](https://developer.android.com/jetpack/androidx/releases/compose-foundation#1.4.1) `1.4.0` → `1.4.1`
  - :arrow_up: [compose-material](https://developer.android.com/jetpack/androidx/releases/compose-material#1.4.1) `1.4.0` → `1.4.1`
  - :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.4.1) `1.4.0` → `1.4.1`
  - :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.4.1) `1.4.0` → `1.4.1`
- :arrow_up: [core](https://developer.android.com/jetpack/androidx/releases/core#1.10.0) `1.9.0` → `1.10.0` :warning:

### Stack

- :arrow_up: [coil](https://github.com/coil-kt/coil/blob/main/CHANGELOG.md#230---march-25-2023) `2.2.2` → `2.3.0`
  - :sparkle: [coil-test](https://coil-kt.github.io/coil/testing/)
- :arrow_up: [kotest](https://kotest.io/docs/changelog.html#560-april-2023) `5.5.5` → `5.6.0` *(:warning: breaking changes)*
  - :sparkle: [kotest-extensions](https://kotest.io/docs/extensions/system_extensions.html)
  - :sparkle: [kotest-extensions-blockhound](https://github.com/kotest/kotest/tree/v5.6.0/kotest-extensions/kotest-extensions-blockhound)
  - :sparkle: [kotest-extensions-htmlreporter](https://kotest.io/docs/extensions/html_reporter.html)
  - :sparkle: [kotest-extensions-http](https://github.com/kotest/kotest/tree/v5.6.0/kotest-extensions/kotest-extensions-http)
  - :sparkle: [kotest-extensions-junit5](https://github.com/kotest/kotest/tree/v5.6.0/kotest-extensions/kotest-extensions-junit5)
  - :sparkle: [kotest-extensions-junitxml](https://kotest.io/docs/extensions/junit_xml.html)
  - :sparkle: [kotest-extensions-now](https://kotest.io/docs/extensions/instant.html)
  - :sparkle: [kotest-framework-engine](https://github.com/kotest/kotest/tree/v5.6.0/kotest-framework/kotest-framework-engine)
  - :sparkle: [kotest-property-lifecycle](https://github.com/kotest/kotest/tree/v5.6.0/kotest-property/kotest-property-lifecycle)
- :arrow_up: [accompanist](https://github.com/google/accompanist/releases/tag/v0.30.1) `0.30.0` → `0.30.1`
- :arrow_up: [kotlin](https://kotlinlang.org/docs/whatsnew1820.html) `1.8.10` → `1.8.20` :warning:
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.8.20-1.0.10) `1.8.10-1.0.9` → `1.8.20-1.0.10` *(:warning: You may experience problems with incremental builds)*
- :arrow_up: [epoxy](https://github.com/airbnb/epoxy/releases/tag/5.12) `5.1.1` → `5.1.2`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v31-5-0) `31.4.0` → `31.5.0`
  - :arrow_up: [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v21-2-2) `21.2.1` → `21.2.2`
- :arrow_up: [gradle-android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases/tag/v2.7.1) `2.7.0` → `2.7.1`
- :arrow_up: [mockk](https://github.com/mockk/mockk/releases/tag/1.13.5) `1.13.4` → `1.13.5`

## [2023.04.02]

### AndroidX

- :sparkle: [media3](https://android-developers.googleblog.com/2023/03/media3-is-ready-to-play.html) `1.0.0`
  - media3-cast
  - media3-common
  - media3-database
  - media3-datasource
  - media3-datasource-cronet
  - media3-datasource-okhttp
  - media3-datasource-rtmp
  - media3-decoder
  - media3-effect
  - media3-exoplayer
  - media3-exoplayer-dash
  - media3-exoplayer-hls
  - media3-exoplayer-ima
  - media3-exoplayer-rtsp
  - media3-exoplayer-smoothstreaming
  - media3-exoplayer-workmanager
  - media3-extractor
  - media3-session
  - media3-test-utils
  - media3-test-utils
  - media3-ui
  - media3-ui-leanback
- :arrow_up: [activity](https://developer.android.com/jetpack/androidx/releases/activity#1.7.0) `1.6.1` → `1.7.0` *(:warning: converted to Kotlin)*
- :arrow_up: [annotation](https://developer.android.com/jetpack/androidx/releases/annotation#1.6.0) `1.5.0` → `1.6.0` *(:warning: converted to KMP library)*
- :arrow_up: [camera](https://developer.android.com/jetpack/androidx/releases/camera#1.2.2) `1.2.1` → `1.2.2`
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.4.4) `1.4.2` → `1.4.4`
- :arrow_up: [compose-bom](https://developer.android.com/jetpack/compose/bom/bom-mapping) `2023.01.00` → `2023.03.00` :warning:
  - :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.4.0) `1.3.3` → `1.4.0`
  - :arrow_up: [compose-foundation](https://developer.android.com/jetpack/androidx/releases/compose-foundation#1.4.0) `1.3.1` → `1.4.0`
  - :arrow_up: [compose-material](https://developer.android.com/jetpack/androidx/releases/compose-material#1.4.0) `1.3.1` → `1.4.0`
  - :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.4.0) `1.3.3` → `1.4.0`
  - :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.4.0) `1.3.3` → `1.4.0`
  > [What’s new in the Jetpack Compose March ’23 release](https://android-developers.googleblog.com/2023/03/whats-new-in-jetpack-compose-march-23-release.html)
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.5.6) `1.5.5` → `1.5.6`
- :arrow_up: [lifecycle](https://developer.android.com/jetpack/androidx/releases/lifecycle#2.6.1) `2.6.0` → `2.6.1`
- :arrow_up: [room](https://developer.android.com/jetpack/androidx/releases/room#2.5.1) `2.5.0` → `2.5.1`
- :arrow_up: [work](https://developer.android.com/jetpack/androidx/releases/work#2.8.1) `2.8.0` → `2.8.1`

### Stack

- :arrow_up: [accompanist](https://github.com/google/accompanist/releases/tag/v0.30.0) `0.28.0` → `0.30.0`
  - :warning: [accompanist-pager](https://google.github.io/accompanist/pager/#migration) is deprecated and may be removed soon
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v31-4-0) `31.2.3` → `31.4.0`
  - :arrow_up: [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v21-2-1) `21.2.0` → `21.2.1`
  - :arrow_up: [firebase-config](https://firebase.google.com/support/release-notes/android#remote-config_v21-3-0) `21.2.1` → `21.3.0`
  - :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-3-6) `18.3.5` → `18.3.6`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases/tag/v8.2.1) `8.1.2` → `8.2.1`

## [2023.03.21]

### red_mad_robot

- :arrow_up: [infrastructure](https://github.com/RedMadRobot/gradle-infrastructure/releases/tag/v0.18) `0.17` → `0.18` *(:warning: read changelog)*

### AndroidX

- **room:** (issue [b/269010533](https://issuetracker.google.com/issues/269010533) fixed)
  - :sparkle: `room-paging-guava`
  - :sparkle: `room-paging-rxjava2`
  - :sparkle: `room-paging-rxjava3`
- :arrow_up: [lifecycle](https://developer.android.com/jetpack/androidx/releases/lifecycle#2.6.0) `2.5.1` → `2.6.0` *(:warning: converted to Kotlin)*
- :arrow_up: [paging-compose](https://developer.android.com/jetpack/androidx/releases/paging#1.0.0-alpha18) `1.0.0-alpha17` → `1.0.0-alpha18`
- :arrow_up: [recyclerview](https://developer.android.com/jetpack/androidx/releases/recyclerview#1.3.0) `1.2.1` → `1.3.0` *(:warning: requires migration if used with Compose)*

### Stack

- :arrow_up: [dokka](https://github.com/Kotlin/dokka/releases/tag/v1.8.10) `1.7.20` → `1.8.10`
- :arrow_up: [gradle-android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases/tag/v2.7.0) `2.6.5` → `2.7.0`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases/tag/v8.1.2) `8.0.2` → `8.1.2`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v31-2-3) `31.2.0` → `31.2.3`
  - :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-3-5) `18.3.3` → `18.3.5`
  - :arrow_up: [firebase-crashlytics-gradle](https://firebase.google.com/support/release-notes/android#crashlytics_gradle_plugin_v2-9-4) `2.9.2` → `2.9.4`
  - :arrow_up: [firebase-messaging](https://firebase.google.com/support/release-notes/android#messaging_v23-1-2) `23.1.1` → `23.1.2`
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

[unreleased]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2023.04.17..main
[2023.04.17]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2023.04.02..2023.04.17
[2023.04.02]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2023.03.21..2023.04.02
[2023.03.21]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2023.02.13..2023.03.21
[2023.02.13]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2023.01.25..2023.02.13
[2023.01.25]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2023.01.10..2023.01.25
[2023.01.10]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.12.13..2023.01.10
