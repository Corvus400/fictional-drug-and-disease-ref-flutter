# Calc Phase 4a Verdict

## Scope

Phase 4a: input atoms `CalcInputField` and `CalcSegmentedControl`.

`CalcKeyboardPanel` is intentionally not implemented after the user's
2026-05-10 direction that numeric input should use the system default keyboard.

## Global Gate Update

User direction on 2026-05-10 applies to all remaining UI/golden phases, not
only Phase 4a:

- Golden retention is not design comparison.
- Every UI/golden target must have a spec comparison table before phase close.
- The table must include Spec value, Flutter implementation value, Golden or
  Playwright reference confirmation, and pass/fail.
- A phase cannot proceed with any fail or unchecked row.
- Prefer Playwright-rendered reference screenshots from the SSOT HTML plus
  component/state-specific Flutter goldens over large composite-only goldens.

Durable handoff note for compact/resume:

- `tmp/ui_golden_design_gate.md`

## 判定 A — Design Contract

| チェック項目 | 判定 | 根拠 |
|---|---|---|
| CalcInputField states | yes | widget test covers default, placeholder, and error state; error border uses `AppPalette.calcError`. |
| System numeric keyboard | yes | widget test verifies `CalcInputField` defaults to `TextInputType.numberWithOptions(decimal: true)`. |
| CalcSegmentedControl interaction | yes | widget test taps `eGFR` and verifies selected value callback. Tool/sex dimensions, typography, letter spacing, and icons are asserted in widget tests. |
| Analyzer | yes | `flutter analyze` passed with `No issues found!`. |

## Segmented Control Spec Comparison

Reference source:

- SSOT HTML: `Calc Tools Spec.html` §07 Component spec rendered with Playwright.
- Reference screenshots:
  - `tmp/calc_spec_refs/spec_segmented_control_card.png`
  - `tmp/calc_spec_refs/spec_segmented_control_card_270x524.png`
  - `tmp/calc_spec_refs/spec_segmented_tool_row.png`
  - `tmp/calc_spec_refs/spec_segmented_sex_row.png`
- Computed style JSON: `tmp/calc_spec_refs/spec_segmented_metrics.json`
- Flutter single-component golden:
  - `test/ui/calc/widgets/goldens/macos/calc_segmented_control_atom_card_light.png`

| Item | Spec value | Flutter implementation value | Golden / reference confirmation | Result |
|---|---:|---:|---|---|
| Tool control height | 42 px | `CalcSegmentedControl.tool.height = 42` | widget test asserts `Size(358, 42)` for full-width case; single golden aligns with Playwright reference card | pass |
| Tool padding | 3 px | `CalcSegmentedControl.tool.padding = EdgeInsets.all(3)` | reference JSON `tool.style.padding = 3px` | pass |
| Tool segment gap | 2 px | `CalcSegmentedControl.tool.gap = 2` | reference JSON `tool.style.gap = 2px` | pass |
| Tool selected pill height | 36 px | full-height child inside 42 px control minus 3 px padding top/bottom | widget test asserts selected segment height 36 | pass |
| Tool selected radius | 19 px | `radii.pill - 3 = 19` | reference JSON `tool.selectedStyle.borderRadius = 19px` | pass |
| Tool font | 13 px / 700 / 0.26 px letter spacing | `bodyS` 13 px with 700 weight and `letterSpacing = 0.26` | widget test asserts 700 and 0.26 | pass |
| Sex control height | 36 px | `CalcSegmentedControl.sex.height = 36` | widget test asserts `Size(358, 36)` for full-width case; single golden aligns with Playwright reference card | pass |
| Sex padding | 2 px | `CalcSegmentedControl.sex.padding = EdgeInsets.all(2)` | reference JSON `sex.style.padding = 2px` | pass |
| Sex selected pill height | 32 px | full-height child inside 36 px control minus 2 px padding top/bottom | widget test asserts selected segment height 32 | pass |
| Sex selected radius | 20 px | `radii.pill - 2 = 20` | reference JSON `sex.selectedStyle.borderRadius = 20px` | pass |
| Sex icon presence/type | Material Symbols `male` / `female` | `Symbols.male` / `Symbols.female` | widget test asserts both icons; golden shows icons beside labels | pass |
| Sex icon size | 16 px | `_Segment` icon size 16 | widget test asserts male icon size 16; reference JSON `iconRect.height = 16` | pass |
| Disabled opacity | one 0.45 opacity layer | `enabled: false` applies one opacity layer | fixed after detecting double-opacity mismatch against Playwright reference | pass |

## 判定 B — Golden Retention

| チェック項目 | 判定 | PNG |
|---|---|---|
| input atoms light | yes | `test/ui/calc/widgets/goldens/macos/calc_input_atoms_light.png` |
| input atoms dark | yes | `test/ui/calc/widgets/goldens/macos/calc_input_atoms_dark.png` |
| segmented control atom card light | yes | `test/ui/calc/widgets/goldens/macos/calc_segmented_control_atom_card_light.png` |

Commands:

```bash
flutter test test/ui/calc/widgets/calc_input_atoms_test.dart
flutter test --update-goldens --tags golden test/ui/calc/widgets/calc_input_atoms_golden_test.dart
flutter test --update-goldens --tags golden test/ui/calc/widgets/calc_segmented_control_atom_card_golden_test.dart
flutter test --tags golden test/ui/calc/widgets/calc_input_atoms_golden_test.dart
flutter test --tags golden test/ui/calc/widgets/calc_segmented_control_atom_card_golden_test.dart
flutter analyze
```

Result: all passed.

## 判定 C — Image Read

| チェック項目 | 判定 | 根拠 |
|---|---|---|
| C-1 序数固定 | yes | Golden order is default input -> focused input -> placeholder input -> error input -> tool segmented -> sex segmented. |
| C-2 色機械抽出 | yes | Light/dark image read confirms surface, primary, error, muted, and selected-pill colors come from `AppPalette`; exact token values are covered by `test/ui/calc/design_contract_test.dart`. |
| C-3 表示文字列 OCR | yes | Image read shows `身長`, `体重`, `170.0`, `--`, `30.0`, `範囲外: 50.0〜250.0 cm`, `BMI`, `eGFR`, `CrCl`, `男性`, `女性`, `cm`, and `kg`. |
| C-4 形状存在性 | yes | Image read confirms tile radius, pill radius, focus border, error border, and selected segment shadow are visible. |
| C-5 レイアウト破綻なし | yes | Light/dark images show no clipping, overlap, text overflow, or inconsistent blank space in the input and segmented-control atoms. |
| C-6 仕様書要素の存在 | yes | Input focus border, placeholder with unit, error icon/message, tool segmented selected pill, sex segmented selected pill, male/female icons, and system numeric keyboard contract are represented. |
| C-7 余分要素の不在 | yes | Custom 240dp keyboard is absent after user direction; no debug text or extra overlay appears in the golden. |

## Plan-State 照合

| Plan says | Repo state | Reason | Impact | Status |
|---|---|---|---|---|
| `CalcInputField` default/focus/placeholder/error | All four states are rendered in golden and covered by widget test. | exact | Input atom ready for Phase 5. | exact |
| `CalcSegmentedControl` generic for tool and sex selection | Generic widget supports string values and two/three item examples. Tool and sex visual differences are represented by explicit parameters matching the CSS spec. | exact | Tool/sex selection reusable in Phase 5. | exact |
| `CalcKeyboardPanel` 240px numeric + done | Not implemented. `CalcInputField` uses the platform numeric keyboard via `TextInputType.numberWithOptions(decimal: true)`. | User explicitly directed system default numeric input on 2026-05-10. | Removes custom keyboard UI and reduces input maintenance surface. | justified-deviation |
| Commit message `(4a) feat(calc): add input atoms (CalcInputField, CalcSegmentedControl, CalcKeyboardPanel)` | Use `feat(calc): add input field and segmented control atoms`. | `CalcKeyboardPanel` is intentionally not part of the implementation after newer user direction. | Commit message will not claim a removed widget was implemented. | justified-deviation |

## Residual Risk

- The exact platform keyboard UI is not golden-testable in widget tests. Phase 5 should verify that fields remain `TextFormField` based and keep the numeric keyboard type.
