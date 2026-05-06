# fictional-drug-and-disease-ref-flutter — AI Coding Agent Rules

> This file's content is shared between `CLAUDE.md` (read by Claude Code) and `AGENTS.md` (read by Codex). Keep them in sync — when modifying one, update the other identically.

## 作業分担

- プラン作成: Claude Code (ユーザー管理の Claude Code プランディレクトリ配下にプランファイルを作成)
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

## UI / デザイン仕様準拠の完了判定

- 「デザイン通り」と指示された UI 作業では、参照された画像 / JSX / HTML / 仕様書を先に確認し、対象画面状態・操作状態・余白・角丸・色・密度・データ表示要件をタスクリスト化してから実装する。
- 検索画面の Round 系仕様では、Round6 だけで不足する状態がある場合、ユーザーが共有した検索画面デザイン資料を Round5 から遡って確認し、古い仕様と新しい仕様の衝突を明示する。
- TDD 指定時は、production UI を変更する前に該当要件を Red として固定する。構造・操作は widget test、見た目は design contract / golden、端末依存操作は integration test または Computer Use で担保する。
- 「機能テストが通った」だけで「デザイン通り」と報告してはならない。完了報告では、デザイン状態ごとに対応する test / golden / Computer Use / 未確認項目を列挙する。
- `flutter run` やインストール成功は「端末に入った」証跡であり、「操作できる」「デザイン通り」「全パターン確認済み」の証跡ではない。Android / iPhone / iPad の確認は端末別に、実施した操作と結果を分けて報告する。
- production UI にユーザー表示文言・サンプル値・デザイン由来の固定ラベルを直書きしない。l10n、domain data、config、fixture など適切な SSOT に置く。例外的な非表示・テスト専用 literal は理由を明記する。
- デザイン資料が仕様・ドメイン事実・ユーザー最新指示と矛盾する場合は、実装せずに矛盾を明示して解消する。古いデザインにある誤バッジや仮文字列を取り込まない。

## プラン実行完了判定

- プランファイル実行時は、テスト成功だけで完了扱いしない。完了報告前にプランに明記されたファイル・型・インターフェース要件と実装状態を照合する
- プランが typed DTO / typed domain model を要求している場合、nested 構造を `Map<String, dynamic>` や JSON wrapper で代替してはならない。代替が必要な場合は「完了」ではなく「未達 / 逸脱」として報告する
- 最終報告には必ず `実装済み Phase` / `未実装 Phase` / `成功基準 pass-fail` / `意図的逸脱` / `残リスク` を含める
- 本リポジトリの detail domain (`lib/domain/drug/drug_nested.dart` / `lib/domain/disease/disease_nested.dart`) に `Map<String, dynamic>` / `dynamic>` を残してはならない

## ローカル品質ゲート

`.pre-commit-config.yaml` で以下を強制:
- pre-commit: `build_runner` (annotation 変更時のみ) + `dart format` + `dart analyze` (差分ファイルのみ)
- pre-push: `build_runner` 全件 + `dart format` 全件 + `flutter analyze` + `flutter test` + plan completion guard

CI 未投入期間中はこのフックがサイレントフォールバック検出の主装置。clone 直後に必ず以下を実行:
```
brew install pre-commit
pre-commit install --hook-type pre-commit --hook-type pre-push
```

## l10n と mock-server の SSOT 整合

- 医薬品 / 疾患の絞り込み軸 (投与経路・剤形・規制区分・診療科・患者背景・ICD-10 章 等) のラベル文字列は mock-server (https://github.com/Corvus400/fictional-drug-and-disease-ref-mock-server) の Kotlin enum (`model/drug/enums/` および `model/disease/enums/`) の KDoc コメント (`/** 〜 */`) を SSOT とする。アプリ側で独自に翻訳・改変しない (例: 「ophthalmic = 点眼」を「眼科」と訳出するのは禁止 — 「眼科」は診療科の `MedicalDepartment.OPHTHALMOLOGY`)
- l10n キー (`searchDrug*` / `searchDisease*`) を追加・変更する際は mock-server の対応する enum KDoc 値と完全一致させる
- chip の表示順は mock-server `/categories` API レスポンス順に従う。アプリ側で `sort` 等の並び替えは入れない
- 整合は `test/l10n/drug_filter_alignment_test.dart` の contract test で守る
- 別タスク TODO: mock-server enum から l10n arb を codegen する仕組みは今回スコープ外

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
