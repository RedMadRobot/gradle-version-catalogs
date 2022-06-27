package com.redmadrobot.gradle.catalog

import org.gradle.api.DefaultTask
import org.gradle.api.artifacts.Configuration
import org.gradle.api.attributes.Usage
import org.gradle.api.internal.catalog.DefaultVersionCatalog
import org.gradle.api.internal.catalog.DependencyModel
import org.gradle.api.internal.catalog.PluginModel
import org.gradle.api.provider.Property
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.TaskAction
import org.gradle.kotlin.dsl.named

abstract class ValidateVersionCatalogTask : DefaultTask() {

    @get:Input
    abstract val dependenciesModel: Property<DefaultVersionCatalog>

    @TaskAction
    fun validate() {
        val catalog = dependenciesModel.get()

        // Check libraries in catalog are resolvable
        val configuration = createConfiguration()
        configuration.addLibraries(catalog)
        println("Resolved dependencies:")
        configuration.resolvedConfiguration
            .firstLevelModuleDependencies
            .forEach { println("- ${it.name}") }

        catalog.checkVersionsUsed()
    }

    private fun createConfiguration(): Configuration {
        return project.configurations.create(CONFIGURATION_NAME) {
            isTransitive = false
            isCanBeResolved = true

            attributes {
                attribute(Usage.USAGE_ATTRIBUTE, project.objects.named(Usage.JAVA_API))
            }

            // Ignore capabilities conflicts
            resolutionStrategy.capabilitiesResolution.all {
                select(candidates.first())
            }
        }
    }

    private fun Configuration.addLibraries(catalog: DefaultVersionCatalog) {
        catalog.libraries
            .forEach { dependency ->
                val dependencyNotation = "${dependency.group}:${dependency.name}:${dependency.version}"
                project.dependencies.add(name, dependencyNotation)
            }
    }

    private fun DefaultVersionCatalog.checkVersionsUsed() {
        val librariesVersions = libraries.map { it.versionRef }.toSet()
        val pluginsVersions = plugins.map { it.versionRef }.toSet()
        val unusedVersions = versionAliases - librariesVersions - pluginsVersions

        if (unusedVersions.isNotEmpty()) logger.warn("[WARNING] These versions are not used: $unusedVersions")
    }

    private companion object {
        const val CONFIGURATION_NAME = "libraries"
    }
}

private val DefaultVersionCatalog.libraries: Sequence<DependencyModel>
    get() = libraryAliases
        .asSequence()
        .map(::getDependencyData)

private val DefaultVersionCatalog.plugins: Sequence<PluginModel>
    get() = pluginAliases
        .asSequence()
        .map(::getPlugin)
