# Calc Phase 6 Verdict: Responsive Layouts

Gate source: `tmp/ui_golden_design_gate.md`.

## References

- Playwright SSOT frames:
  - `tmp/calc_spec_refs/spec_calc_phase6_frames.json`
  - `tmp/calc_spec_refs/spec_calc_iphone_portrait_{light,dark}.png`
  - `tmp/calc_spec_refs/spec_calc_iphone_landscape_{light,dark}.png`
  - `tmp/calc_spec_refs/spec_calc_ipad_portrait_{light,dark}.png`
  - `tmp/calc_spec_refs/spec_calc_ipad_landscape_{light,dark}.png`
  - `tmp/calc_spec_refs/spec_calc_split_view_compact_{light,dark}.png`
  - `tmp/calc_spec_refs/spec_calc_large_text_{light,dark}.png`
- Flutter screen goldens:
  - `test/ui/calc/goldens/macos/calc_iphone_portrait_{light,dark}.png`
  - `test/ui/calc/goldens/macos/calc_iphone_landscape_{light,dark}.png`
  - `test/ui/calc/goldens/macos/calc_ipad_portrait_{light,dark}.png`
  - `test/ui/calc/goldens/macos/calc_ipad_landscape_{light,dark}.png`
  - `test/ui/calc/goldens/macos/calc_split_view_compact_{light,dark}.png`
  - `test/ui/calc/goldens/macos/calc_large_text_{light,dark}.png`
- Widget tests:
  - `test/ui/calc/calc_view_test.dart`

## Spec / Flutter / Golden Table

| Item | Spec value | Flutter implementation value | Golden / test confirmation | Status |
|---|---|---|---|---|
| iPhone portrait | `390 x 844` style phone portrait uses compact 1-pane, bottom segmented control, no tool-list side rail | `_CalcResponsiveMode.compact`; `calc-layout-compact`; bottom selector key `calc-tool-selector-bottom` | Goldens `calc_iphone_portrait_*`; Playwright refs `spec_calc_iphone_portrait_*`; visual inspection confirms compact content and bottom selector | pass |
| Compact fallback | `< 600dp` uses 1-pane with bottom segmented control | `_CalcResponsiveMode.compact`; `calc-layout-compact`; bottom selector key `calc-tool-selector-bottom` | Widget test at `480 x 900`; goldens `calc_split_view_compact_*` show vertical form/result/history and bottom segmented control | pass |
| iPhone landscape | `>= 600dp && height < 480dp`: 2-pane, left form, right result + history; tool segmented near top | `_CalcLandscapePhoneLayout` at `844 x 390`; left pane contains segmented + form, right pane contains result + collapsed history | Widget geometry asserts form left < result left; goldens `calc_iphone_landscape_*`; Playwright refs `spec_calc_iphone_landscape_*` | pass |
| iPad portrait | `>= 768dp && < 1024dp`: 2-pane, left tool-list + form, right result + chart + history | `_CalcIPadPortraitLayout` at `834 x 1194`; left width 280, gap 24, right `Expanded` result/history pane | Widget geometry asserts form left < result left and tool-list present; goldens `calc_ipad_portrait_*`; Playwright refs `spec_calc_ipad_portrait_*` | pass |
| iPad landscape | User-corrected `>= 1024dp`: 2-pane, left column stacks tool-list above form, right column stacks result + chart + history | `_CalcIPadLandscapeLayout` at `1194 x 834`; left width 440, then 24px gap, right `Expanded` result/history pane | Widget geometry asserts tool-list and form share the same left edge, tool-list is above form, form is left of result; goldens `calc_ipad_landscape_*`; Playwright refs `spec_calc_ipad_landscape_*` generated from SSOT fragments with user-directed two-pane stack | pass |
| Split View 50/50 | Width around `480dp` falls back to compact 1-pane, not tablet panes | `480 x 900` is below the 600dp breakpoint and uses `_CalcCompactLayout` | Widget test asserts compact layout, bottom selector present, tool-list absent; goldens `calc_split_view_compact_*`; Playwright refs `spec_calc_split_view_compact_*` | pass |
| Tool list | Tablet tool-list uses vertical items, active container, icon + label + formula, with no ellipsis when enough width exists | `_CalcToolList` renders BMI/eGFR/CrCl with Material Symbols; formula is below the label and wraps instead of using `TextOverflow.ellipsis`; mono text has NotoSansJP fallback for superscripts | iPad portrait/landscape goldens show full formulas; widget test asserts the eGFR formula is not ellipsized; visual inspection confirms no white tofu glyphs | pass |
| iPad landscape tool-list height | User correction: the left BMI/eGFR/CrCl list must not stretch to the bottom in landscape; it should visually match the compact content-height panel used in portrait | `_CalcToolList` uses `Column(mainAxisSize: MainAxisSize.min)` so the card height follows the three items instead of filling the pane height | Widget test first failed at `722px`, then passed with height `< 260`; updated `calc_ipad_landscape_*` goldens show the shorter tool-list card | pass |
| Dynamic Type input height | `accessibility-large-text`: field input height `56px` instead of `44px` | `CalcInputField` switches inner input box height from 44 to 56 when `MediaQuery.textScaler` reaches the large threshold | Widget test asserts `calc-input-heightCm-box` height `56`; golden `calc_large_text_*`; Playwright refs `spec_calc_large_text_*` | pass |
| Dynamic Type result value | `accessibility-large-text`: result value `54px` instead of `36px` | `CalcResultCard` switches `calc-result-value` font size from 36 to 54 under large text | Widget test asserts font size `54`; golden `calc_large_text_*` shows enlarged result without overlap | pass |
| Existing compact states | Phase 5 compact screen states remain retained | Compact layout path preserves the Phase 5 body order and bottom segmented control | `flutter test --update-goldens --tags golden test/ui/calc/calc_view_golden_test.dart` passed 128 variants including prior 118 | pass |

## Deviations

| Plan says | Repo state | Reason | Impact | Status |
|---|---|---|---|---|
| Use design frame AppBar with menu/history icons | AppBar remains title-only | User explicitly confirmed both top buttons are unnecessary; this was fixed and recorded in Phase 5 | Responsive goldens inherit the corrected title-only AppBar | justified-deviation |
| iPad landscape should have a Playwright frame | SSOT HTML does not emit a standalone iPad landscape mock frame matching the latest user correction | `tmp/capture_calc_spec_refs.mjs` generates an explicit iPad landscape reference from SSOT fragments with a user-directed two-pane left stack | Still uses Playwright-rendered SSOT fragments; source is documented in `spec_calc_phase6_frames.json` | justified-deviation |
| Full app shell in SSOT frame includes status bar, ribbon, and NavigationBar | Flutter `CalcView` screen goldens cover the tab content surface, not `AppShell` | Plan explicitly forbids editing `lib/ui/shell/app_shell.dart`; NavigationBar/ribbon behavior is owned by earlier phases and separate shell tests | Responsive layout acceptance is scoped to CalcView content panes | justified-deviation |
| SSOT CSS grid stretch can make the iPad landscape tool-list fill the full pane height | Flutter now uses content-height tool-list in landscape | User identified the full-height left list as visually inconsistent with portrait and not acceptable | Intentional UX correction; layout remains responsive and content-height | justified-deviation |
| Earlier Phase 6 draft used a 3-pane iPad landscape layout | Flutter now stacks tool-list above form in the left column | User explicitly noted the side-by-side tool-list/form layout truncates formulas and asked whether vertical layout is sufficient | Removes formula truncation and keeps result/history on the right | justified-deviation |

## Verification

- `flutter test test/ui/calc/calc_view_test.dart` passed 20 widget tests.
- `CALC_SPEC_HTML=... PLAYWRIGHT_INDEX_MJS=... node tmp/capture_calc_spec_refs.mjs` passed and generated Phase 6 reference PNGs at DPR 4.
- `flutter test --update-goldens --tags golden test/ui/calc/calc_view_golden_test.dart` passed the original 128 variants before the responsive-matrix expansion.
- Refactor verification: `calc_view.dart` was split from 1212 lines into
  `calc_view.dart` (314), `calc_responsive_layout.dart` (609), and
  `calc_history_section.dart` (294) using Dart `part` files to preserve private
  helper scope without behavior changes.
- After refactor, `flutter test test/ui/calc/calc_view_test.dart` passed 20 widget tests.
- After refactor, `flutter test --tags golden test/ui/calc/calc_view_golden_test.dart` passed 128 variants.
- After refactor, `flutter test --tags golden test/ui/calc/` passed 144 variants.
- After refactor, `flutter analyze` passed with no issues.
- User-correction verification: `flutter test test/ui/calc/calc_view_test.dart --plain-name 'uses three-pane layout on iPad landscape'` failed before the tool-list-height fix with `722px`, then passed after constraining the list to content height.
- Latest user-correction verification: `flutter test test/ui/calc/calc_view_test.dart --plain-name 'stacks tool list above form on iPad landscape'` failed before the two-pane stack fix, then passed after changing iPad landscape to left-column vertical stack.
- `CALC_SPEC_HTML=... PLAYWRIGHT_INDEX_MJS=... node tmp/capture_calc_spec_refs.mjs` passed again and generated Phase 6 reference PNGs including `spec_calc_iphone_portrait_*` and two-pane iPad landscape refs.
- `flutter test --update-goldens --tags golden test/ui/calc/` passed 146 variants after adding `calc_iphone_portrait_*`, updating iPad landscape, and adding monospace fallback for formula superscripts.
- Visual inspection:
  - `calc_iphone_portrait_light.png` shows compact portrait layout with bottom segmented control.
  - `calc_iphone_landscape_light.png` shows 2-pane form/result layout and collapsed history.
  - `calc_ipad_portrait_light.png` shows left tool-list+form and right result+expanded history.
  - `calc_ipad_landscape_light.png` shows left-column tool-list+form and right result+expanded history; formulas are not ellipsized and superscript glyphs are rendered.
  - `calc_split_view_compact_light.png` shows compact fallback with bottom segmented control.
  - `calc_large_text_light.png` shows 56px inputs and 54px result value without overlap.

## Gate Result

PASS. No `fail`, `unchecked`, or `pending` rows remain for Phase 6 responsive layout coverage currently in scope.
