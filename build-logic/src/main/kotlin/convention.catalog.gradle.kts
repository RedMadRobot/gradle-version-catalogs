plugins {
    `version-catalog`
    id("convention.publish")
    id("com.redmadrobot.version-catalog-extensions")
}

catalog {
    versionCatalog {
        from(files("libs.versions.toml"))
    }
}

// если есть несколько вариантов атрибута "org.jetbrains.kotlin.platform.type", то первым выбираем "androidJvm"
dependencies.attributesSchema.attribute(Attribute.of("org.jetbrains.kotlin.platform.type", String::class.java)) {
    disambiguationRules.add(PreferAndroidJvmDisambiguationRule::class.java)
}

abstract class PreferAndroidJvmDisambiguationRule : AttributeDisambiguationRule<String> {
    override fun execute(details: MultipleCandidatesDetails<String>) {
        if ("androidJvm" in details.candidateValues) {
            details.closestMatch("androidJvm")
        } else if ("jvm" in details.candidateValues) {
            details.closestMatch("jvm")
        }
    }
}
