fun properties(key: String) = project.findProperty(key).toString()

plugins {
    kotlin("jvm") version "1.5.21"
}

group = properties("project.group")
version = properties("project.version")

repositories {
    mavenCentral()
}