import com.redmadrobot.build.dsl.contributor
import com.redmadrobot.build.dsl.developer
import com.redmadrobot.build.dsl.mit
import com.redmadrobot.build.dsl.setGitHubProject

plugins {
    id("com.vanniktech.maven.publish")
    signing
}

mavenPublishing {
    publishToMavenCentral(automaticRelease = true)
    signAllPublications()

    coordinates(artifactId = project.name)

    pom {
        name = project.name
        description = project.description

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
