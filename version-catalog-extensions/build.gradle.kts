plugins {
    `kotlin-dsl`
}

group = "com.redmadrobot.build"
version = "0.1"

gradlePlugin {
    plugins {
        create("versionCatalogExtensions") {
            id = "com.redmadrobot.version-catalog-extensions"
            implementationClass = "com.redmadrobot.build.catalog.VersionCatalogExtensionsPlugin"
        }
    }
}

repositories {
    mavenCentral()
}
