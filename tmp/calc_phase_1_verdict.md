# Calc Phase 1 Verdict

## Scope

Phase 1: font assets, design token ThemeExtensions, calc l10n keys, token swatch golden.

## 判定 A — 数値 SSOT 一致

| チェック項目 | 判定 | 根拠 | 修正ターゲット |
|---|---|---|---|
| AppPalette calc shell tokens | yes | `flutter test test/ui/calc/design_contract_test.dart` PASS。light/dark の `--c6-*` / ribbon tokens を `AppPalette.calc*` と照合。 | `lib/theme/app_palette.dart` |
| BMI 7-class palette | yes | `AppPalette.calcBmiCategoryPalette` の bg/fg/IconData shape が仕様書 §02/§04 tuple と一致。 | `lib/theme/app_palette.dart` |
| CKD G1-G5 palette | yes | `AppPalette.calcCkdStagePalette` の bg/fg/IconData shape が仕様書 §02/§04 tuple と一致。 | `lib/theme/app_palette.dart` |
| AppSpacing | yes | 4/8/12/16/20/24/28/32/40 を test で照合。 | `lib/theme/app_spacing.dart` |
| AppRadii | yes | badge/chip/tile/card/sheetCard/fab/sheetTop/pill を test で照合。 | `lib/theme/app_radii.dart` |
| AppTypography | yes | 9 段の fontFamily/fontSize/fontWeight/height を test で照合。 | `lib/theme/app_typography.dart` |
| ThemeExtension registration | yes | `AppTheme.light/dark().extension<T>()` で AppSpacing/AppRadii/AppTypography を取得できることを test で確認。 | `lib/theme/app_theme.dart` |

Command:

```bash
flutter test test/ui/calc/design_contract_test.dart
```

Result: PASS, 6 tests.

## 判定 B — Golden Retention

| チェック項目 | 判定 | 根拠 | PNG |
|---|---|---|---|
| token swatch light | yes | `flutter test --update-goldens --tags golden test/ui/calc/calc_tokens_golden_test.dart` 後、retention command PASS。 | `test/ui/calc/goldens/macos/calc_tokens_swatch_light.png` |
| token swatch dark | yes | `flutter test --tags golden test/ui/calc/` PASS。 | `test/ui/calc/goldens/macos/calc_tokens_swatch_dark.png` |

Command:

```bash
flutter test --tags golden test/ui/calc/
```

Result: PASS, 2 golden scenarios.

## 判定 C — Codex Image Read + 数値 SSOT

| チェック項目 | 判定 | 根拠 | 検出座標 or 抽出 hex | 修正ターゲット |
|---|---|---|---|---|
| C-1 序数固定 | yes | Golden は上から title → color swatches → Typography → Radii の順。仕様書 Phase 1 token swatch 目的と一致。 | light/dark PNG visual read | `test/ui/calc/calc_tokens_golden_test.dart` |
| C-2 色機械抽出 | yes | light: bg/surface/primary/error/warn/success/ribbon/accent が AppPalette calc token と視覚一致。dark: bg/surface/primary/error/warn/success/ribbon/accent が AppPalette calc token と視覚一致。 | light primary #007AFF, error #B3261E, ribbon #1A1C1E, accent #FFB4AB; dark primary #9ECAFF, error #FFB4AB, ribbon #0D0E13 | `lib/theme/app_palette.dart` |
| C-4 形状存在性 | yes | radii sample で badge/tile/card/pill の角丸差が視認できる。 | bottom radii row | `test/ui/calc/calc_tokens_golden_test.dart` |
| C-5 レイアウト破綻なし | yes | text overflow、重なり、はみ出しなし。Alchemist scenario header/ribbon は既存 golden harness 表示。 | full PNG visual read | `test/ui/calc/calc_tokens_golden_test.dart` |
| C-7 余分要素の不在 | yes | token swatch 内に debug text、未参照 overlay、不要 icon なし。 | full PNG visual read | `test/ui/calc/calc_tokens_golden_test.dart` |

## Plan-State 照合

| Plan says | Repo state | Reason | Impact | Status |
|---|---|---|---|---|
| NotoSansJP / JetBrainsMono variable fonts を `assets/fonts/` に取得 | `NotoSansJP.ttf`, `JetBrainsMono.ttf`, `NotoSansJP-OFL.txt`, `JetBrainsMono-OFL.txt` 取得済み | exact | FontManifest の variable font 化が可能 | exact |
| `material_symbols_icons` を追加 | `pubspec.yaml` / `pubspec.lock` に `material_symbols_icons: ^4.2928.1` 追加済み | exact | Phase 2 以降で Material Symbols 利用可能 | exact |
| `pubspec.yaml flutter.fonts` を variable font 2 family に置換 | NotoSansJP / JetBrainsMono の single asset 定義に置換済み | exact | old OTF 不使用 | exact |
| 既存 OTF を削除 | `NotoSansJP-Regular.otf` / `NotoSansJP-Bold.otf` 削除済み、参照 `rg` は 0 件 | exact | 重複削減 | exact |
| `calcResultPlaceholder = "—"` | 仕様書 SSOT `L.placeholder` は `"--"` のため `calcResultPlaceholder` は `"--"` | 仕様書 HTML が SSOT と明記され、Phase 1 開始時再読で差分を確認 | 表示/OCR は仕様書に一致。プラン列挙値からは差分あり | justified-deviation |
| `calcHistoryEmpty = "計算履歴がありません"` | 仕様書 SSOT `L.histEmpty` は `"履歴はありません"` のため `calcHistoryEmpty` は `"履歴はありません"` | 仕様書 HTML が SSOT と明記され、approved labels を優先 | 表示/OCR は仕様書に一致。プラン列挙値からは差分あり | justified-deviation |
| `detailDisclaimer` 既存値を利用し、必要なら ribbon 用 key を追加 | `detailDisclaimer` 維持、`disclaimerRibbonText` も同値で追加 | plan has both reuse consideration and explicit new key | Phase 2 で widget 側がどちらも選べる | exact |
| AppPalette/AppSpacing/AppRadii/AppTypography を SSOT 化 | design contract test で全 pass | exact | 判定 A の機械検証可能 | exact |

## Residual Risk

- C-2 は Codex Vision の visual read による判定で、pixel sampler tool による座標 RGB 抽出ではない。
- AppPalette の BMI/CKD palette key enum は design token 用 enum (`CalcBmiCategoryToken` / `CalcCkdStageToken`) として theme layer に閉じた。Phase 3 の domain enum とは変換を介す必要がある。
