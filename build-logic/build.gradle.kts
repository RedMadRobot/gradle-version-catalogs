plugins {
    `kotlin-dsl`
}

dependencies {
    implementation(rmr.infrastructure.publish)
    implementation(rmr.versionCatalogExtensions)
}

repositories {
    mavenCentral()
}
