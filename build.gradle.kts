plugins {
    id("io.github.gradle-nexus.publish-plugin") version "2.0.0-rc-1"
}

nexusPublishing {
    // Uncomment if you need to release artifacts uploaded using "publish" task.
    // repositoryDescription.set("Implicitly created (auto staging).")
    repositories {
        sonatype {
            nexusUrl.set(uri("https://s01.oss.sonatype.org/service/local/"))
            snapshotRepositoryUrl.set(uri("https://s01.oss.sonatype.org/content/repositories/snapshots/"))
        }
    }
}
