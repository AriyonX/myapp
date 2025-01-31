allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

android {
    compileSdkVersion 34 // Güncel Android SDK sürümü

    defaultConfig {
        applicationId "com.example.myapp" // Uygulama kimliği
        minSdkVersion 21                 // Minimum desteklenen Android sürümü
        targetSdkVersion 34              // Hedef Android sürümü
        versionCode 1                    // Uygulama sürüm kodu
        versionName "1.0"                // Uygulama sürüm ismi
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
