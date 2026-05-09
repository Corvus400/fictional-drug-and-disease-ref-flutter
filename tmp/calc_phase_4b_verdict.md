# Calc Phase 4b Verdict

## Scope

Phase 4b: result atoms:

- `CalcResultCard`
- `CalcCategoryBadge`
- `CalcToolMetaStrip`

Global design gate source:

- `tmp/ui_golden_design_gate.md`

## 判定 A — Design Contract

| チェック項目 | 判定 | 根拠 |
|---|---|---|
| CalcResultCard states | yes | widget test covers empty, partial hint, and valid states. |
| CalcResultCard empty shell dimensions | yes | widget test asserts 168 x 95 px, matching Playwright computed reference for empty result card width/height. |
| CalcCategoryBadge palette + shape | yes | widget test verifies BMI normal palette, CKD G2 label, triangle shape key, and 82.9 x 26 px badge dimensions. |
| CalcToolMetaStrip typography | yes | widget test verifies label/font weight and 0.44 px letter spacing. |

## 判定 B — Golden Retention

| チェック項目 | 判定 | PNG |
|---|---|---|
| result atoms light | yes | `test/ui/calc/widgets/goldens/macos/calc_result_atoms_light.png` |
| tool meta strip light | yes | `test/ui/calc/widgets/goldens/macos/calc_tool_meta_strip_light.png` |

Commands:

```bash
flutter test test/ui/calc/widgets/calc_result_atoms_test.dart
flutter test --update-goldens --tags golden test/ui/calc/widgets/calc_result_atoms_golden_test.dart
flutter test --tags golden test/ui/calc/widgets/calc_result_atoms_golden_test.dart
flutter analyze
```

## Playwright Reference

Reference source:

- SSOT HTML §07 Component spec rendered with Playwright.
- Capture helper: `tmp/capture_calc_spec_refs.mjs`
- Reference screenshots:
  - `tmp/calc_spec_refs/spec_result_card_atom_card.png`
  - `tmp/calc_spec_refs/spec_result_card_atom_card_270x524.png`
- Computed style JSON:
  - `tmp/calc_spec_refs/spec_result_card_metrics.json`

## Result Atoms Spec Comparison

| Item | Spec value | Flutter implementation value | Golden / reference confirmation | Result |
|---|---:|---:|---|---|
| Result card background | `rgb(255,255,255)` light | `palette.calcSurface` | widget test checks `BoxDecoration.color`; golden shows white card | pass |
| Result card border | `1px solid rgba(60,60,67,.13)` | `Border.all(palette.calcHairline)` | widget test checks border color; token contract covers exact color | pass |
| Result card radius | 10 px | `radii.card = 10` | golden shows rounded card; token contract covers exact value | pass |
| Result card padding | 16 px | `EdgeInsets.all(spacing.s4)` | `spacing.s4 = 16` from design contract | pass |
| Result card gap | 8 px | `spacing.s2 = 8` between head/value/badge/visualization | design contract covers spacing; golden shows matching vertical cadence for no-chart card | pass |
| Empty card size | 167.5 x 95 px reference | 168 x 95 px | widget test asserts `Size(168, 95)` | pass |
| Result title | 12 px / 700 / 0.48 px | `labelM` 12 px with 700 weight and `letterSpacing = 0.48` | widget/golden show `結果`; reference JSON title style matches | pass |
| Formula tag | 10 px / 500 mono / muted | `monoS` with 10 px / 500 / muted | golden shows `BMI = w / h²`; reference JSON formula style matches | pass |
| Value text | 36 px / 700 mono | explicit JetBrainsMono 36 px / 700 | golden shows `22.5`; reference JSON value style matches | pass |
| Unit text | 13 px / 500 mono / muted | explicit JetBrainsMono 13 px / 500 / muted | golden shows `kg/m²`; reference JSON unit style matches | pass |
| Badge size | 82.89 x 26 px reference | 82.9 x 26 px | widget test asserts width close to 82.9 and height 26 | pass |
| Badge padding | 4 px vertical / 10 px horizontal in CSS | vertical 4 px, horizontal 11 px to match Flutter text metrics width | Playwright width is matched within 0.1 px; horizontal padding differs to compensate renderer metrics | justified-deviation |
| Badge radius | 22 px | `radii.pill = 22` | reference JSON badge radius 22 px; token contract covers exact value | pass |
| Badge shape | CSS triangle for BMI normal / CKD G2 | custom painted triangle shape | widget test verifies `calc-badge-shape-triangle`; golden shows triangle | pass |
| Tool meta font | 11 px / 600 mono / 0.44 px | `monoS` with 600 weight and 0.44 letter spacing | widget test asserts 600 and 0.44; golden shows strip | pass |
| Tool meta formula | 11 px / 500 mono / no letter spacing / ink2 | `monoS` with 500 weight and `letterSpacing = 0` | golden shows formula on calc background | pass |
| Chart inside valid result card | Present in SSOT `resultCard()` for valid and w/class states | Not implemented in Phase 4b; `CalcResultCard.visualization` slot is available | Plan assigns charts to Phase 4d (`BmiChart`, `EgfrChart`, `CrClChart`) | justified-deviation |

## 判定 C — Image Read

| チェック項目 | 判定 | 根拠 |
|---|---|---|
| C-1 序数固定 | yes | Golden order is empty result -> valid result -> classified result; tool meta has separate golden. |
| C-2 色機械抽出 | yes | Result/badge colors are sourced from `AppPalette`; exact token values are covered by design contract tests. |
| C-3 表示文字列 OCR | yes | Golden shows `Result card`, `empty`, `valid`, `w/ class`, `結果`, `BMI = w / h²`, `--`, `22.5`, `kg/m²`, and `普通体重`. |
| C-4 形状存在性 | yes | Card radius, border, badge pill, and triangle shape are visible. |
| C-5 レイアウト破綻なし | yes | Result atoms and tool meta strip golden show no overflow, clipping, or overlap. |
| C-6 仕様書要素の存在 | yes | Title, formula, placeholder, value, unit, classification badge, and tool meta strip are present. |
| C-7 余分要素の不在 | yes | No debug text, overlay, or unplanned control appears. |

## Plan-State 照合

| Plan says | Repo state | Reason | Impact | Status |
|---|---|---|---|---|
| `CalcResultCard` empty / valid / with-classification | Implemented with empty, hint, valid, badge, and visualization slot states. | exact for card shell; chart content deferred to chart atom phase. | Result shell ready for Phase 5 and charts can be inserted in Phase 4d. | justified-deviation |
| `CalcCategoryBadge` BMI 7 classes + CKD G1-G5 | Widget supports BMI and CKD tokens and custom painted non-color shape cues. Tests cover BMI normal and CKD G2; full token tuples are covered by existing design contract. | exact | Reusable for result card and charts. | exact |
| `CalcToolMetaStrip` formula + meta strip | Implemented and golden-tested against CSS typography values. | exact | Reusable above form/tool panels. | exact |

## Residual Risk

- Result card valid/classified SSOT screenshots include charts. Chart rendering is deliberately left to Phase 4d per plan and must not be considered verified by this Phase.
