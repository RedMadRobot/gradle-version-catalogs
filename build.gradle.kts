fun properties(key: String) = project.findProperty(key).toString()

plugins {
    `version-catalog`
    `maven-publish`
}

repositories {
    mavenCentral()
}

subprojects {
    apply {
        plugin("org.gradle.maven-publish")
        plugin("org.gradle.version-catalog")
    }

    group = "com.redmadrobot.versions"

    catalog {
        versionCatalog {
            from(files("libs.versions.toml"))
        }
    }

    publishing {
        publications {
            create<MavenPublication>("maven") {
                from(components["versionCatalog"])
            }
        }
    }
}
