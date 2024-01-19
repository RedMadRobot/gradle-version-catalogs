plugins {
    `version-catalog`
    id("convention.publish")
    id("com.redmadrobot.version-catalog-extensions")
}

catalog {
    versionCatalog {
        from(files("libs.versions.toml"))
    }
}
