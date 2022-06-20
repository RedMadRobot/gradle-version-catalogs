dependencyResolutionManagement {
    versionCatalogs {
        create("stack") {
            from(files("../versions-stack/libs.versions.toml"))
        }
    }
}
