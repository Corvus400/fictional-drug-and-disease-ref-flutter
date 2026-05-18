#!/usr/bin/env bash
# stdin: facts JSON. stdout: warnings JSON.
set -euo pipefail

RENOVATE_JSON="${1:-renovate.json}"
FACTS="$(cat)"

warnings='[]'
add() {
  local code="$1"
  local pkg="$2"
  local note="$3"
  warnings="$(jq --arg c "$code" --arg p "$pkg" --arg n "$note" \
    '. + [{code:$c, package:$p, note:$n}]' <<<"$warnings")"
}

major_of() {
  sed -E 's/^v?([0-9]+).*/\1/' <<<"$1"
}

while IFS= read -r row; do
  [ -n "$row" ] || continue
  coord="$(jq -r '.coordinate // empty' <<<"$row")"
  old="$(jq -r '.old_version // empty' <<<"$row")"
  new="$(jq -r '.new_version // empty' <<<"$row")"
  file="$(jq -r '.package_file // empty' <<<"$row")"

  if grep -qiE '(^|[-.+])(alpha|beta|rc|dev|snapshot|preview|m[0-9]+)([-.+]|$)' <<<"$new"; then
    add "PRE_RELEASE" "$coord" "target version $new is a pre-release"
  fi

  if [ -n "$old" ] && [ -n "$new" ]; then
    old_major="$(major_of "$old")"
    new_major="$(major_of "$new")"
    if [[ "$old_major" =~ ^[0-9]+$ && "$new_major" =~ ^[0-9]+$ && "$old_major" != "$new_major" ]]; then
      add "MAJOR_BUMP" "$coord" "major: $old -> $new"
    fi
  fi

  case "$coord:$file" in
    flutter:*|dart:*|gradle:*|android-gradle-plugin:*|kotlin:*|cocoapods:*|*:*.flutter-version|*:android/gradle/*|*:ios/Podfile|*:ios/Podfile.lock)
      add "TOOLCHAIN_UPDATE" "$coord" "toolchain or platform requirement update via ${file:-unknown file}"
      ;;
  esac

  case "$file" in
    pubspec.lock|ios/Podfile.lock)
      add "LOCKFILE_ONLY" "$coord" "lockfile changed without an obvious manifest file in this PR row"
      ;;
  esac
done < <(jq -c '.packages[]?' <<<"$FACTS")

pr_group="$(jq -r '.group_name // empty' <<<"$FACTS")"
if [ -n "$pr_group" ] && [ -f "$RENOVATE_JSON" ]; then
  known="$(jq -r '.packageRules[].groupName // empty' "$RENOVATE_JSON" | sort -u)"
  if ! grep -Fxq "$pr_group" <<<"$known"; then
    add "GROUP_DRIFT" "" "PR group '$pr_group' is not declared in renovate.json"
  fi
fi

if [ "$(jq -r '.is_vulnerability_alert // false' <<<"$FACTS")" = "true" ]; then
  add "VULN_ALERT" "" "security advisory; urgent merge recommended"
fi

empty_count="$(jq '[.packages[]? | select((.release_notes_raw // "") == "")] | length' <<<"$FACTS")"
total_count="$(jq '.packages | length' <<<"$FACTS")"
if [ "$total_count" -gt 0 ] && [ "$empty_count" -eq "$total_count" ]; then
  add "MISSING_RELEASE_NOTES" "" "all package release notes are empty; fallback source required"
fi

jq -n --argjson w "$warnings" '{warnings: $w}'
