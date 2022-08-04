package com.redmadrobot.gradle.catalog

import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.api.plugins.BasePlugin
import org.gradle.api.plugins.catalog.VersionCatalogPlugin.GENERATE_CATALOG_FILE_TASKNAME
import org.gradle.api.plugins.catalog.internal.CatalogExtensionInternal
import org.gradle.kotlin.dsl.apply
import org.gradle.kotlin.dsl.getByName
import org.gradle.kotlin.dsl.register
import org.gradle.language.base.plugins.LifecycleBasePlugin.CHECK_TASK_NAME

class VersionCatalogExtensionsPlugin : Plugin<Project> {

    override fun apply(target: Project) = with(target) {
        if (!plugins.hasPlugin("org.gradle.version-catalog")) {
            logger.warn(
                """
                Can not apply plugin com.redmadrobot.version-catalog-extensions:
                    Plugin org.gradle.version-catalog not found but it is required
                """.trimIndent()
            )
            return@with
        }
        apply<BasePlugin>()

        val extension = extensions.getByName<CatalogExtensionInternal>("catalog")
        val validateCatalog = tasks.register<ValidateVersionCatalogTask>(VALIDATE_CATALOG_TASK_NAME) {
            dependenciesModel.set(extension.versionCatalog)
            dependsOn(tasks.named(GENERATE_CATALOG_FILE_TASKNAME))
        }
        tasks.named(CHECK_TASK_NAME).configure { dependsOn(validateCatalog) }
    }

    companion object {
        const val VALIDATE_CATALOG_TASK_NAME = "validateCatalog"
    }
}
