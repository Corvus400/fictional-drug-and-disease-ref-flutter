#!/usr/bin/env bash
set -euo pipefail

fail() {
  printf 'plan completion guard failed: %s\n' "$1" >&2
  exit 1
}

cmp -s AGENTS.md CLAUDE.md || fail "AGENTS.md and CLAUDE.md must stay identical"

if rg -n 'Dto\b' lib/domain lib/ui; then
  fail "DTO types must not leak into lib/domain or lib/ui"
fi

if rg -n 'Map<String, dynamic>|dynamic>' \
  lib/domain/drug/drug_nested.dart \
  lib/domain/disease/disease_nested.dart; then
  fail "detail domain nested models must not use dynamic JSON maps"
fi

if rg -n 'catch \(_\)\s*\{\s*\}' lib/data lib/domain; then
  fail "bare catch blocks must not silently swallow errors"
fi

if rg -n '"http://|"https://' lib/data; then
  fail "data layer URLs must come from config, not hardcoded literals"
fi

if rg -n 'flutter_secure_storage' pubspec.yaml lib; then
  fail "flutter_secure_storage must not be introduced for this unauthenticated app"
fi
