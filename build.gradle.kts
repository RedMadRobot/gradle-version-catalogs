import com.redmadrobot.build.dsl.*

plugins {
    `version-catalog`
    `maven-publish`
    id("com.redmadrobot.publish-config") version "0.15"
    id("com.redmadrobot.publish") version "0.15" apply false
}

repositories {
    mavenCentral()
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
        plugin("com.redmadrobot.publish")
        plugin("org.gradle.version-catalog")
    }

    group = "com.redmadrobot.versions"
    version = "2022.07.03"

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
