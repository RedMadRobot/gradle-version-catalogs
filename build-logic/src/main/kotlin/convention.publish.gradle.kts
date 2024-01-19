import com.redmadrobot.build.dsl.*

plugins {
    id("com.redmadrobot.publish-config")
    id("com.redmadrobot.publish")
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

publishing {
    repositories {
        if (credentialsExist("ossrh")) ossrh()
    }
}
