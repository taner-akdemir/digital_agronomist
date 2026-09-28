import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Firebase: android/app/google-services.json OLMADAN derleme kırılır.
    id("com.google.gms.google-services")
}

// Play yükleme anahtarı (CLAUDE.md §8). android/key.properties repoya GİRMEZ
// (.gitignore); yoksa sürüm derlemesi debug anahtarıyla imzalanır — yerelde
// `flutter run --release` çalışsın, ama Play onu kabul etmez ve
// tool/release.sh anahtarsız derlemeyi reddeder.
val keyProperties = Properties().apply {
    val f = rootProject.file("key.properties")
    if (f.exists()) f.inputStream().use { load(it) }
}
val hasUploadKey = keyProperties.getProperty("storeFile") != null

android {
    namespace = "com.algebran.milktrace.milktrace"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // flutter_local_notifications java.time kullanıyor ve minSdk 26'nın
        // altında bu sınıflar yok; desugaring olmadan derleme kırılıyor.
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // Play'de değiştirilemez; Firebase uygulamaları da bu kimlikle kayıtlı.
        applicationId = "com.algebran.milktrace.milktrace"
        // Sürüm pubspec.yaml'daki `version: X.Y.Z+N`: N versionCode, Play her
        // yüklemede bir öncekinden büyük ister.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasUploadKey) {
            create("upload") {
                storeFile = file(keyProperties.getProperty("storeFile"))
                storePassword = keyProperties.getProperty("storePassword")
                keyAlias = keyProperties.getProperty("keyAlias")
                keyPassword = keyProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (hasUploadKey) {
                signingConfigs.getByName("upload")
            } else {
                logger.warn("android/key.properties yok: sürüm derlemesi DEBUG anahtarıyla imzalanıyor (Play kabul etmez).")
                signingConfigs.getByName("debug")
            }
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
