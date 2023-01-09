> **Symbols:** \
> :sparkle: - Added dependency \
> :arrow_up: - Updated dependency \
> :x: - Removed dependency \
> :memo: - Dependency or version name changed \
> :warning: - Be careful on update. Update may contain breaking changes or behaviour changes.

## [Unreleased]

### AndroidX

- :arrow_up: [test-monitor](https://developer.android.com/jetpack/androidx/releases/test#monitor-1.6.1) `1.6.0` → `1.6.1`
- :arrow_up: [test-runner](https://developer.android.com/jetpack/androidx/releases/test#runner-1.5.2) `1.5.0` → `1.5.2`

### Stack

- :arrow_up: [kotlin](https://kotlinlang.org/docs/whatsnew18.html) `1.7.21` → `1.8.0` *(:warning:)*
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.8.0-1.0.8) `1.7.21-1.0.8` → `1.8.0-1.0.8`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases) `7.4.1` → `7.4.4`

## [2022.12.13]

### AndroidX

- :arrow_up: [camera](https://developer.android.com/jetpack/androidx/releases/camera#1.2.0) `1.1.0` → `1.2.0`
- :arrow_up: [compose-bom](https://developer.android.com/jetpack/androidx/releases/compose#2022.12.00) `2022.11.00` → `2022.12.00`
- :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.2.0) `1.3.1` → `1.3.2`
- :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.2.0) `1.3.1` → `1.3.2`
- :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.2.0) `1.3.1` → `1.3.2`
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.5.5) `1.5.4` → `1.5.5`

### Stack

- :x: `material-compose-themeAdapter` _(use `accompanist-themeadapter-material` instead)_
- :x: `material-compose-themeAdapter3` _(use `accompanist-themeadapter-material3` instead)_
- :sparkle: [javax-inject](https://docs.oracle.com/javaee/6/api/javax/inject/package-summary.html) `1`
- :arrow_up: [accompanist](https://github.com/google/accompanist/releases/tag/v0.28.0) `0.27.1` → `0.28.0`
  - :x: `accompanist-insets` _(use compose insets instead)_
  - :sparkle: [accompanist-testharness](https://google.github.io/accompanist/testharness/)
  - :sparkle: [accompanist-themeadapter-core](https://google.github.io/accompanist/themeadapter-core/)
  - :sparkle: [accompanist-themeadapter-material](https://google.github.io/accompanist/themeadapter-material/)
  - :sparkle: [accompanist-themeadapter-material3](https://google.github.io/accompanist/themeadapter-material3/)
  - :memo: `accompanist-appcompatTheme` → `accompanist-themeadapter-appcompat`
- :arrow_up: [detekt](https://github.com/detekt/detekt/releases/tag/v1.22.0) `1.22.0-RC3` → `1.22.0`
- :arrow_up: [mockk](https://github.com/mockk/mockk/releases/tag/1.13.3) `1.13.2` → `1.13.3`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases) `7.3.2` → `7.4.1`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v31-1-1) `31.0.3` → `31.1.1`
- :arrow_up: [firebase-messaging](https://firebase.google.com/support/release-notes/android#messaging_v23-1-1) `23.1.0` → `23.1.1`

## [2022.11.18]

### Stack

- :arrow_up: [accompanist](https://github.com/google/accompanist/releases/tag/v0.27.1) `0.27.0` → `0.27.1`
- :arrow_up: [dagger](https://github.com/google/dagger/releases/tag/dagger-2.44.2) `2.44.1` → `2.44.2`
- :arrow_up: [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.2.0) `1.1.22` → `1.2.0`
- :arrow_up: [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.1.0) `1.0.22` → `1.1.0`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases/tag/v7.3.2) `7.3.0` → `7.3.2`

## [2022.11.12]

### AndroidX

- :sparkle: **AndroidX test**:
  - :sparkle: [test-annotation](https://developer.android.com/reference/kotlin/androidx/test/annotation/package-summary) `1.0.1`
  - :sparkle: [test-core](https://developer.android.com/training/testing/instrumented-tests/androidx-test-libraries/test-setup) `1.5.0`
  - :sparkle: [test-espresso](https://developer.android.com/training/testing/espresso) `3.5.0`
  - :sparkle: [test-ext-junit](https://developer.android.com/training/testing/instrumented-tests/androidx-test-libraries/test-setup) `1.1.4`
  - :sparkle: [test-ext-truth](https://developer.android.com/training/testing/instrumented-tests/androidx-test-libraries/test-setup) `1.5.0`
  - :sparkle: [test-monitor](https://cs.android.com/androidx/android-test/+/master:runner/monitor/java/androidx/test/) `1.6.0`
  - :sparkle: [test-orchestrator](https://developer.android.com/training/testing/instrumented-tests/androidx-test-libraries/runner#use-android) `1.4.2`
  - :sparkle: [test-runner](https://developer.android.com/training/testing/instrumented-tests/androidx-test-libraries/runner) `1.5.0`
  - :sparkle: [test-rules](https://developer.android.com/training/testing/instrumented-tests/androidx-test-libraries/rules) `1.5.0`
  - :sparkle: [test-services](https://developer.android.com/training/testing/instrumented-tests/androidx-test-libraries/test-setup) `1.4.2`
- :arrow_up: [compose-bom](https://developer.android.com/jetpack/androidx/releases/compose#2022.11.00) `2022.10.00` → `2022.11.00`
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.4.0-alpha02) `1.3.2` → `1.4.0-alpha02` *(:warning: Alpha version used to support Kotlin 1.7.21)*
- :arrow_up: [compose-*](https://developer.android.com/jetpack/androidx/releases/compose-foundation#1.3.1) `1.3.0` → `1.3.1`
- :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.1) `1.0.0` → `1.0.1`
- :arrow_up: [paging-compose](https://developer.android.com/jetpack/androidx/releases/paging#1.0.0-alpha17) `1.0.0-alpha16` → `1.0.0-alpha17`

### Stack

- :arrow_up: [detekt](https://github.com/detekt/detekt/releases/tag/v1.22.0-RC3) `1.22.0-RC2` → `1.22.0-RC3`
  - :sparkle: [detekt-rules-libraries](https://detekt.dev/docs/next/rules/libraries)
  - :sparkle: [detekt-rules-ruleauthors](https://detekt.dev/docs/next/rules/ruleauthors)
- :arrow_up: [dagger](https://github.com/google/dagger/releases/tag/dagger-2.44.1) `2.44.0` → `2.44.1`
- :arrow_up: [epoxy](https://github.com/airbnb/epoxy/releases/tag/5.1.1) `5.1.0` → `5.1.1`
- :arrow_up: [kotlin](https://github.com/JetBrains/kotlin/releases/tag/v1.7.21) `1.7.20` → `1.7.21`
- :arrow_up: [kotest](https://github.com/kotest/kotest/releases) `5.5.2` → `5.5.4` *(:warning: JUnit 5.8+ is required)*
- :arrow_up: [ksp](https://github.com/google/ksp/releases/) `1.7.20-1.0.7` → `1.7.21-1.0.8`
- :arrow_up: [leakcanary](https://square.github.io/leakcanary/changelog/#version-210-2022-11-10) `2.9.1` → `2.10.0`
- :arrow_up: [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.1.22) `1.1.21` → `1.1.22`
- :arrow_up: [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.0.22) `1.0.21` → `1.0.22`
- :arrow_up: [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v21-2-0) `21.1.1` → `21.2.0`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v31-0-3) `30.5.0` → `31.0.3`
- :arrow_up: [firebase-config](https://firebase.google.com/support/release-notes/android#config_v21-2-0) `21.1.2` → `21.2.0`
- :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-3-2) `18.2.13` → `18.3.2`
- :arrow_up: [firebase-messaging](https://firebase.google.com/support/release-notes/android#messaging_v23-1-0) `23.0.8` → `23.1.0`
- :arrow_up: [gms-googleServices](https://firebase.google.com/support/release-notes/android#google-services_plugin_v4-3-14) `4.3.13` → `4.3.14`
- :arrow_up: [versionsPlugin](https://github.com/ben-manes/gradle-versions-plugin/releases/tag/v0.44.0) `0.42.0` → `0.44.0`

## [2022.10.26]

### AndroidX

> :warning: **Breaking change:** Google has announced separated versioning for each `compose-*` artifact.
> So, since this version, version ref `compose` was removed in favor of separated version refs `compose-animation`, `compose-foundation` etc.

- :sparkle: [compose-bom](https://developer.android.com/jetpack/compose/setup#using-the-bom) `2022.10.00`
- :arrow_up: [activity](https://developer.android.com/jetpack/androidx/releases/activity#1.6.1) `1.6.0` → `1.6.1`
- :arrow_up: [compose-animation](https://developer.android.com/jetpack/androidx/releases/compose-animation#1.3.0) `1.2.1` → `1.3.0`
- :arrow_up: [compose-foundation](https://developer.android.com/jetpack/androidx/releases/compose-foundation#1.3.0) `1.2.1` → `1.3.0`
- :arrow_up: [compose-material](https://developer.android.com/jetpack/androidx/releases/compose-material#1.3.0) `1.2.1` → `1.3.0`
- :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.0) `1.0.0-rc01` → `1.0.0`
- :arrow_up: [compose-runtime](https://developer.android.com/jetpack/androidx/releases/compose-runtime#1.3.0) `1.2.1` → `1.3.0`
- :arrow_up: [compose-ui](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.3.0) `1.2.1` → `1.3.0`
- :arrow_up: [core-googleShortcuts](https://developer.android.com/jetpack/androidx/releases/core#core-google-shortcuts-1.1.0) `1.0.1` → `1.1.0`
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.5.4) `1.5.3` → `1.5.4`
- :arrow_up: [navigation](https://developer.android.com/jetpack/androidx/releases/navigation#2.5.3) `2.5.2` → `2.5.3`

### Stack

- :arrow_up: [accompanist](https://github.com/google/accompanist/releases/tag/v0.27.0) `0.25.1` → `0.27.0`
  - :sparkle: [accompanist-adaptive](https://google.github.io/accompanist/adaptive/)
- :arrow_up: [kotlinx-binaryCompatibilityValidator](https://github.com/Kotlin/binary-compatibility-validator/releases/) `0.11.1` → `0.12.1`
- :arrow_up: [dokka](https://github.com/Kotlin/dokka/releases/tag/v1.7.20) `1.7.10` → `1.7.20`
- :arrow_up: [epoxy](https://github.com/airbnb/epoxy/releases/tag/5.1.0) `5.0.0` → `5.1.0`
- :arrow_up: [kotest](https://github.com/kotest/kotest/releases/tag/v5.5.2) `5.5.0` → `5.5.2`
- :arrow_up: [kotlinx-serialization](https://github.com/Kotlin/kotlinx.serialization/releases/tag/v1.4.1) `1.4.0` → `1.4.1`
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.7.20-1.0.7) `1.7.20-1.0.6` → `1.7.20-1.0.7`
- :arrow_up: [material](https://github.com/material-components/material-components-android/releases/tag/1.7.0) `1.6.1` → `1.7.0`
- :arrow_up: [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.1.21) `1.1.19` → `1.1.21`
- :arrow_up: [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.0.21) `1.0.19` → `1.0.21`
- :arrow_up: [gradle-android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases/tag/v2.6.0) `2.5.7` → `2.6.0`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases/tag/v7.3.0) `7.2.1` → `7.3.0`
- :arrow_up: [detekt](https://github.com/detekt/detekt/releases/tag/v1.22.0-RC2) `1.22.0-RC1` → `1.22.0-RC2`

## [2022.10.06]

### AndroidX

- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.3.2) `1.3.1` → `1.3.2`
- :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.0-rc01) `1.0.0-beta03` → `1.0.0-rc01`

### Stack

- :sparkle: [kotlinx-collections-immutable](https://github.com/Kotlin/kotlinx.collections.immutable) `0.3.5`
- :arrow_up: [coil](https://github.com/coil-kt/coil/blob/main/CHANGELOG.md#222---october-1-2022) `2.2.1` → `2.2.2`
- :arrow_up: [detekt-rules-compose](https://github.com/appKODE/detekt-rules-compose/releases/tag/v1.2.2) `1.2.1` → `1.2.2`
- :arrow_up: [epoxy](https://github.com/airbnb/epoxy/releases/tag/5.0.0) `4.6.4` → `5.0.0` *(:warning: migrated to KSP)*
  - :sparkle: [epoxy-compose](https://github.com/airbnb/epoxy/tree/master/epoxy-compose/src/main/java/com/airbnb/epoxy)
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v30-5-0) `30.4.1` → `30.5.0`
- :arrow_up: [kotest](https://kotest.io/docs/changelog.html#550-october-2022) `5.4.2` → `5.5.0`
- :arrow_up: [kotlin](https://kotlinlang.org/docs/whatsnew1720.html) `1.7.10` → `1.7.20` *(:warning:)*
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.7.20-1.0.6) `1.7.10-1.0.6` → `1.7.20-1.0.6`
- :arrow_up: [mockk](https://github.com/mockk/mockk/releases/) `1.12.8` → `1.13.2`

## [2022.09.23]

### AndroidX

- :sparkle: [annotation](https://developer.android.com/jetpack/androidx/releases/annotation) `1.5.0`
- :sparkle: [annotation-experimental](https://developer.android.com/jetpack/androidx/releases/annotation) `1.3.0`
- :arrow_up: [activity](https://developer.android.com/jetpack/androidx/releases/activity#1.6.0) `1.5.1` → `1.6.0`
- :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.0-beta03) `1.0.0-beta02` → `1.0.0-beta03`
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.5.3) `1.5.2` → `1.5.3`

### Stack

- :arrow_up: [dagger](https://github.com/google/dagger/releases/tag/dagger-2.44) `2.43.2` → `2.44` *(:warning: potentially breaking changes)*
- :arrow_up: [detekt](https://github.com/detekt/detekt/releases/tag/v1.22.0-RC1) `1.21.0` → `1.22.0-RC1`
- :arrow_up: [junit](https://junit.org/junit5/docs/5.9.1/release-notes/) `5.9.0` → `5.9.1`
- :arrow_up: [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.1.19) `1.1.18` → `1.1.19`
- :arrow_up: [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.0.19) `1.0.18` → `1.0.19`
- :arrow_up: [mockk](https://github.com/mockk/mockk/releases/tag/v1.12.8) `1.12.7` → `1.12.8`
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases) `7.1.2` → `7.2.1`
- :arrow_up: [gradle-android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases/tag/v2.5.7) `2.5.6` → `2.5.7`

## [2022.09.13]

### AndroidX

- :arrow_up: [appcompat](https://developer.android.com/jetpack/androidx/releases/appcompat#1.5.1) `1.5.0` → `1.5.1`
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.3.1) `1.3.0` → `1.3.1`
- :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.0-beta02) `1.0.0-alpha16` → `1.0.0-beta02`
- :arrow_up: [core](https://developer.android.com/jetpack/androidx/releases/core#1.9.0) `1.8.0` → `1.9.0`
- :arrow_up: [navigation](https://developer.android.com/jetpack/androidx/releases/navigation#2.5.2) `2.5.1` → `2.5.1`
- :arrow_up: [paging-compose](https://developer.android.com/jetpack/androidx/releases/paging#1.0.0-alpha16) `1.0.0-alpha15` → `1.0.0-alpha16`

### Stack

- :sparkle: [firebase-config](https://firebase.google.com/docs/remote-config) `21.1.2`
- :arrow_up: [coil](https://github.com/coil-kt/coil/blob/main/CHANGELOG.md#221---september-8-2022) `2.2.0` → `2.2.1`
- :arrow_up: [kotlinx-binaryCompatibilityValidator](https://github.com/Kotlin/binary-compatibility-validator/releases/tag/0.11.1) `0.11.0` → `0.11.1`
- :arrow_up: [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.1.18) `1.1.16` → `1.1.18`
- :arrow_up: [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.0.18) `1.0.16` → `1.0.18`
- :arrow_up: [moshi](https://github.com/square/moshi/blob/master/CHANGELOG.md#version-1140) `1.13.0` → `1.14.0`
- :arrow_up: [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v21-1-1) `21.1.0` → `21.1.1`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v30-4-1) `30.3.2` → `30.4.1`
- :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-2-13) `18.2.12` → `18.2.13`
- :arrow_up: [firebase-messaging](https://firebase.google.com/support/release-notes/android#messaging_v23-0-8) `23.0.7` → `23.0.8`

## [2022.08.29]

### Stack

- :sparkle: [detekt-rules-compose](https://github.com/appKODE/detekt-rules-compose) `1.2.1`
- :arrow_up: [coil](https://github.com/coil-kt/coil/blob/main/CHANGELOG.md#220---august-16-2022) `2.1.0` → `2.2.0`
- :arrow_up: [kotest](https://github.com/kotest/kotest/compare/v5.4.1...v5.4.2) `5.4.1` → `5.4.2`
- :arrow_up: [kotlinx-serialization](https://github.com/Kotlin/kotlinx.serialization/releases/tag/v1.4.0) `1.3.3` → `1.4.0`
- :arrow_up: [mockk](https://github.com/mockk/mockk/releases/tag/1.12.7) `1.12.5` → `1.12.7`
  - :x: `mockk-common` (:warning: see [mockk/mockk#854](https://github.com/mockk/mockk/issues/854))
  - :x: `mockk-agent-common` (:warning: see [mockk/mockk#854](https://github.com/mockk/mockk/issues/854))
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases/tag/v7.1.2) `7.1.1` → `7.1.2`

## [2022.08.11]

### AndroidX

- :arrow_up: [appcompat](https://developer.android.com/jetpack/androidx/releases/appcompat#1.5.0) `1.4.2` → `1.5.0`
- :arrow_up: [compose](https://android.googlesource.com/platform/frameworks/support/+log/1e0793130863c72dc4a2d02bc975128f3ef0158b..3c2d5397fb8ef697bb04bfc7e98721e2dc0aa255/compose) `1.2.0` → `1.2.1`
- :arrow_up: [compose-compiler](https://android.googlesource.com/platform/frameworks/support/+log/a7f0710ad21f556f0dde9bf7bdab6d2135170fd4..ebb3487237935f82b9c7fe593e85aa9cd8f7d33e/compose/compiler) `1.3.0-rc01` → `1.3.0`
  - :sparkle: Since now `compose-compiler` listed not only in **versions** but also in **libraries** section
- :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.0-alpha16) `1.0.0-alpha15` → `1.0.0-alpha16`
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.5.2) `1.5.1` → `1.5.2`

### Stack

- :arrow_up: [accompanist](https://github.com/google/accompanist/releases/tag/v0.25.1) `0.25.0` → `0.25.1`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v30-3-2) `30.3.1` → `30.3.2`
- :arrow_up: [firebase-messaging](https://firebase.google.com/support/release-notes/android#messaging_v23-0-7) `23.0.6` → `23.0.7`
- :arrow_up: [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.1.16) `1.1.15` → `1.1.16`
- :arrow_up: [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.0.16) `1.0.15` → `1.0.16`
- :arrow_up: [tink](https://github.com/google/tink/releases/tag/v1.7.0) `1.6.1` → `1.7.0`

## [2022.08.04]

### red_mad_robot

- :arrow_up: [pinkman](https://github.com/RedMadRobot/PINkman/releases/tag/1.3.2) `1.3.1` → `1.3.2`

### AndroidX

- :sparkle: [customview](https://developer.android.com/jetpack/androidx/releases/customview) `1.1.0`
- :sparkle: [customview-poolingcontainer](https://developer.android.com/jetpack/androidx/releases/customview#customview-poolingcontainer-1.0.0) `1.0.0`

### Stack

- :arrow_up: [dagger](https://github.com/google/dagger/releases/tag/dagger-2.43.2) `2.43.1` → `2.43.2`

## [2022.07.30]

> Be careful if you use detekt with type resolution!
> This catalog update bumps Kotlin to 1.7.10, which is not supported by type resolution mode in detekt.
> Detekt [will support](https://github.com/detekt/detekt/pull/4821) Kotlin 1.7.10 in 1.22.0

### red_mad_robot

- :arrow_up: [infrastructure](https://github.com/RedMadRobot/gradle-infrastructure/releases) `0.16.2` → `0.17` *(:warning: potentially breaking changes)*
- :arrow_up: [pinkman](https://github.com/RedMadRobot/PINkman/releases/tag/1.3.1) `1.3.0` → `1.3.1`

### AndroidX

- :arrow_up: [activity](https://developer.android.com/jetpack/androidx/releases/activity#1.5.1) `1.5.0` → `1.5.1`
- :arrow_up: [compose](https://android-developers.googleblog.com/2022/07/jetpack-compose-1-2-is-now-stable.html) `1.2.0-rc03` → `1.2.0`
- :arrow_up: [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.3.0-rc01) `1.2.0` → `1.3.0-rc01`
- :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.0-alpha15) `1.0.0-alpha14` → `1.0.0-alpha15`
- :arrow_up: [core-splashscreen](https://developer.android.com/jetpack/androidx/releases/core#core-splashscreen-1.0.0) `1.0.0-rc01` → `1.0.0`
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.5.1) `1.5.0` → `1.5.1`
- :arrow_up: [lifecycle](https://developer.android.com/jetpack/androidx/releases/lifecycle#2.5.1) `2.5.0` → `2.5.1`
- :arrow_up: [navigation](https://developer.android.com/jetpack/androidx/releases/navigation#2.5.1) `2.5.0` → `2.5.1`
- :arrow_up: [room](https://developer.android.com/jetpack/androidx/releases/room#2.4.3) `2.4.2` → `2.4.3`

### Stack

- :arrow_up: [accompanist](https://github.com/google/accompanist/releases/tag/v0.25.0) `0.24.13-rc` → `0.25.0`
- :arrow_up: [dagger](https://github.com/google/dagger/releases) `2.42` → `2.43.1` *(:warning: potentially breaking changes in hilt)*
- :arrow_up: [dokka](https://github.com/Kotlin/dokka/releases/tag/v1.7.10) `1.7.0` → `1.7.10`
- :arrow_up: [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v21-1-0) `21.0.0` → `21.1.0`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v30-3-1) `30.1.0` → `30.3.1`
- :arrow_up: [firebase-crashlytics-gradle](https://firebase.google.com/support/release-notes/android#crashlytics_gradle_plugin_v2-9-1) `2.9.0` → `2.9.1`
- :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-2-12) `18.2.11` → `19.2.12`
- :arrow_up: [firebase-messaging](https://firebase.google.com/support/release-notes/android#messaging_v23-0-6) `23.0.5` → `23.0.6`
- :arrow_up: [gms-googleServices](https://firebase.google.com/support/release-notes/android#google-services_plugin_v4-3-13) `4.3.12` → `4.3.13`
- :arrow_up: [junit](https://junit.org/junit5/docs/5.9.0/release-notes/) `5.8.2` → `5.9.0`
- :arrow_up: [kotest](https://kotest.io/docs/changelog.html#540-july-2022) `5.3.2` → `5.4.1`
- :arrow_up: [kotlin](https://github.com/JetBrains/kotlin/releases/tag/v1.7.10) `1.7.0` → `1.7.10`
- :arrow_up: [kotlinx-coroutines](https://github.com/Kotlin/kotlinx.coroutines/releases/tag/1.6.4) `1.6.3` → `1.6.4`
- :sparkle: [kotlinx-datetime](https://github.com/Kotlin/kotlinx-datetime) `0.4.0`
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.7.10-1.0.6) `1.7.0-1.0.6` → `1.7.10-1.0.6`
- :arrow_up: [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.1.15) `1.1.14` → `1.1.15`
- :arrow_up: [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.0.15) `1.0.14` → `1.0.15`
- :arrow_up: [mockk](https://github.com/mockk/mockk/releases/tag/1.12.5) `1.12.4` → `1.12.5`
- :arrow_up: [detekt](https://github.com/detekt/detekt/releases/tag/v1.21.0) `1.21.0-RC2` → `1.21.0`
- :arrow_up: [gradle-android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases/tag/v2.5.6) `2.5.5` → `2.5.6`
- :arrow_up: [kotlinx-binaryCompatibilityValidator](https://github.com/Kotlin/binary-compatibility-validator/releases/tag/0.11.0) `0.10.1` → `0.11.0`

## [2022.07.03]

### red_mad_robot

- :arrow_up: [pinkman](https://github.com/RedMadRobot/PINkman/releases/tag/1.3.0) `1.2.0` → `1.3.0`

### AndroidX

- :arrow_up: [activity](https://developer.android.com/jetpack/androidx/releases/activity#1.5.0) `1.4.0` → `1.5.0`
- :arrow_up: [camera](https://developer.android.com/jetpack/androidx/releases/camera#1.1.0) `1.1.0-rc02` → `1.1.0`
- :arrow_up: [compose](https://android.googlesource.com/platform/frameworks/support/+log/8328bd32e5ca96bc5a53d6369130e856cd2ca80b..e8af23f4f30713a3f6073d57558e7cde0f3056e9/compose) `1.2.0-rc02` → `1.2.0-rc03`
  - :sparkle: **version:** [compose-compiler](https://developer.android.com/jetpack/androidx/releases/compose-compiler#1.2.0) `1.2.0`
  - :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.0-alpha14) `1.0.0-alpha13` → `1.0.0-alpha14`
- :arrow_up: [fragment](https://developer.android.com/jetpack/androidx/releases/fragment#1.5.0) `1.4.1` → `1.5.0`
- :arrow_up: [lifecycle](https://developer.android.com/jetpack/androidx/releases/lifecycle#2.5.0) `2.4.1` → `2.5.0`
- :arrow_up: [navigation](https://developer.android.com/jetpack/androidx/releases/navigation#2.5.0) `2.4.2` → `2.5.0`

### Stack

- :arrow_up: [accompanist](https://github.com/google/accompanist/releases) `0.24.12-rc` → `0.24.13-rc`
- :arrow_up: [detekt](https://github.com/detekt/detekt/releases/tag/v1.21.0-RC2) `1.21.0-RC1` → `1.21.0-RC2`
- :arrow_up: [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.1.14) `1.1.12` → `1.1.14`
- :arrow_up: [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.0.14) `1.0.12` → `1.0.14`

## [2022.06.27] :warning:

### red_mad_robot

- :sparkle: [inputmask](https://github.com/RedMadRobot/input-mask-android) `6.1.0`

### AndroidX

- :arrow_up: [compose](https://android.googlesource.com/platform/frameworks/support/+log/2d8badfd263991345376562fc0f247bc76ca6312..8328bd32e5ca96bc5a53d6369130e856cd2ca80b/compose) `1.2.0-rc01` → `1.2.0-rc02`
- :x: **version:** `compose-compiler` *(use `compose` version instead or specify the desired version manually)*

### Stack

- :arrow_up: [accompanist](https://github.com/google/accompanist/releases) `0.24.11-rc` → `0.24.12-rc`
- :arrow_up: [dokka](https://github.com/Kotlin/dokka/releases/tag/v1.7.0) `1.6.21` → `1.7.0`
- :arrow_up: [kotest](https://kotest.io/docs/changelog.html#532-june-2022) `5.3.0` → `5.3.2`
  - :memo: `kotest-assertions` -> `kotest-assertions-core`
  - :sparkle: [kotest-assertions-api](https://github.com/kotest/kotest/tree/master/kotest-assertions/kotest-assertions-api)
  - :sparkle: [kotest-assertions-json](https://kotest.io/docs/assertions/json/json-overview.html)
  - :sparkle: `kotest-bom`
  - :sparkle: `kotest-framework-api`
  - :sparkle: [kotest-framework-concurrency](https://kotest.io/docs/framework/concurrency/eventually.html)
  - :sparkle: [kotest-framework-discovery](https://kotest.io/docs/framework/discovery-extensions.html)
  - :sparkle: [kotest-property](https://kotest.io/docs/proptest/property-based-testing.html)
  - :sparkle: `kotest-runner-junit4`
- :arrow_up: [kotlinx-coroutines](https://github.com/Kotlin/kotlinx.coroutines/releases/tag/1.6.3) `1.6.2` → `1.6.3`
- :arrow_up: [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.1.12) `1.1.11` → `1.1.12`
- :arrow_up: [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.0.12) `1.0.11` → `1.0.12`

## [2022.06.20]

> Finally implemented catalogs validation and it works!
> This is hotfix update.

### AndroidX

- :memo: `paging-common` and `paging-guava` now use `paging` version instead of `paging-compose` (`1.0.0-alpha15` → `3.1.1`)

### Stack

- :memo: `gms-googleServices` module coordinate fixed
- :memo: `junit-platform-*` `5.8.2` → `1.8.2` *(fix)*
- :memo: `kotlin-test-testing` → `kotlin-test-testng`

## [2022.06.19] :warning:

> #### :information_source: Note
>
> This update changes Kotlin version to `1.7.0` which is not compatible with Compose `1.2.0-rc01`.
> If you use Compose in your project, you should [overwrite version](https://docs.gradle.org/current/userguide/platforms.html#sec:overwriting-catalog-versions) of Kotlin in `settings.gradle` file.

This update makes plugins accessible both as a library and via `plugins` accessor.
For example, you can apply a plugin using plugins block:

```kotlin
plugins {
    alias(stack.plugins.detekt)
}
```

Also, you can add it as a dependency:

```kotlin
dependencies {
    implementation(stack.detekt.gradlePlugin)
}
```

### red_mad_robot

- :sparkle: [flipper-firebaseConfig](https://github.com/RedMadRobot/flipper/tree/master/flipper-firebase-config) `2.0.1`
- :arrow_up: [infrastructure](https://github.com/RedMadRobot/gradle-infrastructure/releases) `0.15` → `0.16.2`
  - :sparkle: infrastructure-android
  - :sparkle: infrastructure-detekt
  - :sparkle: infrastructure-kotlin
  - :sparkle: infrastructure-publish
- :sparkle: [mapmemory-kaptBugWorkaround](https://github.com/RedMadRobot/mapmemory#kapt-illegalstateexception-couldnt-find-declaration-file-on-delegate-with-inline-getvalue-operator) `2.0`
- :sparkle: [pinkman-ui](https://github.com/RedMadRobot/PINkman#quick-start) `1.2.0`

### AndroidX

- :arrow_up: [appcompat](https://developer.android.com/jetpack/androidx/releases/appcompat#1.4.2) `1.4.1` → `1.4.2`
  - :sparkle: [appcompat-resources](https://androidx.tech/artifacts/appcompat/appcompat-resources/1.4.2)
- :arrow_up: [camera](https://developer.android.com/jetpack/androidx/releases/camera#1.1.0-rc02) `1.1.0-beta03` → `1.1.0-rc02`
- :arrow_up: [compose](https://developer.android.com/jetpack/androidx/releases/compose) `1.1.1` → `1.2.0-rc01` *(:warning: be careful on update)*
  - :sparkle: [compose-animation-core](https://developer.android.com/reference/kotlin/androidx/compose/animation/core/package-summary)
  - :sparkle: [compose-animation-graphics](https://androidx.tech/artifacts/compose.animation/animation-graphics/)
  - :sparkle: [compose-foundation-layout](https://androidx.tech/artifacts/compose.foundation/foundation-layout/)
  - :sparkle: [compose-material-icons-core](https://developer.android.com/reference/kotlin/androidx/compose/material/package-summary)
  - :sparkle: [compose-material-icons-extended](https://maven.google.com/web/index.html#androidx.compose.material:material-icons-extended:1.2.0-rc01)
  - :sparkle: [compose-material-ripple](https://androidx.tech/artifacts/compose.material/material-ripple/)
  - :arrow_up: [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.0-alpha13) `1.0.0-alpha09` → `1.0.0-alpha13`
  - :sparkle: [compose-material3-windowSizeClass](https://androidx.tech/artifacts/compose.material3/material3-window-size-class/) `1.0.0-alpha13`
  - :sparkle: [compose-runtime-livedata](https://developer.android.com/jetpack/androidx/releases/compose-runtime)
  - :sparkle: [compose-runtime-rxjava2](https://developer.android.com/reference/kotlin/androidx/compose/runtime/rxjava2/package-summary)
  - :sparkle: [compose-runtime-rxjava3](https://developer.android.com/reference/kotlin/androidx/compose/runtime/rxjava3/package-summary)
  - :sparkle: [compose-runtime-saveable](https://developer.android.com/reference/kotlin/androidx/compose/runtime/saveable/package-summary)
  - :sparkle: [compose-ui-geometry](https://developer.android.com/reference/kotlin/androidx/compose/ui/geometry/package-summary)
  - :sparkle: [compose-ui-graphics](https://developer.android.com/reference/kotlin/androidx/compose/ui/graphics/package-summary)
  - :sparkle: [compose-ui-test](https://developer.android.com/reference/kotlin/androidx/compose/ui/test/package-summary)
  - :sparkle: [compose-ui-test-junit4](https://developer.android.com/reference/kotlin/androidx/compose/ui/test/junit4/package-summary)
  - :sparkle: [compose-ui-test-manifest](https://androidx.tech/artifacts/compose.ui/ui-test-manifest/)
  - :sparkle: [compose-ui-text](https://developer.android.com/reference/kotlin/androidx/compose/ui/text/package-summary)
  - :sparkle: [compose-ui-text-googleFonts](https://developer.android.com/jetpack/compose/text#downloadable-fonts)
  - :sparkle: [compose-ui-tooling-data](https://developer.android.com/reference/kotlin/androidx/compose/ui/tooling/data/package-summary)
  - :sparkle: [compose-ui-tooling-preview](https://developer.android.com/reference/kotlin/androidx/compose/ui/tooling/preview/package-summary)
  - :sparkle: [compose-ui-unit](https://developer.android.com/reference/kotlin/androidx/compose/ui/unit/package-summary)
  - :sparkle: [compose-ui-util](https://developer.android.com/reference/kotlin/androidx/compose/ui/util/package-summary)
  - :sparkle: [compose-ui-viewbinding](https://developer.android.com/jetpack/compose/interop/interop-apis#views-in-compose)
- :arrow_up: [constraintlayout](https://github.com/androidx/constraintlayout/wiki/What's-New-in-2.1#new-in-214) `2.1.3` → `2.1.4`
  - :arrow_up: [constraintlayout-compose](https://github.com/androidx/constraintlayout/wiki/What's-New-in-1.0-(Compose)#new-in-compose-101) `1.0.0` → `1.0.1`
  - :sparkle: [constraintlayout-core](https://androidx.tech/artifacts/constraintlayout/constraintlayout-core/1.0.4) `1.0.4`
- :arrow_up: [core](https://developer.android.com/jetpack/androidx/releases/core#1.8.0) `1.7.0` → `1.8.0`
- :arrow_up: [core-splashscreen](https://developer.android.com/jetpack/androidx/releases/core#core-splashscreen-1.0.0-rc01) `1.0.0-beta02` → `1.0.0-rc01`
- :sparkle: [core-googleShortcuts](https://developer.android.com/jetpack/androidx/releases/core#core-google-shortcuts-1.0.1) `1.0.1`
- **datastore-preferences:**
  - :sparkle: [datastore-preferences](https://developer.android.com/reference/kotlin/androidx/datastore/preferences/package-summary)
  - :sparkle: [datastore-preferences-core](https://developer.android.com/reference/kotlin/androidx/datastore/preferences/core/package-summary)
  - :sparkle: [datastore-preferences-rxjava2](https://developer.android.com/reference/kotlin/androidx/datastore/preferences/rxjava2/package-summary)
  - :sparkle: [datastore-preferences-rxjava3](https://developer.android.com/reference/kotlin/androidx/datastore/preferences/rxjava3/package-summary)
- **hilt:**
  - :sparkle: [hilt-common](https://androidx.tech/artifacts/hilt/hilt-common/)
  - :sparkle: [hilt-navigation](https://androidx.tech/artifacts/hilt/hilt-navigation/)
- **lifecycle:**
  - :sparkle: [lifecycle-common](https://androidx.tech/artifacts/lifecycle/lifecycle-common/)
  - :sparkle: [lifecycle-common-java8](https://androidx.tech/artifacts/lifecycle/lifecycle-common-java8/)
  - :sparkle: [lifecycle-compiler](https://androidx.tech/artifacts/lifecycle/lifecycle-compiler/)
  - :sparkle: [lifecycle-livedata](https://androidx.tech/artifacts/lifecycle/lifecycle-livedata-ktx/)
  - :sparkle: [lifecycle-livedata-core](https://androidx.tech/artifacts/lifecycle/lifecycle-livedata-core-ktx/)
  - :sparkle: [lifecycle-process](https://androidx.tech/artifacts/lifecycle/lifecycle-process/)
  - :sparkle: [lifecycle-reactivestreams](https://androidx.tech/artifacts/lifecycle/lifecycle-reactivestreams-ktx/)
  - :sparkle: [lifecycle-runtime-testing](https://androidx.tech/artifacts/lifecycle/lifecycle-runtime-testing/)
  - :sparkle: [lifecycle-service](https://androidx.tech/artifacts/lifecycle/lifecycle-service/)
  - :sparkle: [lifecycle-viewmodel-savedstate](https://developer.android.com/topic/libraries/architecture/viewmodel-savedstate)
- **navigation:**
  - :sparkle: [navigation-common](https://androidx.tech/artifacts/navigation/navigation-common/)
  - :sparkle: [navigation-dynamicFeatures-fragment](https://developer.android.com/guide/navigation/navigation-dynamic)
  - :sparkle: [navigation-dynamicFeatures-runtime](https://androidx.tech/artifacts/navigation/navigation-dynamic-features-runtime/)
  - :sparkle: [navigation-safeArgs-generator](https://androidx.tech/artifacts/navigation/navigation-safe-args-generator/)
  - :sparkle: [navigation-safeArgs-gradlePlugin](https://developer.android.com/jetpack/androidx/releases/navigation#safe_args)
  - :sparkle: [navigation-testing](https://developer.android.com/reference/androidx/navigation/testing/package-summary)
  - :sparkle: **plugin:** `navigation-safeargs-kotlin`
- **paging:**
  - :sparkle: [paging-common](https://androidx.tech/artifacts/paging/paging-common/)
  - :arrow_up: [paging-compose](https://developer.android.com/jetpack/androidx/releases/paging#1.0.0-alpha15) `1.0.0-alpha14` → `1.0.0-alpha15`
  - :sparkle: [paging-guava](https://androidx.tech/artifacts/paging/paging-guava/)
- :sparkle: [recyclerview-selection](https://developer.android.com/reference/androidx/recyclerview/selection/package-summary) `1.1.0`
- **room:**
  - :sparkle: [room-common](https://androidx.tech/artifacts/room/room-common/)
  - :sparkle: [room-compiler-processing](https://androidx.tech/artifacts/room/room-compiler-processing/)
  - :sparkle: [room-compiler-processing-testing](https://androidx.tech/artifacts/room/room-compiler-processing-testing/)
  - :sparkle: [room-guava](https://androidx.tech/artifacts/room/room-guava/)

### Stack

- :arrow_up: [accompanist](https://github.com/google/accompanist/releases) `0.23.1` → `0.24.11-rc` *(:warning: requires `compose:1.2.0-rc01`)*
  - :sparkle: [accompanist-webview](https://google.github.io/accompanist/webview/)
  - :warning: [accompanist-insets](https://google.github.io/accompanist/insets/) is deprecated
- :arrow_up: [coil](https://github.com/coil-kt/coil/blob/main/CHANGELOG.md#210---may-17-2022) `2.0.0-rc02` → `2.1.0`
  - :sparkle: [coil-base](https://coil-kt.github.io/coil/api/coil-base/index.html)
  - :sparkle: [coil-bom](https://coil-kt.github.io/coil/getting_started/#artifacts)
  - :sparkle: [coil-compose-base](https://coil-kt.github.io/coil/api/coil-compose-base/index.html)
  - :sparkle: [coil-gif](https://coil-kt.github.io/coil/gifs/)
  - :sparkle: [coil-svg](https://coil-kt.github.io/coil/svgs/)
  - :sparkle: [coil-video](https://coil-kt.github.io/coil/videos/)
- :arrow_up: [dagger](https://github.com/google/dagger/releases/tag/dagger-2.42) `2.41` → `2.42` *(:warning: potentially breaking changes)*
- :arrow_up: [detekt](https://github.com/detekt/detekt/releases/tag/v1.21.0-RC1) `1.19.0` → `1.21.0-RC1`
- :sparkle: **dokka** `1.6.21`
  - [dokka-base](https://kotlin.github.io/dokka/1.6.21/developer_guide/extension_points/#default-extensions-extension-points)
  - [dokka-cli](https://kotlin.github.io/dokka/1.6.21/user_guide/cli/usage/)
  - [dokka-core](https://kotlin.github.io/dokka/1.6.21/developer_guide/introduction/)
  - [dokka-gradlePlugin](https://kotlin.github.io/dokka/1.6.21/user_guide/gradle/usage/#applying-plugins)
  - [dokka-plugin-allModulesPage](https://github.com/Kotlin/dokka/tree/master/plugins/all-modules-page)
  - [dokka-plugin-androidDocumentation](https://kotlin.github.io/dokka/1.6.21/user_guide/android-plugin/android-plugin/)
  - [dokka-plugin-gfm](https://kotlin.github.io/dokka/1.6.21/user_guide/introduction/#plugins)
  - [dokka-plugin-javadoc](https://kotlin.github.io/dokka/1.6.21/user_guide/introduction/#plugins)
  - [dokka-plugin-jekyll](https://kotlin.github.io/dokka/1.6.21/user_guide/introduction/#plugins)
  - [dokka-plugin-kotlinAsJava](https://kotlin.github.io/dokka/1.6.21/user_guide/introduction/#plugins)
  - [dokka-plugin-mathjax](https://github.com/Kotlin/dokka/tree/master/plugins/mathjax)
  - [dokka-plugin-templating](https://github.com/Kotlin/dokka/tree/master/plugins/templating)
  - [dokka-plugin-versioning](https://kotlin.github.io/dokka/1.6.21/user_guide/versioning/versioning/)
- :sparkle: [epoxy-annotations](https://github.com/airbnb/epoxy/tree/master/epoxy-annotations) `4.6.4`
- :arrow_up: [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v21-0-0) `20.1.2` → `21.0.0`
- :arrow_up: [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v30-1-0) `29.3.0` → `30.1.0`
- :arrow_up: [firebase-crashlytics-gradle](https://firebase.google.com/support/release-notes/android#crashlytics_gradle_plugin_v2-9-0) `2.8.1` → `2.9.0`
- :arrow_up: [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-2-11) `18.2.9` → `19.2.11`
- :arrow_up: [firebase-messaging](https://firebase.google.com/support/release-notes/android#messaging_v23-0-5) `23.0.2` → `23.0.5`
- :arrow_up: [groupie](https://github.com/lisawray/groupie/releases/tag/2.10.1) `2.10.0` → `2.10.1`
- :arrow_up: [kotest](https://kotest.io/docs/changelog.html#530-may-2022) `5.2.3` → `5.3.0`
- :arrow_up: [kotlin](https://kotlinlang.org/docs/whatsnew17.html) `1.6.20` → `1.7.0` *(:warning: be careful on update)*
  - :sparkle: **plugin:** [kotlin-android](https://kotlinlang.org/docs/gradle.html#targeting-android)
  - :sparkle: [kotlin-gradlePlugin](https://kotlinlang.org/docs/gradle.html)
  - :sparkle: [kotlin-gradlePlugin-api](https://kotlinlang.org/docs/gradle.html)
  - :sparkle: [kotlin-reflect](https://kotlinlang.org/docs/reflection.html)
  - :sparkle: **plugin:** [kotlin-multiplatform](https://kotlinlang.org/docs/multiplatform-dsl-reference.html)
  - :sparkle: **plugin:** [kotlin-scripting](https://kotlinlang.org/docs/custom-script-deps-tutorial.html)
  - :sparkle: [kotlin-scripting-common](https://kotlinlang.org/docs/custom-script-deps-tutorial.html)
  - :sparkle: [kotlin-scripting-dependencies-maven](https://kotlinlang.org/docs/custom-script-deps-tutorial.html)
  - :sparkle: [kotlin-scripting-dependencies](https://kotlinlang.org/docs/custom-script-deps-tutorial.html)
  - :sparkle: [kotlin-scripting-jvm](https://kotlinlang.org/docs/custom-script-deps-tutorial.html)
  - :sparkle: [kotlin-serialization](https://kotlinlang.org/docs/serialization.html)
  - :sparkle: [kotlin-stdlib](https://kotlinlang.org/api/latest/jvm/stdlib/)
  - :sparkle: [kotlin-stdlib-common](https://kotlinlang.org/api/latest/jvm/stdlib/)
  - :sparkle: [kotlin-stdlib-jdk7](https://kotlinlang.org/api/latest/jvm/stdlib/)
  - :sparkle: [kotlin-stdlib-jdk8](https://kotlinlang.org/api/latest/jvm/stdlib/)
  - :sparkle: [kotlin-test](https://kotlinlang.org/api/latest/kotlin.test/)
  - :sparkle: [kotlin-test-annotations-common](https://kotlinlang.org/api/latest/kotlin.test/)
  - :sparkle: [kotlin-test-common](https://kotlinlang.org/api/latest/kotlin.test/)
  - :sparkle: [kotlin-test-junit5](https://kotlinlang.org/api/latest/kotlin.test/)
  - :sparkle: [kotlin-test-testing](https://kotlinlang.org/api/latest/kotlin.test/)
- :sparkle: [kotlinx-binaryCompatibilityValidator](https://github.com/Kotlin/binary-compatibility-validator) `0.10.1`
- :arrow_up: [kotlinx-coroutines](https://github.com/Kotlin/kotlinx.coroutines/releases/tag/1.6.2) `1.6.1` → `1.6.2`
  - :sparkle: [kotlinx-coroutines-debug](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-debug/)
  - :sparkle: [kotlinx-coroutines-guava](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-guava/)
  - :sparkle: [kotlinx-coroutines-javafx](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-javafx/)
  - :sparkle: [kotlinx-coroutines-jdk8](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-jdk8/)
  - :sparkle: [kotlinx-coroutines-jdk9](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-jdk9/)
  - :sparkle: [kotlinx-coroutines-playServices](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-play-services/)
  - :sparkle: [kotlinx-coroutines-reactive](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-reactive/)
  - :sparkle: [kotlinx-coroutines-reactor](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-reactor/)
  - :sparkle: [kotlinx-coroutines-rx2](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-rx2/)
  - :sparkle: [kotlinx-coroutines-rx3](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-rx3/)
  - :sparkle: [kotlinx-coroutines-slf4j](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-slf4j/)
  - :sparkle: [kotlinx-coroutines-swing](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-swing/)
- :arrow_up: [kotlinx-serialization](https://github.com/Kotlin/kotlinx.serialization/releases/tag/v1.3.3) `1.3.2` → `1.3.3`
  - :sparkle: [kotlinx-serialization-cbor](https://kotlin.github.io/kotlinx.serialization/kotlinx-serialization-cbor/index.html)
  - :sparkle: [kotlinx-serialization-core](https://kotlin.github.io/kotlinx.serialization/kotlinx-serialization-core/index.html)
  - :sparkle: [kotlinx-serialization-hocon](https://kotlin.github.io/kotlinx.serialization/kotlinx-serialization-hocon/index.html)
  - :sparkle: [kotlinx-serialization-properties](https://kotlin.github.io/kotlinx.serialization/kotlinx-serialization-properties/index.html)
- :arrow_up: [ksp](https://github.com/google/ksp/releases/tag/1.7.0-1.0.6) `1.6.20-1.0.5` → `1.7.0-1.0.6`
  - :warning: `ksp` → `ksp-api`
  - :warning: `ksp` now points to `symbol-processing` instead of `symbol-processing-api`
  - :sparkle: [ksp-gradlePlugin](https://kotlinlang.org/docs/ksp-quickstart.html)
- :arrow_up: [leakcanary](https://square.github.io/leakcanary/changelog/#version-291-2022-04-20) `2.8.1` → `2.9.1` *(:warning: breaking changes)*
- :arrow_up: [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.0.11) `1.0.6` → `1.0.11`
- :arrow_up: [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.1.11) `1.1.6` → `1.1.11`
- :arrow_up: [material](https://github.com/material-components/material-components-android/releases/tag/1.6.1) `1.5.0` → `1.6.1`
- :arrow_up: [mockk](https://github.com/mockk/mockk/releases/tag/1.12.4) `1.12.3` → `1.12.4`
  - :sparkle: [mockk-agent-android](https://github.com/mockk/mockk/tree/master/agent/android)
  - :sparkle: [mockk-agent-api](https://github.com/mockk/mockk/tree/master/agent/api)
  - :sparkle: [mockk-agent-common](https://github.com/mockk/mockk/tree/master/agent/common)
  - :sparkle: [mockk-agent-jvm](https://mockk.io/#installation)
  - :sparkle: [mockk-android](https://mockk.io/#installation)
  - :sparkle: [mockk-common](https://mockk.io/#installation)
- :arrow_up: [okhttp](https://square.github.io/okhttp/changelogs/changelog_4x/#version-4100) `4.9.3` → `4.10.0`
  - :sparkle: [okhttp-brotli](https://square.github.io/okhttp/4.x/okhttp-brotli/okhttp3.brotli/)
  - :sparkle: [okhttp-dnsoverhttps](https://square.github.io/okhttp/4.x/okhttp-dnsoverhttps/okhttp3.dnsoverhttps/)
  - :sparkle: [okhttp-sse](https://square.github.io/okhttp/4.x/okhttp-sse/okhttp3.sse/)
  - :sparkle: [okhttp-tls](https://square.github.io/okhttp/4.x/okhttp-tls/okhttp3.tls/)
  - :sparkle: [okhttp-urlconnection](https://square.github.io/okhttp/4.x/okhttp-urlconnection/okhttp3/)
  - :sparkle: [okhttp-mockwebserver](https://github.com/square/okhttp/tree/master/mockwebserver)
  - :x: okhttp-mockwebserver3-* *(it will be available only since okhttp 5.0.0)*
- :arrow_up: [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases/tag/v7.1.1) `7.0.4` → `7.1.1`
- :arrow_up: [reactivex-rxjava3](https://github.com/ReactiveX/RxJava/releases/tag/v3.1.5) `3.1.3` → `3.1.5`
- **retrofit:**
  - :sparkle: [retrofit-converter-gson](https://github.com/square/retrofit/tree/master/retrofit-converters/gson)
  - :sparkle: [retrofit-converter-guava](https://github.com/square/retrofit/tree/master/retrofit-converters/guava)
  - :sparkle: [retrofit-converter-jackson](https://github.com/square/retrofit/tree/master/retrofit-converters/jackson)
  - :sparkle: [retrofit-converter-jaxb](https://github.com/square/retrofit/tree/master/retrofit-converters/jaxb)
  - :sparkle: [retrofit-converter-protobuf](https://github.com/square/retrofit/tree/master/retrofit-converters/protobuf)
  - :sparkle: [retrofit-converter-scalars](https://github.com/square/retrofit/tree/master/retrofit-converters/scalars)
  - :sparkle: [retrofit-converter-wire](https://github.com/square/retrofit/tree/master/retrofit-converters/wire)
  - :sparkle: [retrofit-adapter-guava](https://github.com/square/retrofit/tree/master/retrofit-adapters/guava)
  - :sparkle: [retrofit-adapter-rxjava2](https://github.com/square/retrofit/tree/master/retrofit-adapters/rxjava2)
  - :sparkle: [retrofit-adapter-rxjava3](https://github.com/square/retrofit/tree/master/retrofit-adapters/rxjava3)
- :arrow_up: :memo: android-cacheFix `2.5.0` → [gradle-android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases/tag/v2.5.5) `2.5.5`
  - :memo: **version:** `android-cacheFix` → `gradle-android-cacheFix`
- :arrow_up: :memo: gradleDoctor `0.8.0` → [doctor](https://github.com/detekt/detekt/releases/tag/v1.21.0-RC1) `0.8.1`
  - :memo: **version:** `gradleDoctor` → `doctorPlugin`
- :memo: `gms-google-services` → `gms-googleServices` *(both, version and dependency renamed)*

## [2022.04.10] :warning:

> #### :information_source: Note
>
> This update changes Kotlin version to `1.6.20` which is not compatible with Compose `1.1.1`.
> If you use Compose in your project, you should [overwrite version](https://docs.gradle.org/current/userguide/platforms.html#sec:overwriting-catalog-versions) of Kotlin in `settings.gradle` file.

### AndroidX

- [camera](https://developer.android.com/jetpack/androidx/releases/camera#1.1.0-beta03) `1.1.0-beta02` → `1.1.0-beta03`
- [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.0-alpha09) `1.0.0-alpha07` → `1.0.0-alpha09`
- [core](https://developer.android.com/jetpack/androidx/releases/core#core-splashscreen-1.0.0-beta02) `1.0.0-beta01` → `1.0.0-beta02`
- [navigation](https://developer.android.com/jetpack/androidx/releases/navigation#2.4.2) `2.4.1` → `2.4.2`

### Stack

- [kotlin](https://kotlinlang.org/docs/whatsnew1620.html) `1.6.10` → `1.6.20`
- [coil](https://github.com/coil-kt/coil/blob/main/CHANGELOG.md#200-rc02---march-20-2022) `2.0.0-rc01` → `2.0.0-rc02`
- [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.1.6) `1.1.5` → `1.1.6`
- [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.0.6) `1.0.5` → `1.0.6`
- [kotlinx-coroutines](https://github.com/Kotlin/kotlinx.coroutines/releases/tag/1.6.1) `1.6.0` → `1.6.1`
- [kotest](https://kotest.io/docs/changelog.html#521-march-2022) `5.1.0` → `5.2.3` *(:warning: breaking changes)*
- [ksp](https://github.com/google/ksp/releases/tag/1.6.20-1.0.5) `1.6.10-1.0.4` → `1.6.20-1.0.5`
- [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v20-1-2) `20.1.0` → `20.1.2`
- [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v29-3-0) `29.1.0` → `29.3.0`
- [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-2-9) `18.2.8` → `18.2.9`
- [firebase-messaging](https://firebase.google.com/support/release-notes/android#messaging_v23-0-2) `23.0.0` → `23.0.2`
- [gradleDoctor](https://runningcode.github.io/gradle-doctor/changelog/#080) `0.7.3` → `0.8.0`
- [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases/tag/v7.0.4) `7.0.0` → `7.0.4`

### red_mad_robot

- [pinkman](https://github.com/RedMadRobot/PINkman/releases/tag/1.2.0) `1.1.3` → `1.2.0`

## [2022.03.09] :warning:

### AndroidX

- [camera](https://developer.android.com/jetpack/androidx/releases/camera#1.1.0-beta02) `1.1.0-beta01` → `1.1.0-beta02`
- [compose](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.1.1) `1.1.0` → `1.1.1`
- [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.0-alpha07) `1.0.0-alpha05` → `1.0.0-alpha07`
- [paging](https://developer.android.com/jetpack/androidx/releases/paging#3.1.1) `3.1.0` → `3.1.1`
- [room](https://developer.android.com/jetpack/androidx/releases/room#2.4.2) `2.4.1` → `2.4.2`

### Stack

- [accompanist](https://github.com/google/accompanist/releases/tag/v0.23.1) `0.23.0` → `0.23.1`
- [coil](https://github.com/coil-kt/coil/blob/main/CHANGELOG.md#200-rc01---march-2-2022) `1.4.0` → `2.0.0-rc01` *(:warning: breaking changes)*
- [material-compose-themeAdapter](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material-v1.1.5) `1.1.4` → `1.1.5`
- [material-compose-themeAdapter3](https://github.com/material-components/material-components-android-compose-theme-adapter/releases/tag/material3-v1.0.5) `1.0.4` → `1.0.5`
- [ksp](https://github.com/google/ksp/releases/tag/1.6.10-1.0.4) `1.6.10-1.0.3` → `1.6.10-1.0.4`
- [mockk](https://github.com/mockk/mockk/releases/tag/1.12.3) `1.12.2` → `1.12.3`
- [android-cacheFix](https://github.com/gradle/android-cache-fix-gradle-plugin/releases/tag/v2.5.0) `2.4.6` → `2.5.0` *(:warning: AGP 7.0.0+)*
- [owasp-dependencycheck](https://github.com/jeremylong/DependencyCheck/releases/tag/v7.0.0) `6.5.3` → `7.0.0` *(:warning: breaking changes)*

## [2022.02.20]

### Stack

#### Updated

- [dagger](https://github.com/google/dagger/releases/tag/dagger-2.41) `2.40.5` → `2.41` *(:warning: contains potentially breaking changes)*
- [ksp](https://github.com/google/ksp/releases/tag/1.6.10-1.0.3) `1.6.10-1.0.2` → `1.6.10-1.0.3`
- [firebase-analytics](https://firebase.google.com/support/release-notes/android#analytics_v20-1-0) `20.0.2` → `20.1.0`
- [firebase-bom](https://firebase.google.com/support/release-notes/android#bom_v29-1-0) `29.0.4` → `29.1.0`
- [firebase-crashlytics](https://firebase.google.com/support/release-notes/android#crashlytics_v18-2-8) `18.2.7` → `18.2.8`

## [2022.02.11]

### AndroidX

#### Updated

- compose `1.1.0-rc03` → `1.1.0`
- compose-material3 `1.0.0-alpha04` → `1.0.0-alpha05`
- lifecycle `2.4.0` → `2.4.1`
- navigation `2.4.0` → `2.4.1`

### Stack

#### Added

- **plugin:** versions `0.42.0`

#### Updated

- accompanist `0.24.0-alpha` → `0.23.0` *(downgrade to align with compose version)*
- material-compose-themeAdapter `1.1.3` → `1.1.4`
- material-compose-themeAdapter3 `1.0.3` → `1.0.4`
- junit4 `4.13` → `4.13.2`

## [2022.01.28]

Version catalog `plugins` removed.
Plugins were moved to other catalogs.

### AndroidX

#### Added

- camera `1.1.0-beta01`:
  - camera2
  - core
  - extensions
  - lifecycle
  - video
  - view
- hilt `1.0.0`:
  - compiler
  - navigation-compose
  - navigation-fragment
  - work
- **plugin:** navigation-safeargs

#### Updated

- compose `1.1.0-rc01` → `1.1.0-rc03`
- compose-compiler `1.1.0-rc02` → `1.1.0-rc03`
- compose-material3 `1.0.0-alpha03` → `1.0.0-alpha04`
- fragment `1.4.0` → `1.4.1`
- navigation `2.4.0-rc01` → `2.4.0`

### Stack

#### Added

Plugins:

- kotlin-jvm
- kotlin-kapt
- kotlin-parcelize
- kotlin-serialization
- ksp
- firebase-crashlytics `2.8.1`
- gms-google-services `4.3.10`
- android-cacheFix `2.4.6`
- detekt `1.19.0`
- gradleDoctor `0.7.3`
- owasp-dependencycheck `6.5.3`

#### Updated

- firebase-bom `29.0.3` → `29.0.4`
- firebase-crashlytics `18.2.6` → `18.2.7`

### red_mad_robot

#### Added

gradle-infrastructure plugins `0.15`:

- android-application
- android-config
- android-library
- detekt
- kotlin-config
- kotlin-library
- publish
- publish-config

## [2022.01.21]

### AndroidX

#### Added

- room-paging

#### Changed

- `room-ktx` → `room`

#### Updated

- constraintlayout `2.1.2` → `2.1.3`
- constraintlayout-compose `1.0.0-rc02` → `1.0.0`

### Stack

#### Added

- accompanist `0.24.0-alpha`:
  - appcompatTheme
  - drawablepainter
  - flowlayout
  - insets
  - insets-ui
  - navigation-animation
  - navigation-material
  - pager
  - pager-indicators
  - permissions
  - placeholder
  - placeholder-material
  - swiperefresh
  - systemuicontroller
- material-compose-themeAdapter `1.1.3`
- material-compose-themeAdapter3 `1.0.3`
- junit4 `4.13`
- junit `5.8.2`:
  - bom
  - jupiter
  - jupiter-api
  - jupiter-engine
  - jupiter-migrationsupport
  - jupiter-params
  - platform-launcher
  - platform-runner
  - vintage-engine
- retorfit-mock
- okhttp-mockwebserver3

## [2022.01.20] (2022 Jan 20)

### AndroidX

#### Added

- activity and activity-compose `1.4.0`
- compose `1.1.0-rc01`:
  - compose-animation
  - compose-foundation
  - compose-material
  - compose-material3 `1.0.0-alpha03`
  - compose-runtime
  - compose-ui
  - compose-ui-tooling
- constraintlayout-compose
- coordinatorlayout `1.2.0`
- datastore `1.0.0`:
  - core
  - rxjava2
  - rxjava3
- fragment-testing
- lifecycle-runtime
- lifecycle-viewmodel-compose
- navigation-compose
- paging-compose `1.0.0-alpha14`
- security-crypto `1.0.0`

#### Updated

- appcompat `1.4.0` → `1.4.1`
- core-splashscreen `1.0.0-alpha01` → `1.0.0-beta01`
- navigation `2.3.5` → `2.4.0-rc01`
- room `2.3.0` → `2.4.1`

### Plugins

#### Added

- infrastructure-androidConfig
- infrastructure-kotlinConfig
- infrastructure-publishConfig

#### Removed

- infrastructure-root
- infrastructure-signing

#### Changed

- `kotlin-pluginParcelize` → `kotlin-parcelize`

#### Updated

- android-cacheFix `2.4.5` → `2.4.6`
- infrastructure `0.12.2` → `0.14`
- kotlin `1.6.0` → `1.6.10`
- ksp `1.6.0-1.0.1` → `1.6.10-1.0.2`
- owasp `6.5.0.1` → `6.5.2.1`

### Stack

#### Added

- coil-compose
- firebase:
  - analytics `20.0.2`
  - bom `29.0.3`
  - crashlytics `18.2.6`
  - messaging `23.0.0`
- kotlin-bom `1.6.10`
- kotlinx-serialization-protobuf
- retrofit-converter-kotlinxSerialization (`com.jakewharton.retrofit:retrofit2-kotlinx-serialization-converter:0.8.0`)
- tink, tink-android `1.6.1`:

#### Changed

- `airbnb-epoxy` → `epoxy`

#### Updated

- google-dagger `2.39.1` → `2.40.5`
- groupie `2.9.0` → `2.10.0`
- insetter `0.6.6` → `0.6.1` (fix)
- kotest `4.6.3` → `5.1.0`
- kotlinx-coroutines `1.5.2` → `1.6.0`
- kotlinx-serialization `1.3.0` → `1.3.2`
- ksp `1.5.31-1.0.0` → `1.6.10-1.0.2`
- leakcanary `2.7` → `2.8.1`
- mockk `1.12.0` → `1.12.2`
- moshi `1.12.0` → `1.13.0`
- okhttp `4.9.2` → `4.9.3`
- reactivex-rxjava3 `3.1.2` → `3.1.3`

### red_mad_robot

#### Updated

- ktx-core `1.6.0-1` → `1.6.0-2`
- ktx-fragment-args `1.3.6-0` → `1.3.6-1`

#### Changed

- `extension-*` -> `ktx-*`

### Housekeeping

- Update Gradle `7.3` → `7.3.3`
- Added CHANGELOG

## [2021.06.12] (2021 Dec 06)

Initial release

[unreleased]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.12.13..main
[2022.12.13]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.11.18..2022.12.13
[2022.11.18]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.11.12..2022.11.18
[2022.11.12]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.10.26..2022.11.12
[2022.10.26]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.10.06..2022.10.26
[2022.10.06]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.09.23..2022.10.06
[2022.09.23]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.09.13..2022.09.23
[2022.09.13]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.08.29..2022.09.13
[2022.08.29]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.08.11..2022.08.29
[2022.08.11]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.08.04..2022.08.11
[2022.08.04]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.07.30..2022.08.04
[2022.07.30]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.07.03..2022.07.30
[2022.07.03]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.06.27..2022.07.03
[2022.06.27]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.06.20..2022.06.27
[2022.06.20]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.06.19..2022.06.20
[2022.06.19]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.04.10..2022.06.19
[2022.04.10]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.03.09..2022.04.10
[2022.03.09]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.02.20..2022.03.09
[2022.02.20]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.02.11..2022.02.20
[2022.02.11]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.01.28..2022.02.11
[2022.01.28]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.01.21..2022.01.28
[2022.01.21]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.01.20..2022.01.21
[2022.01.20]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2021.06.12..2022.01.20
[2021.06.12]: https://github.com/RedMadRobot/gradle-version-catalogs/commits/2021.06.12
