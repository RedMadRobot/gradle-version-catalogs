# red_mad_robot Version Catalog
Shared catalog of red_mad_robot based on [Gradle Shared Catalogs](https://docs.gradle.org/current/userguide/platforms.html#sec:sharing-catalogs) (Gradle version 7.2).

> :warning: Shared Catalog is experimental feature, make sure you activate feature preview by `enableFeaturePreview('VERSION_CATALOGS')` in the `setting.gradle.kts`. 
> You can read more about this in the [documentation](https://docs.gradle.org/current/userguide/platforms.html).

## Modules
The catalog contains modules: 
 - androidX
 - redmadrobot
 - core
 - ui tools

### AndroidX 
The catalog provides the Jetpack libraries. 
You can find them in the [androidx catalog](versions-androidx/libs.versions.toml).

### Redmadrobot
The catalog provides the [Redmadrobot libraries](https://github.com/RedMadRobot). 
You can find them in the [redmadrobot catalog](versions-redmadrobot/libs.versions.toml).

### Stack
The catalog provides a main r_m_r stack.
You can find them in the [ui tools catalog](versions-stack/libs.versions.toml).

## Importing a published catalog 
You can read more about install shared catalogs in the [gradle documentation](https://docs.gradle.org/current/userguide/platforms.html#sec:importing-published-catalog).

You need to create version catalogs in `settings.gradle.kts` from remote repository:

```kotlin
dependencyResolutionManagement {
    versionCatalogs {
        create("rmr") {
            from("com.redmadrobot.versions:versions-redmadrobot:2021.8.20")
        }
        create("androidx") {
            from("com.redmadrobot.versions:versions-androidx:2021.8.20")
        }
        create("core") {
            from("com.redmadrobot.versions:versions-core:2021.8.20")
        }
        create("ui") {
            from("com.redmadrobot.versions:versions-ui-tools:2021.8.20")
        }
    }
}
``` 
> :warning: Be aware with naming of version catalog name, be sure your name does not conflict with any gradle plugin extension, otherwise your project will not sync.
> For example, if you have [gradle-infrastructure](https://github.com/RedMadRobot/gradle-infrastructure) plugin, you cannot create version catalog named `redmadrobot`, because gradle-infrastructure contains an extension named `redmadrobot`.
> Also you should not name the published version catalog as `libs` if you want to use the local version catalog, or you must rename the local version catalog.

After sync the project gradle create accessors for dependencies like: 

```kotlin
dependencies {
    implementation(androidx.core.ktx)
    implementation(androidx.fragment)

    implementation(rmr.extension.fragment)

    implementation(core.dagger)
}
```

## Troubleshooting
You can find Troubleshooting in [gradle documentation page](https://docs.gradle.org/7.2/userguide/version_catalog_problems.html).

### Cannot apply plugin 

```text
Caused by: java.lang.IllegalArgumentException: Cannot add extension with name, as there is an extension already registered with that name
```

Probably, you named a version catalog as one of the gradle plugin extensions.

### Invalid catalog definition

```text
 Problem: In version catalog libs, you can only import a single external catalog in a given catalog definition.
```

Probably, you named a published version catalog as `libs`.

### Invalid TOML catalog definition

Check your Gradle wrapper version. The current catalog based on Gradle 7.2. 
