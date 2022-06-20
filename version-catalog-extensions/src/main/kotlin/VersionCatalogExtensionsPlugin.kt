package com.redmadrobot.gradle.catalog

import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.api.plugins.catalog.internal.CatalogExtensionInternal
import org.gradle.kotlin.dsl.getByName
import org.gradle.kotlin.dsl.register

class VersionCatalogExtensionsPlugin : Plugin<Project> {

    override fun apply(target: Project) {
        val extension = target.extensions.getByName<CatalogExtensionInternal>("catalog")
        target.tasks.register<ValidateVersionCatalogTask>("validateCatalog") {
            dependenciesModel.set(extension.versionCatalog)
        }
    }
}
