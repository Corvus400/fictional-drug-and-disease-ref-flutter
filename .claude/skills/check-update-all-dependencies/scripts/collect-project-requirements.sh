#!/usr/bin/env bash
set -euo pipefail

line_no() {
  local file="$1"
  local pattern="$2"
  awk -v pat="$pattern" 'index($0, pat) { print NR; exit }' "$file"
}

emit_header() {
  printf '| Runtime | Version | Source |\n'
  printf '|---------|---------|--------|\n'
}

emit_row() {
  local runtime="$1"
  local version="$2"
  local source="$3"
  [ -n "$version" ] || return 0
  printf '| %s | %s | %s |\n' "$runtime" "$version" "$source"
}

emit_header

if [ -f .flutter-version ]; then
  flutter_version="$(tr -d '[:space:]' < .flutter-version)"
  emit_row "flutter" "$flutter_version" ".flutter-version:1"
fi

if [ -f pubspec.yaml ]; then
  dart_line="$(line_no pubspec.yaml '  sdk:')"
  dart_version="$(awk '/^[[:space:]]+sdk:/ { sub(/^[[:space:]]+sdk:[[:space:]]*/, ""); gsub(/["'\'']/, ""); print; exit }' pubspec.yaml)"
  emit_row "dart" "$dart_version" "pubspec.yaml:$dart_line"
fi

if [ -f android/gradle/wrapper/gradle-wrapper.properties ]; then
  gradle_line="$(line_no android/gradle/wrapper/gradle-wrapper.properties 'distributionUrl=')"
  gradle_version="$(sed -nE 's|^distributionUrl=.*gradle-([0-9][^-]*)-.*$|\1|p' android/gradle/wrapper/gradle-wrapper.properties)"
  emit_row "gradle" "$gradle_version" "android/gradle/wrapper/gradle-wrapper.properties:$gradle_line"
fi

if [ -f android/app/build.gradle.kts ]; then
  java_line="$(line_no android/app/build.gradle.kts 'sourceCompatibility = JavaVersion.VERSION_')"
  java_version="$(sed -nE 's/.*sourceCompatibility = JavaVersion\.VERSION_([0-9]+).*/\1/p' android/app/build.gradle.kts | head -1)"
  emit_row "java" "$java_version" "android/app/build.gradle.kts:$java_line"
fi

if [ -f android/settings.gradle.kts ]; then
  agp_line="$(line_no android/settings.gradle.kts 'id("com.android.application") version')"
  agp_version="$(sed -nE 's/.*id\("com\.android\.application"\) version "([^"]+)".*/\1/p' android/settings.gradle.kts)"
  emit_row "android-gradle-plugin" "$agp_version" "android/settings.gradle.kts:$agp_line"

  kotlin_line="$(line_no android/settings.gradle.kts 'id("org.jetbrains.kotlin.android") version')"
  kotlin_version="$(sed -nE 's/.*id\("org\.jetbrains\.kotlin\.android"\) version "([^"]+)".*/\1/p' android/settings.gradle.kts)"
  emit_row "kotlin" "$kotlin_version" "android/settings.gradle.kts:$kotlin_line"
fi

if [ -f ios/Podfile ]; then
  ios_line="$(line_no ios/Podfile "platform :ios")"
  ios_version="$(sed -nE "s/^platform :ios, '([^']+)'.*/\1/p" ios/Podfile)"
  emit_row "ios" "$ios_version" "ios/Podfile:$ios_line"
fi

if [ -f ios/Podfile.lock ]; then
  pods_line="$(line_no ios/Podfile.lock 'COCOAPODS:')"
  pods_version="$(sed -nE 's/^COCOAPODS:[[:space:]]*([0-9].*)$/\1/p' ios/Podfile.lock)"
  emit_row "cocoapods" "$pods_version" "ios/Podfile.lock:$pods_line"
fi
