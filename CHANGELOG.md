## [Unreleased]

### AndroidX

- [camera](https://developer.android.com/jetpack/androidx/releases/camera#1.1.0-beta02) `1.1.0-beta01` → `1.1.0-beta02`
- [compose](https://developer.android.com/jetpack/androidx/releases/compose-ui#1.1.1) `1.1.0` → `1.1.1`
- [compose-material3](https://developer.android.com/jetpack/androidx/releases/compose-material3#1.0.0-alpha07) `1.0.0-alpha05` → `1.0.0-alpha07`
- [paging](https://developer.android.com/jetpack/androidx/releases/paging#3.1.1) `3.1.0` → `3.1.1`
- [room](https://developer.android.com/jetpack/androidx/releases/room#2.4.2) `2.4.1` → `2.4.2`

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

[unreleased]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.02.20..main
[2022.02.20]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.02.11..2022.02.20
[2022.02.11]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.01.28..2022.02.11
[2022.01.28]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.01.21..2022.01.28
[2022.01.21]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2022.01.20..2022.01.21
[2022.01.20]: https://github.com/RedMadRobot/gradle-version-catalogs/compare/2021.06.12..2022.01.20
[2021.06.12]: https://github.com/RedMadRobot/gradle-version-catalogs/commits/2021.06.12
