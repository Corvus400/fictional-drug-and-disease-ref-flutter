# Gotchas Patterns

Detection rules applied by `scripts/apply-gotchas.sh`.

## MAJOR_BUMP

- Input: each `packages[]` item in facts JSON
- Rule: semver major differs between `old_version` and `new_version`
- Report: Warnings -> `major: <old> -> <new>`

## PRE_RELEASE

- Input: each `packages[].new_version`
- Rule: target version contains alpha, beta, rc, dev, snapshot, preview, or milestone markers
- Report: Warnings -> pre-release stability note

## GROUP_DRIFT

- Input: PR title group name and `renovate.json` `packageRules[].groupName`
- Rule: parsed group name is non-empty and not declared in Renovate package rules
- Report: Warnings -> group is not declared

## VULN_ALERT

- Input: PR title/body
- Rule: title contains `[SECURITY]` or vulnerability text, or body contains Renovate vulnerability markers
- Report: Security section -> urgent merge recommendation

## MISSING_RELEASE_NOTES

- Input: facts JSON
- Rule: every package has empty `release_notes_raw`
- Report: Warnings -> fallback source required

## TOOLCHAIN_UPDATE

- Input: package coordinate or changed package file
- Rule: update touches Flutter, Dart, Gradle, Android Gradle Plugin, Kotlin, CocoaPods, `.flutter-version`, Android Gradle wrapper, or iOS Podfile lock
- Report: Warnings -> verify against repo runtime requirements

## LOCKFILE_ONLY

- Input: changed package file
- Rule: update row points only at `pubspec.lock` or `ios/Podfile.lock`
- Report: Warnings -> confirm manifest constraints and generated lockfiles are coherent
