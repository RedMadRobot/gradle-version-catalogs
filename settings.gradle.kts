pluginManagement {
    repositories {
        gradlePluginPortal()
        mavenCentral()
    }
}

rootProject.name = "versions"

includeBuild("version-catalog-extensions")
include(
    "versions-androidx",
    "versions-redmadrobot",
    "versions-stack",
)
