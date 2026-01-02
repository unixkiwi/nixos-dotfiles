{ pkgs, ... }:

let
  # Define the specific SDK composition
  ndkVersion = "28.2.13676358";
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [
      "34.0.0"
      "33.0.1"
    ];
    platformVersions = [
      "36"
      "35"
      "34"
      "33"
    ];
    abiVersions = [
      "armeabi-v7a"
      "arm64-v8a"
    ];
    includeNDK = true;
    ndkVersions = [ ndkVersion ];
    includeCmake = true;
    cmakeVersions = [ "3.22.1" ];

    # For the emulator/phone
    /*
      includeEmulator = true;
      includeSystemImages = true;
      includeSources = false;
      includeExtras = [
        "extras;google;m2repository"
        "extras;android;m2repository"
      ];
    */
  };
in
{
  programs.adb.enable = true;
  programs.java.enable = true;

  environment.systemPackages = with pkgs; [
    flutter
    android-studio
    androidComposition.androidsdk # This provides the SDK with write-access wrappers
    jdk17 # Flutter currently prefers JDK 17 for Android builds
  ];

  # Crucial for Flutter to find the SDK on NixOS
  environment.sessionVariables = {
    ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
    ANDROID_NDK_HOME = "${androidComposition.androidsdk}/libexec/android-sdk/ndk/${ndkVersion}";
    GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidComposition.androidsdk}/libexec/android-sdk/build-tools/34.0.0/aapt2";
  };
}
