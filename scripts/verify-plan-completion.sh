#!/usr/bin/env bash
set -euo pipefail

fail() {
  printf 'plan completion guard failed: %s\n' "$1" >&2
  exit 1
}

warn() {
  printf 'plan completion guard advisory: %s\n' "$1" >&2
}

changed_files_since_upstream() {
  local upstream
  if upstream="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)"; then
    git diff --name-only "$upstream"...HEAD
    git diff --name-only
    git diff --name-only --cached
    return
  fi
  if git rev-parse --verify HEAD~1 >/dev/null 2>&1; then
    git diff --name-only HEAD~1..HEAD
  fi
  git diff --name-only
  git diff --name-only --cached
}

changed_ui_files="$(changed_files_since_upstream | sort -u | rg '^(lib/ui/|test/ui/)' || true)"

if [ -n "$changed_ui_files" ]; then
  warn "UI files changed. Before reporting completion, map user/design requirements to widget, design-contract, golden, integration, or Computer Use evidence."
fi

if [ -n "$changed_ui_files" ] &&
  git diff '@{u}'...HEAD -- $changed_ui_files 2>/dev/null |
    rg -n "Text\\(['\"]|labelText: ['\"]|hintText: ['\"]|tooltip: ['\"]" >/dev/null; then
  warn "UI text literals changed. Confirm user-visible copy belongs in l10n/domain/config/fixtures instead of production UI code."
fi

cmp -s AGENTS.md CLAUDE.md || fail "AGENTS.md and CLAUDE.md must stay identical"

if rg -n 'Dto\b' lib/domain lib/ui; then
  fail "DTO types must not leak into lib/domain or lib/ui"
fi

if rg -n 'Map<String, dynamic>|dynamic>' \
  lib/domain/drug/drug_nested.dart \
  lib/domain/disease/disease_nested.dart; then
  fail "detail domain nested models must not use dynamic JSON maps"
fi

if rg -n '\bdynamic\b' lib/domain \
  -g '!**/*.g.dart' \
  -g '!**/*.freezed.dart'; then
  fail "domain layer must not use dynamic"
fi

if rg -n "package:flutter_riverpod" lib/domain \
  -g '!**/*.g.dart' \
  -g '!**/*.freezed.dart'; then
  fail "domain layer must not import Riverpod"
fi

if rg -n "package:fictional_drug_and_disease_ref/data/repositories" lib/domain \
  -g '!**/*.g.dart' \
  -g '!**/*.freezed.dart'; then
  fail "domain layer must not depend on concrete data repositories"
fi

if [ -d lib/domain/usecases ] || [ -d lib/domain/providers ]; then
  fail "usecase orchestration and providers must live outside lib/domain"
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
