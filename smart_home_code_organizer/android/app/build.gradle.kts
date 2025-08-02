// Import this first
import java.io.File
import java.io.FileInputStream
import java.util.*

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val localProperties = Properties().apply {
    // load your *.properties file
    load(FileInputStream(File("local.properties")))
}
// get a property
val detLocalAliasVersionCode = localProperties.getProperty("flutter.versionCode")
// and don't forget to check if it does not exist!
require(detLocalAliasVersionCode != null) { "detLocalAliasVersionCode not found in local.properties file." }

val detLocalAliasVersionName = localProperties.getProperty("flutter.versionName")
// and don't forget to check if it does not exist!
require(detLocalAliasVersionName != null) { "detLocalAliasVersionName not found in local.properties file." }

val detLocalminSdkVersion = localProperties.getProperty("flutter.minSdkVersion")
// and don't forget to check if it does not exist!
require(detLocalminSdkVersion != null) { "detLocalminSdkVersion not found in local.properties file." }

val detLocaltargetSdkVersion = localProperties.getProperty("flutter.targetSdkVersion")
// and don't forget to check if it does not exist!
require(detLocaltargetSdkVersion != null) { "detLocaltargetSdkVersion not found in local.properties file." }




/*def localProperties = Properties()
def localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader("UTF-8") { reader ->
        localProperties.load(reader)
    }
}

def flutterVersionCode = localProperties.getProperty("flutter.versionCode")
if (flutterVersionCode == null) {
    flutterVersionCode = "1"
}*/

/*
def flutterVersionName = localProperties.getProperty("flutter.versionName")
if (flutterVersionName == null) {
    flutterVersionName = "1.0"
}
*/


val keyProperties = Properties().apply {
    // load your *.properties file
    load(FileInputStream(File("key.properties")))
}
// get a property
val detKeyAlias = keyProperties.getProperty("keyAlias")
// and don't forget to check if it does not exist!
require(detKeyAlias != null) { "keyAlias not found in key.properties file." }

val detStorePassword = keyProperties.getProperty("storePassword")
// and don't forget to check if it does not exist!
require(detStorePassword != null) { "detStorePassword not found in key.properties file." }

val detStoreFile = keyProperties.getProperty("storeFile")
// and don't forget to check if it does not exist!
require(detStoreFile != null) { "detStoreFile not found in key.properties file." }

val detKeyPassword = keyProperties.getProperty("keyPassword")
// and don't forget to check if it does not exist!
require(detKeyPassword != null) { "detKeyPassword not found in key.properties file." }

/*def keystoreProperties = Properties()
def keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}*/

android {
    namespace = "com.example.smart_home_code_organizer"
    compileSdk = flutter.compileSdkVersion
    //ndkVersion = flutter.ndkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "de.seriforte.smart_home_code_organizer"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = detLocalminSdkVersion.toInt()
        targetSdk = detLocaltargetSdkVersion.toInt()
        versionCode = detLocalAliasVersionCode.toInt()
        versionName = detLocalAliasVersionName
    }

    signingConfigs {
        create("release") {
            keyAlias = detKeyAlias
            keyPassword = detKeyPassword
            storeFile = file(detStoreFile)
            storePassword = detStorePassword
        }
    }
    /*signingConfigs {
        //create("release") {
        //    keyAlias = keystoreProperties["keyAlias"] as String
        //    keyPassword = keystoreProperties["keyPassword"] as String
        //    storeFile = keystoreProperties["storeFile"]?.let { file(it) }
        //    storePassword = keystoreProperties["storePassword"] as String
        //}
         release {
            keyAlias = keystoreProperties["keyAlias"'"]
            keyPassword = keystoreProperties["keyPassword"]
            storeFile = keystoreProperties["storeFile"] ? file(keystoreProperties["storeFile"]) : null
            storePassword = keystoreProperties["storePassword"]
        }
    }*/


    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            //signingConfig signingConfigs.release
        }
    }

}

flutter {
    source = "../.."
}
