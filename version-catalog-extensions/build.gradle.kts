plugins {
    `kotlin-dsl`
}

group = "com.redmadrobot.gradle"
version = "0.1"

gradlePlugin {
    plugins {
        create("versionCatalogExtensions") {
            id = "com.redmadrobot.version-catalog-extensions"
            implementationClass = "com.redmadrobot.gradle.catalog.VersionCatalogExtensionsPlugin"
        }
    }
}

repositories {
    mavenCentral()
}
