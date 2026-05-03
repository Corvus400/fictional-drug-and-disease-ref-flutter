#!/usr/bin/env bash
set -euo pipefail

files=$(git diff --cached --name-only --diff-filter=ACMR \
  | grep -E '\.dart$' \
  | grep -v -E '\.(g|freezed)\.dart$' \
  || true)
[[ -z "$files" ]] && exit 0

needs_build=$(echo "$files" \
  | xargs grep -lE "@freezed|@JsonSerializable|@RestApi|extends Table|@DriftDatabase" 2>/dev/null \
  || true)
[[ -z "$needs_build" ]] && exit 0

dart run build_runner build --delete-conflicting-outputs

if ! git diff --quiet -- '*.g.dart' '*.freezed.dart'; then
  echo "[build_runner] generated files have changed. Stage them with:"
  echo "  git add '*.g.dart' '*.freezed.dart'"
  echo "and re-commit."
  exit 1
fi
