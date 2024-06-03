plugins {
    `kotlin-dsl`
}

dependencies {
    implementation(rmr.infrastructure.publish)
    implementation(stack.mavenPublishPlugin)
    implementation(rmr.versionCatalogExtensions)
}

repositories {
    mavenCentral()
}
