# Conserve les métadonnées Flutter et WebView nécessaires en release.
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class com.pichillilorenzo.flutter_inappwebview.** { *; }
-keep class io.flutter.plugins.urllauncher.** { *; }

# Évite les warnings inutiles liés aux annotations Kotlin/AndroidX.
-dontwarn kotlin.**
-dontwarn androidx.**