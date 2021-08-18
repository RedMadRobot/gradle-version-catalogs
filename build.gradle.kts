fun properties(key: String) = project.findProperty(key).toString()

plugins {
    kotlin("jvm") version "1.5.21"
    `version-catalog`
    `maven-publish`
}

group = properties("project.group")
version = properties("project.version")

repositories {
    mavenCentral()
}

catalog {
    versionCatalog {
        from(files("gradle/libs.versions.toml"))
    }
}

publishing {
    publications {
        create<MavenPublication>("maven") {
            from(components["versionCatalog"])
        }
    }
}