# fictional-drug-and-disease-ref-flutter — AI Coding Agent Rules

> This file's content is shared between `CLAUDE.md` (read by Claude Code) and `AGENTS.md` (read by Codex). Keep them in sync — when modifying one, update the other identically.

## 作業分担

- プラン作成: Claude Code (`/Users/todayamar/.claude/plans/` 配下にプランファイルを作成)
- 実装: Codex (Plan モードを抜けて Phase 順に実行、各 Phase の完了確認コマンドが exit 0 になることを live test で確認)
- 両 AI とも本ファイルのルールに従う。Codex は加えて `~/.codex/AGENTS.md` (global) のルールも遵守

## テスト作業の必須手順

1. テストの種別判定は `flutter-dev-test-strategy` skill を必ず呼ぶ (unit / widget / golden / integration の選定)
2. テスト実装は以下のいずれかの skill に委譲する:
   - 新機能 → `t-wada-tdd-cycle`
   - バグ修正 → `t-wada-tdd-bugfix`
   - 未知 API 学習 → `t-wada-tdd-learning-test`
   - 既存テストの flaky / 偽陽性 / 偽陰性 → `t-wada-tdd-test-quality`
3. 上記 skill 発動前に方針 (種別 + 委譲先) をユーザーに明示する

## ローカル品質ゲート

`.pre-commit-config.yaml` で以下を強制:
- pre-commit: `build_runner` (annotation 変更時のみ) + `dart format` + `dart analyze` (差分ファイルのみ)
- pre-push: `build_runner` 全件 + `dart format` 全件 + `flutter analyze` + `flutter test`

CI 未投入期間中はこのフックがサイレントフォールバック検出の主装置。clone 直後に必ず以下を実行:
```
brew install pre-commit
pre-commit install --hook-type pre-commit --hook-type pre-push
```

## build_runner 運用 (完全自動化)

git 操作 (commit / push) における手動 `build_runner` 実行は **完全に廃止**。以下のフックで自動化:

- **pre-commit**: stage 済み変更ファイルに `@freezed` / `@JsonSerializable` / `@RestApi` / `extends Table` / `@DriftDatabase` のいずれかが含まれる場合のみ `dart run build_runner build --delete-conflicting-outputs` を起動。生成物が更新されたら commit を fail させ `git add '*.g.dart' '*.freezed.dart'` してから再 commit するよう促す
- **pre-push**: 全件 `build_runner build` を実行 (annotation 検出ロジックを経由しない最終ゲート、サイレントフォールバック検出)
- 生成物 (`*.g.dart` / `*.freezed.dart`) は git 管理対象 (`.gitignore` で除外しない)

開発中の動作確認 (`flutter run`) で生成物を最新に保つには、開発セッション開始時に watch を 1 度だけ立ち上げる (以降ファイル保存ごとに自動再生成):
```
dart run build_runner watch --delete-conflicting-outputs
```
`flutter run` 自体に build_runner を組み込む手段は Flutter SDK 側に存在しないため、これ以上の自動化はできない。watch を立ち上げ忘れた場合でも、commit 時点で pre-commit hook が必ず生成物の鮮度をチェックするためサイレントフォールバックは発生しない。

## テストパターン (このスタック固有)

### drift (in-memory DB)
`NativeDatabase.memory()` で in-memory SQLite を起動。雛形は `test/data/sample_drift_test.dart` 参照。`setUp` で DB 生成、`tearDown` で `await db.close()`。

### flutter_riverpod v3 (ProviderContainer)
Notifier 単体テストは `ProviderContainer` パターン:
```dart
final container = ProviderContainer(overrides: [...]);
addTearDown(container.dispose);
final value = container.read(myProvider);
```
モック差し替えは `overrides` で行う。Widget テストでは `ProviderScope(overrides: [...], child: ...)`。

### dio + retrofit
- 第 1 選択: Repository 層を `mocktail` で mock し、retrofit 生成クライアントは触らない (推奨、テストの安定性が高い)
- 第 2 選択: dio の `HttpClientAdapter` を差し替えて HTTP レイヤを fake。retrofit 生成型 `_DrugApi(dio)` に fake adapter 付き dio を渡す
- いずれも `dio_test` の `MockAdapter` は使わない (バージョン互換が脆い)

## Golden test 運用 (alchemist)

- パッケージ: `alchemist` (golden_toolkit は **discontinued** のため不採用)
- 更新コマンド: `flutter test --update-goldens --tags golden`
- 生成画像 (`test/**/*.png`) は必ず PR で diff 確認
- macOS 以外で生成された差分は採用しない (フォントレンダリング差異)

## Lint SSOT

- 採用: `package:very_good_analysis` (`analysis_options.yaml:1`)
- `flutter_lints` は採用しない (very_good_analysis のスーパーセット)
- 生成コード除外: `*.g.dart` / `*.freezed.dart` / `lib/l10n/app_localizations*.dart`

## integration_test

- emulator/simulator 起動が必要なため pre-push フック対象外
- 手動実行コマンド: `flutter test integration_test/`
- E2E 経路 (起動 → 検索 → 詳細遷移) のみカバー、ロジック検証は unit/widget で担保
