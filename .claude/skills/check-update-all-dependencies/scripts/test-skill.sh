#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"
SKILL_DIR="$ROOT_DIR/.claude/skills/check-update-all-dependencies"

requirements="$("$SKILL_DIR/scripts/collect-project-requirements.sh")"

grep -F '| flutter | 3.41.5 | .flutter-version:1 |' <<<"$requirements" >/dev/null
grep -F '| dart | ^3.11.3 | pubspec.yaml:10 |' <<<"$requirements" >/dev/null
grep -F '| gradle | 8.14 | android/gradle/wrapper/gradle-wrapper.properties:5 |' <<<"$requirements" >/dev/null
grep -F '| java | 17 | android/app/build.gradle.kts:14 |' <<<"$requirements" >/dev/null
grep -F '| ios | 17.0 | ios/Podfile:1 |' <<<"$requirements" >/dev/null
grep -F '| cocoapods | 1.16.2 | ios/Podfile.lock:36 |' <<<"$requirements" >/dev/null

warnings="$(
  "$SKILL_DIR/scripts/apply-gotchas.sh" renovate.json \
    < "$SKILL_DIR/tests/fixtures/renovate-pr-facts.json"
)"

jq -e '.warnings[] | select(.code == "MAJOR_BUMP" and .package == "flutter")' <<<"$warnings" >/dev/null
jq -e '.warnings[] | select(.code == "GROUP_DRIFT")' <<<"$warnings" >/dev/null
jq -e '.warnings[] | select(.code == "LOCKFILE_ONLY" and .package == "shared_preferences")' <<<"$warnings" >/dev/null
jq -e '.warnings[] | select(.code == "TOOLCHAIN_UPDATE" and .package == "flutter")' <<<"$warnings" >/dev/null
