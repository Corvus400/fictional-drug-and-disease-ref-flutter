# Calc Phase 2 Verdict

## Scope

Phase 2: app-wide `DisclaimerRibbon` widget, `MaterialApp.router.builder` overlay, focused widget tests, app overlay test, and golden retention.

## 判定 A — 数値 SSOT 一致

| チェック項目 | 判定 | 根拠 | 修正ターゲット |
|---|---|---|---|
| ribbon height phone portrait | yes | `DisclaimerRibbon` height is 26dp and widget test verifies 390x844. | `lib/ui/_common/disclaimer_ribbon.dart` |
| ribbon height phone landscape | yes | `DisclaimerRibbon` height is 22dp and widget test verifies 844x390. | `lib/ui/_common/disclaimer_ribbon.dart` |
| ribbon height tablet | yes | `DisclaimerRibbon` height is 28dp and widget test verifies 834x1194. | `lib/ui/_common/disclaimer_ribbon.dart` |
| bottom offset above NavigationBar | yes | app overlay test verifies `Positioned(left: 0, right: 0, bottom: 80)`. | `lib/app.dart` |
| NavigationBar height unchanged | yes | `git diff -- lib/ui/shell/app_shell.dart` has no output. | `lib/ui/shell/app_shell.dart` |
| ribbon colors | yes | widget test verifies bg/fg/accent colors from `AppPalette`. | `lib/ui/_common/disclaimer_ribbon.dart` |
| IgnorePointer | yes | widget test verifies `IgnorePointer` descendant. | `lib/ui/_common/disclaimer_ribbon.dart` |
| semantics label | yes | `DisclaimerRibbon` sets fixed semantics label `免責: 架空データ・医療判断には使用しないでください`. | `lib/ui/_common/disclaimer_ribbon.dart` |
| accent separator structure | yes | l10n `detailDisclaimer` is split into two text segments and rendered as `· text · text ·`; widget test verifies 3 accent dots. | `lib/ui/_common/disclaimer_ribbon.dart` |

Commands:

```bash
flutter test test/ui/_common/disclaimer_ribbon_test.dart
flutter test test/app_theme_mode_test.dart --plain-name 'app overlays DisclaimerRibbon above the NavigationBar'
```

Result: PASS.

## 判定 B — Golden Retention

| チェック項目 | 判定 | 根拠 | PNG |
|---|---|---|---|
| DisclaimerRibbon phone light | yes | generated and retained by full golden run. | `test/ui/_common/goldens/macos/disclaimer_ribbon_phone_light.png` |
| DisclaimerRibbon phone dark | yes | generated and retained by full golden run. | `test/ui/_common/goldens/macos/disclaimer_ribbon_phone_dark.png` |
| DisclaimerRibbon tablet light | yes | generated and retained by full golden run. | `test/ui/_common/goldens/macos/disclaimer_ribbon_tablet_light.png` |
| DisclaimerRibbon tablet dark | yes | generated and retained by full golden run. | `test/ui/_common/goldens/macos/disclaimer_ribbon_tablet_dark.png` |
| existing goldens | yes | `flutter test --tags golden` PASS, 80 scenarios. Existing drug/disease/search/detail/sample goldens were regenerated in this Phase and are included in the commit. | `test/**/goldens/macos/*.png` |

Commands:

```bash
flutter test --update-goldens --tags golden test/ui/_common/disclaimer_ribbon_golden_test.dart
flutter test --tags golden
```

Result: PASS, 80 golden scenarios. Search golden tests emit existing fallback-image warning logs, but exit code is 0 and final result is `All tests passed!`.

## 判定 C — Codex Image Read + 数値 SSOT

| チェック項目 | 判定 | 根拠 | 検出座標 or 抽出 hex | 修正ターゲット |
|---|---|---|---|---|
| C-1 序数固定 | yes | Golden bottom row order is accent dot -> English text -> accent dot -> Japanese text -> accent dot. | phone/tablet PNG visual read | `lib/ui/_common/disclaimer_ribbon.dart` |
| C-2 色機械抽出 | yes | Background is ribbon dark token, text is ribbon fg token, dots use accent token. Widget test checks token equality. | bg token, fg token, accent token | `lib/ui/_common/disclaimer_ribbon.dart` |
| C-5 レイアウト破綻なし | yes | Initial single-text implementation clipped on phone. Fixed with segmented `Flexible` + `FittedBox`; phone/tablet light/dark images now show complete text and no overlap. | bottom ribbon visual read | `lib/ui/_common/disclaimer_ribbon.dart` |
| C-6 仕様書要素の存在 | yes | Visible ribbon contains `·` separators and both disclaimer text segments. | bottom ribbon visual read | `lib/ui/_common/disclaimer_ribbon.dart` |
| C-7 余分要素の不在 | yes | No debug text or interactive controls in the ribbon; `IgnorePointer` prevents touch capture. | full PNG visual read | `lib/ui/_common/disclaimer_ribbon.dart` |

## Plan-State 照合

| Plan says | Repo state | Reason | Impact | Status |
|---|---|---|---|---|
| `lib/ui/_common/disclaimer_ribbon.dart` を新規追加 | `DisclaimerRibbon` added with fixed height rules, palette tokens, semantics, IgnorePointer, and accent separator structure. | exact | App-wide ribbon widget is reusable. | exact |
| `lib/app.dart` の `MaterialApp.router.builder` に overlay を追加 | `Stack` wraps every routed child and positions `DisclaimerRibbon` at `bottom: 80`. | exact | All app routes receive the overlay. | exact |
| `lib/ui/shell/app_shell.dart` は変更禁止 | no diff in `lib/ui/shell/app_shell.dart`. | exact | NavigationBar remains default height. | exact |
| bottom offset は 80dp 固定 | app overlay test verifies `bottom == 80`. | exact | C13 satisfied. | exact |
| ribbon visible text is bound to l10n | widget reads `l10n.detailDisclaimer`, then splits ` / ` into two visual segments. | plan explicitly allowed reuse of `detailDisclaimer`; §09 requires accent-separated structure. | Existing l10n value remains compatible with detail tests while ribbon matches visual structure. | exact |
| Phase 2 existing goldens are included | existing drug/disease/search/detail/sample PNGs changed after Phase 1 font migration and Phase 2 golden update; all are included in this Phase. | plan requires not carrying existing golden diffs into later phases. | Phase 3 starts without stale golden drift. | exact |
| Existing screen goldens prove app-wide overlay | app-wide overlay is proved by `MaterialApp.router.builder` test; existing screen goldens render lower-level views/widgets and do not include the full app overlay. | current test architecture does not mount `App` for those existing goldens. | Coverage is split: app-wide placement by widget test, screen visual retention by existing golden tests. | justified-deviation |

## Residual Risk

- App-wide overlay is mechanically verified at the root `App` level, not by per-route full-app golden screenshots for every tab/detail route.
- Existing golden PNGs changed broadly because Phase 1 replaced app fonts with variable fonts. They were regenerated and retained in Phase 2 as required.
