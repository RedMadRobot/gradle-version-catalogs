# red_mad_robot Version Catalogs
[![Version](https://img.shields.io/maven-central/v/com.redmadrobot.versions/versions-redmadrobot?style=flat-square)][mavenCentral]

[Shared catalogs](https://docs.gradle.org/current/userguide/platforms.html#sec:sharing-catalogs) used in red_mad_robot android team.
Gradle 7.4 required.

---

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Catalogs](#catalogs)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
  - [Unable to apply the plugin because the extension is already registered](#unable-to-apply-the-plugin-because-the-extension-is-already-registered)
  - [Unable to apply a plugin from the version catalog due to a version conflict to the classpath](#unable-to-apply-a-plugin-from-the-version-catalog-due-to-a-version-conflict-to-the-classpath)
  - [DSL_SCOPE_VIOLATION can't be called in this context by implicit receiver](#dsl_scope_violation-cant-be-called-in-this-context-by-implicit-receiver)
  - [Invalid catalog definition](#invalid-catalog-definition)
  - [Invalid TOML catalog definition](#invalid-toml-catalog-definition)
- [Additional links](#additional-links)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Catalogs

- [androidx](versions-androidx/libs.versions.toml) - The catalog with [AndroidX libraries](https://developer.android.com/jetpack/androidx/versions).
- [redmadrobot](versions-redmadrobot/libs.versions.toml) - The catalog with the [red_mad_robot libraries](https://github.com/RedMadRobot).
- [stack](versions-stack/libs.versions.toml) - The catalog providing libraries from tech stack used in red_mad_robot android team.

## Usage

> You can read more about shared catalogs usage in the [documentation](https://docs.gradle.org/current/userguide/platforms.html#sec:importing-published-catalog).

You need to create version catalogs in `settings.gradle.kts` from remote repository:

```kotlin
dependencyResolutionManagement {
    repositories {
        mavenCentral()
    }

    versionCatalogs {
        create("rmr") {
            from("com.redmadrobot.versions:versions-redmadrobot:2022.07.30")
        }
        create("androidx") {
            from("com.redmadrobot.versions:versions-androidx:2022.07.30")
        }
        create("stack") {
            from("com.redmadrobot.versions:versions-stack:2022.07.30")
        }
    }
}
```

> :warning: Be careful with version catalogs naming.
> Make sure selected name does not conflict with any of Gradle plugin extensions, otherwise your project will not sync.
> For example, if you have [gradle-infrastructure](https://github.com/RedMadRobot/gradle-infrastructure) plugin, you cannot create version catalog named `redmadrobot`, because gradle-infrastructure contains an extension named `redmadrobot`.
> Also you should not name the published version catalog as `libs` if you want to use the local version catalog, or you must rename the local version catalog.

After sync the project gradle create accessors for dependencies like:

```kotlin
plugins {
    alias(rmr.plugins.application)
    alias(androidx.plugins.navigation.safeargs.kotlin)
}

dependencies {
    implementation(androidx.core)
    implementation(androidx.fragment)

    implementation(rmr.ktx.fragment)

    implementation(stack.dagger)
}
```

## Troubleshooting

You can find Troubleshooting in [gradle documentation page](https://docs.gradle.org/7.2/userguide/version_catalog_problems.html).

### Unable to apply the plugin because the extension is already registered

```
Caused by: java.lang.IllegalArgumentException: Cannot add extension with name, as there is an extension already registered with that name
```

Probably, you named a version catalog as one of the gradle plugin extensions.
Please, read the warning under [Importing a published catalog](#importing-a-published-catalog) section.

### Unable to apply a plugin from the version catalog due to a version conflict to the classpath

```
Caused by: org.gradle.plugin.management.internal.InvalidPluginRequestException: Plugin request for plugin already on the classpath must not include a version
```

This exception can occur if the plugin has already been applied in the root **build.gradle**, or has a notation in the **buildscripts** section, or has a notation in the **plugins** section of the **settings.gradle** file.
You can leave the plugin notation only in the modules you need, because `alias` applies the plugin version from the version catalog file.
If this is not possible, you can use the `id` extension instead of `alias` and get only **pluginId** from the accessor.

```kotlin
plugins {
  id(rmr.plugins.detekt.get().pluginId)
}
```

### DSL_SCOPE_VIOLATION can't be called in this context by implicit receiver

This is an Intellij IDEA [issue](https://youtrack.jetbrains.com/issue/KTIJ-19369) and it does not affect the build.
You can suppress it with `@Suppress("DSL_SCOPE_VIOLATION")`

### Invalid catalog definition

```
Problem: In version catalog libs, you can only import a single external catalog in a given catalog definition.
```

Probably, you named a published version catalog as `libs`.
Please, read the warning under [Importing a published catalog](#importing-a-published-catalog) section.

### Invalid TOML catalog definition

Check your Gradle wrapper version. The current catalog based on Gradle 7.2.

## Additional links

- You can find some useful information and some answers to questions about the version catalog at https://melix.github.io/blog/tags/catalog.html

[mavenCentral]: https://search.maven.org/search?q=com.redmadrobot.versions
