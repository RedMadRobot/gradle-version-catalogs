dependencyResolutionManagement {
    versionCatalogs {
        create("rmr") {
            from(files("../versions-redmadrobot/libs.versions.toml"))
            library("versionCatalogExtensions", "com.redmadrobot.gradle:version-catalog-extensions:+")
        }
        create("stack") {
            from(files("../versions-stack/libs.versions.toml"))
        }
    }
}
