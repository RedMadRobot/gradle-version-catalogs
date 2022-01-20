enableFeaturePreview("VERSION_CATALOGS")

pluginManagement {
    repositories {
        gradlePluginPortal()
        mavenCentral()
    }
}

rootProject.name = "versions"

include(
    "versions-androidx",
    "versions-plugins",
    "versions-redmadrobot",
    "versions-stack",
)
