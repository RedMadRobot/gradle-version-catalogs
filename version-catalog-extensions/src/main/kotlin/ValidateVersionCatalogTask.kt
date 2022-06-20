package com.redmadrobot.gradle.catalog

import org.gradle.api.DefaultTask
import org.gradle.api.artifacts.Configuration
import org.gradle.api.attributes.Usage
import org.gradle.api.internal.catalog.DefaultVersionCatalog
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
        catalog.libraryAliases
            .asSequence()
            .map(catalog::getDependencyData)
            .forEach { dependency ->
                val dependencyNotation = "${dependency.group}:${dependency.name}:${dependency.version}"
                project.dependencies.add(name, dependencyNotation)
            }
    }

    private companion object {
        const val CONFIGURATION_NAME = "libraries"
    }
}
