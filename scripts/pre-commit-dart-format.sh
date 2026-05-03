#!/usr/bin/env bash
set -euo pipefail

files=$(git diff --cached --name-only --diff-filter=ACMR | grep -E '\.dart$' | grep -v -E '\.(g|freezed)\.dart$' || true)
if [[ -z "$files" ]]; then
  exit 0
fi

echo "$files" | xargs dart format --set-exit-if-changed
