import com.redmadrobot.build.dsl.*

plugins {
    `version-catalog`
    `maven-publish`
    id("com.redmadrobot.publish-config") version "0.17"
    id("com.redmadrobot.publish") version "0.17" apply false
    id("com.redmadrobot.version-catalog-extensions") version "0.1" apply false
}

redmadrobot {
    publishing {
        signArtifacts.set(true)

        pom {
            setGitHubProject("RedMadRobot/gradle-version-catalogs")

            licenses {
                mit()
            }

            developers {
                developer(id = "osipxd", name = "Osip Fatkullin", email = "o.fatkullin@redmadrobot.com")
            }
            contributors {
                contributor(name = "Roman Ivanov", email = "r.ivanov@redmadrobot.com")
            }
        }
    }
}

subprojects {
    apply {
        plugin("org.gradle.version-catalog")
        plugin("com.redmadrobot.publish")
        plugin("com.redmadrobot.version-catalog-extensions")
    }

    group = "com.redmadrobot.versions"
    version = "2022.10.06"

    catalog {
        versionCatalog {
            from(files("libs.versions.toml"))
        }
    }

    publishing {
        repositories {
            if (credentialsExist("ossrh")) ossrh()
        }
    }
}
