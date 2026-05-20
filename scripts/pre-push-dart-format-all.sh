#!/usr/bin/env bash
set -euo pipefail

mapfile -t dart_files < <(git ls-files '*.dart')
if ((${#dart_files[@]} == 0)); then
  exit 0
fi

dart format --set-exit-if-changed "${dart_files[@]}"
