---
name: check-update-all-dependencies
description: Review Renovate-generated dependency update PRs for this Flutter repository and post an analysis report as a PR comment. Use when reviewing dependency PRs in batch or assessing a specific dependency update.
allowed-tools: Bash(gh pr:*), Bash(gh issue:*), Bash(gh api:*), Bash(gh repo view:*), Bash(gh pr diff:*), Bash(gh pr comment:*), Bash(bash .claude/skills/check-update-all-dependencies/scripts/*), Read, Grep, Glob, WebFetch, Task, mcp__context7__resolve-library-id, mcp__context7__query-docs
---

# check-update-all-dependencies

Review Renovate-generated dependency update PRs and post an analysis report as a PR comment.

## Arguments

- `dry-run` (optional): print reports to stdout without posting comments.

## Preconditions

- Renovate is enabled and labels PRs with `dependencies`.
- `renovate.json` contains `prBodyColumns` with `Source` and `prBodyDefinitions.Source`.
- `gh` CLI is authenticated.

## Step 0 - Collect Flutter project runtime requirements

Run:

```bash
bash .claude/skills/check-update-all-dependencies/scripts/collect-project-requirements.sh
```

Pass the emitted table inline to every per-PR subagent. The table is the judgement baseline for toolchain PRs.

Source preference is config before docs:

1. `.flutter-version`
2. `pubspec.yaml` `environment.sdk`
3. `.github/actions/setup-flutter/action.yml`
4. `android/gradle/wrapper/gradle-wrapper.properties`
5. `android/settings.gradle.kts`
6. `android/app/build.gradle.kts`
7. `ios/Podfile`
8. `ios/Podfile.lock`

If two sources disagree, trust machine-readable config and surface the discrepancy in the report notes.

## Step 1 - Resolve target repository

```bash
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
```

## Step 2 - Discover target PRs

```bash
gh pr list --repo "$REPO" --label dependencies --state open --json number,title,url,labels
```

If no PR exists, inspect the Dependency Dashboard:

```bash
gh issue list --repo "$REPO" --label renovate --state open \
  --search "Dependency Dashboard in:title" --json number,title,url,body
```

For dashboard-only mode, emit a single summary in chat and do not post per-PR comments.

## Step 3 - Load SSOT artifacts

Read:

- `pubspec.yaml`
- `pubspec.lock`
- `renovate.json`
- `.flutter-version`
- `android/settings.gradle.kts`
- `android/gradle/wrapper/gradle-wrapper.properties`
- `ios/Podfile`
- `ios/Podfile.lock`

## Step 4 - Per-PR parallel analysis

Spawn one read-only subagent per PR. The parent orchestrates and aggregates only; it must not silently rewrite a subagent's judgement label.

The subagent prompt must include:

- `$REPO`
- PR number
- Step 0 runtime requirement table
- Step 3 SSOT excerpts
- Steps 5-9 checklist
- The literal phrase `エビデンス付きで報告すること（ファイルパス:行番号:該当コード）`
- A line saying the subagent MUST NOT use `mcp__*`, `Write`, `Edit`, or `NotebookEdit`

## Step 5 - Collect facts

```bash
bash .claude/skills/check-update-all-dependencies/scripts/collect-pr-facts.sh \
  "$REPO" "$PR_NUMBER" > facts.json
```

If `._parse_failed == true`, use `._raw_body` as context instead of structured fields.

## Step 6 - Detect gotchas

```bash
bash .claude/skills/check-update-all-dependencies/scripts/apply-gotchas.sh \
  renovate.json < facts.json > warnings.json
```

## Step 7 - Semantic synthesis

Using `facts.json`, `warnings.json`, and Step 0 runtime requirements:

1. Summarize release notes into Breaking changes / New features / Bug fixes / Deprecations. If Renovate body is empty, use the package `source_url` or `compare_url`.
2. For `MAJOR_BUMP`, use current official docs or migration guides when available. For Dart/Flutter packages, prefer pub.dev changelog/source links from Renovate before broader web lookup.
3. Search concrete breaking API names in:
   - `lib/`
   - `test/`
   - `integration_test/`
   - `pubspec.yaml`
   - `analysis_options.yaml`
   - `android/**/*.gradle.kts`
   - `ios/Podfile`
   - `.github/workflows/`
4. Recommended action rule, first match wins:
   - `TOOLCHAIN_UPDATE` plus mismatch against Step 0 requirement -> `保留 (project requirement mismatch: <runtime> <pinned> vs <target>; sources: <file:line,...>)`
   - `VULN_ALERT` -> `要緊急対応 (security, urgent merge)`
   - Breaking change hit in code -> `要対応 (action required)`
   - `MAJOR_BUMP` without Breaking hits -> `要確認 (manual verification)`
   - `LOCKFILE_ONLY` without manifest context -> `要確認 (lockfile-only update; verify generated lockfile)`
   - Otherwise -> `マージ可 (safe to merge)`
5. Merge-order hint:
   - `保留` -> `—`
   - `要緊急対応` -> `1 (security)`
   - `要対応` or `要確認` -> `manual review — sequence with toolchain updates`
   - independent `マージ可` -> `順不同 (independent)`
   - dependent `マージ可` -> `after #<blocker PR>`

## Step 8 - Render report

Use `references/report-template.md`. Fill every placeholder, including:

- `{{merge_order_hint}}`
- `{{project_requirement_check}}`

Escape external issue references as inline code, for example `` `#123` ``.

Data source footer must be one of:

- `Primary`
- `Primary+Fallback`
- `Primary+Fallback+MigrationGuide`
- `Fallback-only (parse failed)`

## Step 9 - Post or dry-run

```bash
if [ "$MODE" = "dry-run" ]; then
  printf '%s\n' "$REPORT"
else
  gh pr comment --repo "$REPO" "$PR_NUMBER" --body "$REPORT"
  gh pr view --repo "$REPO" "$PR_NUMBER" --json url -q .url
fi
```

## Step 10 - Aggregate summary

After every per-PR subagent has returned, emit one aggregate summary in chat:

```markdown
| PR | 内容 | 判定 | マージ順序 | プロジェクト要件照合 | コメントURL |
|----|------|------|------------|--------------------|-------------|
| #10 | dio 5.9.1 -> 5.9.2 (patch) | マージ可 | 順不同 | — | <url> |
```

Before printing the table, verify:

- every `保留` row has `—` in `マージ順序`
- every `不一致` cell names a Step 0 source file
- no label changed between the per-PR report and aggregate

## Gotchas

- Do not assume Gradle version catalogs exist; this Flutter repo keeps Android plugin pins in `android/settings.gradle.kts`.
- Flutter SDK changes are project toolchain changes, not ordinary package updates.
- `pubspec.lock` and `ios/Podfile.lock` are generated lockfiles but are tracked; lockfile-only PRs need manifest coherence checks.
- The aggregate summary is for chat only. Individual PR comments already contain per-PR detail.
