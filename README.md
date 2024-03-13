# red_mad_robot Version Catalogs
[![Version](https://img.shields.io/maven-central/v/com.redmadrobot.versions/versions-redmadrobot?style=flat-square)][mavenCentral]

[Shared catalogs](https://docs.gradle.org/current/userguide/platforms.html#sec:sharing-catalogs) used in red_mad_robot android team.
Gradle 7.4+ is required.

---

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Catalogs](#catalogs)
  - [Motivation](#motivation)
- [Usage](#usage)
  - [Where can I find the version of a dependency?](#where-can-i-find-the-version-of-a-dependency)
  - [How can I change a dependency version?](#how-can-i-change-a-dependency-version)
  - [How can I add a dependency to the catalog?](#how-can-i-add-a-dependency-to-the-catalog)
  - [How can I make a bundle of dependencies?](#how-can-i-make-a-bundle-of-dependencies)
- [Catalogs Principles](#catalogs-principles)
  - [Update Policy](#update-policy)
  - [Naming and Structure](#naming-and-structure)
- [Troubleshooting](#troubleshooting)
  - [Unable to apply the plugin because the extension is already registered](#unable-to-apply-the-plugin-because-the-extension-is-already-registered)
  - [Unable to apply a plugin from the version catalog due to a version conflict to the classpath](#unable-to-apply-a-plugin-from-the-version-catalog-due-to-a-version-conflict-to-the-classpath)
  - [DSL_SCOPE_VIOLATION can't be called in this context by implicit receiver](#dsl_scope_violation-cant-be-called-in-this-context-by-implicit-receiver)
  - [Invalid TOML catalog definition](#invalid-toml-catalog-definition)
- [Additional resources](#additional-resources)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Catalogs

There are two groups of catalogs.
The first group is **catalogs containing libraries from the same group**.
They are not specific to red_mad_robot, so feel free to use them.

- [redmadrobot][versions-redmadrobot] - contains [red_mad_robot libraries](https://github.com/RedMadRobot)
- [androidx][versions-androidx] - contains [AndroidX libraries](https://developer.android.com/jetpack/androidx/versions)

The second group is **internal catalogs**.
Use them only if you are red_mad_robot team member.

- [stack][versions-stack] - contains libraries according to tech stack used in red_mad_robot android team

### Motivation

Why to prefer version catalogs over the declaring dependencies via `buildSrc`?

- If you have multiple projects
  - **and** you want to share the same set of dependencies (considered as your tech stack) between multiple projects.
    It also allows you to start new projects quickly.
  - **and** you want to reduce effort on dependencies updating, and update them in one place.
    So, you have to ensure all dependencies are compatible to each other only once.
- If you want to share dependencies between project and `buildSrc` or [composite builds][docs-composite-builds].
- If you don't want to trigger recompilation of all build scripts when the only thing you did was change a dependency version.
- If you want to [create bundles](#how-can-i-make-a-bundle-of-dependencies) for dependencies frequently used together.

> [!TIP]
>
> If you use the catalogs from this repository, you can look at the [changelog] containing links to release notes for each updated dependency.
> Updates requiring your attention are marked with :warning:.

Before switching to version catalogs, take into account the following drawbacks:

- Version catalogs are not quite popular yet, so you need to guide your team on how to use and modify catalogs.
  ["Usage"](#usage) section of this guide is a good starting point.
- If you use external version catalogs, it may be harder to update catalogs if you skip several updates.
  There is a cumulative effect.
  The more updated dependencies require the more effort on update to honor all breaking changes.
  Although this problem exists even if you don't use version catalogs, it is simpler to handle when you update dependencies one-by-one without catalog.
- If version catalogs are shared between multiple projects, they should be continuously maintained to keep them up-to-date and to not block consumers from updating dependencies (see ["Catalogs Principles"](#catalogs-principles)).

## Usage

> [!NOTE]
>
> Read more about version catalogs sharing in the [official documentation][docs-importing].

To add published catalogs to your project, declare it in `settings.gradle.kts`:

```kotlin
dependencyResolutionManagement {
    repositories {
        mavenCentral()
    }

    versionCatalogs {
        val version = "2024.03.04"
        create("rmr") {
            from("com.redmadrobot.versions:versions-redmadrobot:$version")
        }
        create("androidx") {
            from("com.redmadrobot.versions:versions-androidx:$version")
        }
        create("stack") {
            from("com.redmadrobot.versions:versions-stack:$version")
        }
    }
}
```

> [!WARNING]
>
> Be careful with version catalogs naming.\
> Make sure selected name doesn't conflict with any of Gradle plugins' extensions, otherwise your project will not sync.
> For example, if you have [gradle-infrastructure](https://github.com/RedMadRobot/gradle-infrastructure) plugin, you cannot create version catalog named `redmadrobot` because gradle-infrastructure contains an extension named `redmadrobot`.
> Moreover you should not name the published version catalog as `libs` if you want to be able to use the local version catalog, or you must rename the local version catalog.

Gradle generates accessors for dependencies according to the declared catalogs after the project sync:

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

> [!NOTE]
>
> Here are listed only most common catalogs use cases.
> If you want to know more about version catalogs usage, please read the [official documentation][docs].

### Where can I find the version of a dependency?

Versions of dependencies declared in version catalogs are known only on dependency resolution step.
So, the best way to know what version of dependency is used in your project is to use Gradle dependencies report:

```shell
# To show all dependencies in releaseRuntimeClasspath configuration
./gradlew -q :app:dependencies --configuration releaseRuntimeClasspath
# or to show information about specific dependency
./gradlew -q :app:dependencyInsight --configuration releaseRuntimeClasspath --dependency com.google.dagger:dagger
```

Another way is to look at catalogs sources and find the version there.
You can find link to the catalogs sources in section [Catalogs](#catalogs).
If you go this way, make sure you've selected repository revision corresponding to the version used in your project.

### How can I change a dependency version?

Each dependency [has a corresponding version alias](#versions).
You can change the value associated with the version alias and replace it with the needed value.
Here is an example of how you can change the Kotlin version.
Note that you should also change all versions based on the changed version.

```kotlin
// settings.gradle.kts
dependencyResolutionManagement {
  //...

  versionCatalogs {
    create("stack") {
      from("com.redmadrobot.versions:versions-stack:[...]")

      version("kotlin", "1.9.22")
      version("ksp", "1.9.22-1.0.17")
    }

    create("androidx") {
      from("com.redmadrobot.versions:versions-androidx:[...]")

      version("compose-compiler", "1.5.8")
    }
  }
}
```

### How can I add a dependency to the catalog?

If you want to share the added dependency with all projects using the catalogs, fell free to [file an issue][issue].
In the case you need the dependence only in your project, you can add it locally to the catalog.
It is encouraged to [follow catalog structure](#naming-and-structure).

```kotlin
// settings.gradle.kts
dependencyResolutionManagement {
  versionCatalogs {
    create("androidx") {
      from("com.redmadrobot.versions:versions-androidx:[...]")

      library("games-activity", "androidx.games:games-activity:2.0.2")
      library("games-controller", "androidx.games:games-controller:2.0.1")
    }
  }
}
```

### How can I make a bundle of dependencies?

Similarly to the [dependencies](#how-can-i-add-a-dependency-to-the-catalog), you can add bundles to the catalogs.
Catalogs doesn't contain any bundles by default, so feel free to add your own.

```kotlin
// settings.gradle.kts
dependencyResolutionManagement {
  versionCatalogs {
    create("androidx") {
      from("com.redmadrobot.versions:versions-androidx:[...]")

      bundle("compose", listOf("compose-animation", "compose-material3", "compose-foundation", "compose-ui"))
    }
  }
}
```

## Catalogs Principles

The catalogs published here must be:

- **Foolproof**: catalogs shouldn't contain invalid dependencies.
  Dependencies published in the same version of catalog must be compatible with each other.
  Dependencies should have predictable aliases
- **Up-to-date**: dependencies must be updated within one month since release.
  It must be possible to change dependencies' versions without modifying the catalog's source code
- **Transparent**: catalogs mustn't hide important changes in dependencies from developers.
  Everyone who wants to update catalogs in a project should see what dependencies were changed and what important changes these updates include

### Update Policy

To not block projects using these catalogs from updating to the latest versions, the catalogs should be updated regularly, every two weeks.
Usually, this period of time is enough to gather libraries compatible with each other.

Generally, catalogs should include only stable versions of libraries, with some exclusions:

- It is allowed to use RC version of a dependency if it contains a fix for a major issue or brings compatibility with other dependencies
- It is allowed to use RC, beta, alpha, etc. if the dependency has no stable version yet.

Release notes should contain all the information needed for an update to the new version of catalogs:

- List of added, changed, or removed dependencies
- Link to the changelog for each dependency
- Links to additional information about the update if it is helpful (e.g., what's new article, migration guide, etc.)
- Updates containing changes requiring the developer's attention should be marked with :warning: sign

> **Symbols Used in Catalogs Release Notes:** \
> :sparkle: - Added dependency \
> :arrow_up: - Updated dependency \
> :x: - Removed dependency \
> :memo: - Dependency or version name changed \
> :warning: - Attention required. Update may contain breaking changes or behaviour changes.

### Naming and Structure

#### Libraries

Generally, alias of each library must follow Maven coordinates to make it simple to guess the alias without looking at the catalog's source code.

To make accessors' hierarchy shorter, large groups of dependencies (for example, androidx) should be moved to the own catalog.
The name of the catalog should be equal to common part of group.

> **Example:**\
> `com.redmadrobot:flipper` → `redmadrobot` (catalog) + `flipper` (alias) = `redmadrobot.flipper` (accessor)

In catalogs containing libraries from different groups (like [stack catalog][versions-stack] or local project catalog) it is allowed to omit library group fully or partially if the library name is pretty unique to be used without group.

> **Examples:**
>
> - :white_check_mark: `com.jakewharton.timber:timber` → `timber`
> - :white_check_mark: `com.google.dagger:dagger` → `dagger`
> - :white_check_mark: `com.airbnb.android:lottie` → `lottie`
> - :x: `org.jetbrains.kotlinx:kotlinx-serialization-core`  `serializtion-core`
> - :x: `javax.inject:javax.inject` → `inject`

A module name might be dropped if it duplicates group name, so in the case library name included both in group and in module name, it should be included only once to the alias.
It is allowed to use `camelCase` when module name contains more than one word, but hierarchical structure doesn't make sense for this alias.

> **Examples:**
>
> - :white_check_mark: `com.google.devtools.ksp:symbol-processing` → `ksp` (KSP abbreviation already includes "symbol processing")
> - :white_check_mark: `io.gitlab.arturbosch.detekt:detekt-gradle-plugin` → `detekt-gradlePlugin`
> - :white_check_mark: `io.reactivex.rxjava3:rxjava` → `rxjava3` (alias `rxjava` is also acceptable in the case the catalog doesn't contain `rxjava2`)
> - :white_check_mark: `androidx.coordinatorlayout:coordinatorlayout` → `coordinatorlayout`
> - :x: `androidx.coordinatorlayout:coordinatorlayout` → `coordinatorLayout`
> - :x: `androidx.coordinatorlayout:coordinatorlayout` → `coordinator-layout`

There are a few cases when it is not possible or not recommended to follow library Maven coordinates:

1. If the library name or group contains words reserved by Gradle (e.g., `extensions`):
   > **Example:**
   >
   > - :x: `com.redmadrobot.extensions:core-ktx` → `extensions-coreKtx` (`extensions` is reserved for Gradle extensions)
   > - :white_check_mark: `com.redmadrobot.extensions:core-ktx` → `ktx-core`
2. If the library's hierarchy makes autocompletion useless:
   > :x: **Bad hierarchy**
   >
   > - `org.jetbrains.dokka:dokka-gradle-plugin` → `dokka-gradlePlugin`
   > - `org.jetbrains.dokka:javadoc-plugin` → `dokka-javadocPlugin`
   > - `org.jetbrains.dokka:android-documentation-plugin` → `dokka-androidDocumentationPlugin`

   > :white_check_mark: **Good hierarchy**
   >
   > - `org.jetbrains.dokka:dokka-gradle-plugin` → `dokka-gradlePlugin` (this one stays the same to separate gradle plugin from dokka plugins)
   > - `org.jetbrains.dokka:javadoc-plugin` → `dokka-plugin-javadoc`
   > - `org.jetbrains.dokka:android-documentation-plugin` → `dokka-plugin-androidDocumentation`
   >
   > After this change we can list all available dokka plugins using autocompletion.

#### Versions

Each library must have a version alias to make it possible to override the version from a project.
A version alias should be the same as the corresponding library alias.
If more than one library uses the same version alias, its name should be equal to the main dependency's alias.

#### Plugins

Plugin alias should follow the plugin ID.
Plugin artifact should also be declared in `[libraries]` section to make it possible to use it from buildSrc or composite builds.

## Troubleshooting

> [!NOTE]
>
> You can find Troubleshooting guide in the [official documentation][docs-problems].

### Unable to apply the plugin because the extension is already registered

```
Caused by: java.lang.IllegalArgumentException: Cannot add extension with name, as there is an extension already registered with that name
```

Probably, you named a version catalog as one of the Gradle plugin extensions.
Please, read the warning in [Usage](#usage) section.

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

This is an [issue](https://github.com/gradle/gradle/issues/22797) in Gradle, and it was fixed in Gradle 8.1.
In case you use older Gradle version, you can suppress it with `@Suppress("DSL_SCOPE_VIOLATION")`.

### Invalid TOML catalog definition

Check your Gradle wrapper version. The current catalog based on Gradle 7.2.

## Additional resources

For more information about version catalogs, consult the following resources.

- [Docs: Sharing dependency versions between projects][docs]
- [Docs: Troubleshooting version catalog problems][docs-problems]
- [Cédric Champeau's blog](https://melix.github.io/blog/tags/catalog.html) - articles about version catalogs from engineer working at Gradle who worked on version catalogs

[versions-redmadrobot]: versions-redmadrobot/libs.versions.toml
[versions-androidx]: versions-androidx/libs.versions.toml
[versions-stack]: versions-stack/libs.versions.toml
[changelog]: CHANGELOG.md
[issue]: https://github.com/RedMadRobot/gradle-version-catalogs/issues/new

[docs]: https://docs.gradle.org/current/userguide/platforms.html
[docs-importing]: https://docs.gradle.org/current/userguide/platforms.html#sec:importing-published-catalog
[docs-problems]: https://docs.gradle.org/current/userguide/version_catalog_problems.html
[docs-composite-builds]: https://docs.gradle.org/current/userguide/composite_builds.html
[mavenCentral]: https://search.maven.org/search?q=com.redmadrobot.versions
