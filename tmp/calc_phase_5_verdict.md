# Calc Phase 5 Verdict: CalcView Screen States

Gate source: `tmp/ui_golden_design_gate.md`.

## References

- Playwright SSOT frames: `tmp/calc_spec_refs/spec_calc_phase5_frames.json`
  - 30 frames: 5 calc states x 3 tools x light/dark iPhone compact.
- Flutter screen goldens:
  - 30 plan states: `test/ui/calc/goldens/macos/calc_{bmi,egfr,crcl}_{empty,partial-input,valid-input,out-of-range,result-with-classification}_{light,dark}.png`
  - 20 partial-input subset states: `calc_partial_bmi_{height-only,weight-only}_{light,dark}.png`, `calc_partial_egfr_{age-only,creatinine-only}_{light,dark}.png`, `calc_partial_crcl_{age-only,weight-only,creatinine-only,age-weight,age-creatinine,weight-creatinine}_{light,dark}.png`
  - 28 input boundary error states: `calc_boundary_bmi_{height-low,height-high,weight-low,weight-high}_{light,dark}.png`, `calc_boundary_egfr_{age-low,age-high,creatinine-low,creatinine-high}_{light,dark}.png`, `calc_boundary_crcl_{age-low,age-high,weight-low,weight-high,creatinine-low,creatinine-high}_{light,dark}.png`
  - 16 user-requested edge states: `calc_bmi_underweight-edge_{light,dark}.png`, `calc_egfr_low-edge_{light,dark}.png`, `calc_bmi_min-edge_{light,dark}.png`, `calc_bmi_max-edge_{light,dark}.png`, `calc_egfr_min-edge_{light,dark}.png`, `calc_egfr_max-edge_{light,dark}.png`, `calc_crcl_min-edge_{light,dark}.png`, `calc_crcl_max-edge_{light,dark}.png`
  - 4 sex-specific states: `calc_egfr_female_{light,dark}.png`, `calc_crcl_female_{light,dark}.png`
  - 6 history states: `calc_history_collapsed_{light,dark}.png`, `calc_history_expanded_{light,dark}.png`, `calc_history_empty_{light,dark}.png`
  - 14 history boundary states: `calc_history_boundary_empty_0_{light,dark}.png`, `calc_history_boundary_{closed,open}_{1,50,51}_{light,dark}.png`
- Flutter focused atom goldens:
  - `test/ui/calc/widgets/goldens/macos/calc_chart_bmi_edges_light.png`
  - `test/ui/calc/widgets/goldens/macos/calc_chart_egfr_edges_light.png`
  - `test/ui/calc/widgets/goldens/macos/calc_chart_crcl_edges_light.png`
  - `test/ui/calc/widgets/goldens/macos/calc_category_badges_all_light.png`
  - `test/ui/calc/widgets/goldens/macos/calc_category_badges_all_dark.png`
- Widget/state/notifier tests:
  - `test/ui/calc/calc_screen_state_test.dart`
  - `test/ui/calc/calc_screen_notifier_test.dart`
  - `test/ui/calc/calc_view_test.dart`
  - `test/ui/calc/calc_view_golden_test.dart`
  - `test/ui/calc/widgets/calc_chart_atoms_test.dart`
  - `test/ui/calc/widgets/calc_result_atoms_test.dart`

## Spec / Flutter / Golden Table

| Item | Spec / user requirement | Flutter implementation value | Golden / test confirmation | Status |
|---|---|---|---|---|
| State count | 5 calc states x 3 tools x light/dark iPhone compact | 30 CalcView golden variants from `_CalcGoldenState` x `_CalcGoldenTool` x light/dark | `flutter test --tags golden test/ui/calc/calc_view_golden_test.dart` passed 118 variants, including 30 plan states | pass |
| Partial-input matrix | User correction: every non-empty incomplete numeric input subset must be covered | Added detailed partial matrix: BMI 2 subsets, eGFR 2 subsets, CrCl 6 subsets; sex is excluded because it always has a selected value | Widget test loops all 10 subsets and asserts result remains incomplete; goldens `calc_partial_*_{light,dark}.png` cover all subsets | pass |
| Input boundary errors | User correction: every numeric input field needs lower and upper boundary golden coverage | Added BMI height/weight, eGFR age/creatinine, and CrCl age/weight/creatinine lower/upper invalid cases | Widget test loops all 14 boundary cases; `calc_boundary_*_{light,dark}.png` asserts and displays the exact range label | pass |
| Edge-case result states | BMI < 18.5 and eGFR <= 30 require dedicated golden coverage | Added `underweight-edge` BMI input `170/52`, and `low-edge` eGFR input `80/2.0` | Goldens generated for light/dark; visual check confirms `低体重` + `18.0`, and `G4 高度低下` + `25.8` | pass |
| Chart endpoint labels | BMI 10 / BMI 50 and eGFR left/right edge labels must stay inside the chart | Marker label position is clamped inside chart width; marker line/dot remain at the true value position | Widget tests assert label bounds and one-line height; focused goldens `calc_chart_bmi_edges_light.png`, `calc_chart_egfr_edges_light.png` pass | pass |
| Screen endpoint states | Screen-level endpoint examples must be visible | Added BMI min/max and eGFR nearest-min/max screen goldens | `calc_bmi_min-edge_*`, `calc_bmi_max-edge_*`, `calc_egfr_min-edge_*`, `calc_egfr_max-edge_*`; `eGFR=0` is atom-only because valid screen inputs cannot produce exactly zero | pass |
| CrCl marker patterns | CrCl has no classification labels, but low/high patient marker positions must be covered | `CrClChart` marker position is value-linked and clamped inside each track | Widget test asserts low marker left and high marker right; focused `calc_chart_crcl_edges_light.png` and screen `calc_crcl_{min,max}-edge_*` goldens pass | pass |
| Female sex patterns | eGFR and CrCl require female selected-state because sex changes result; BMI has no sex input | Sex segmented control updates state and recalculates formulas with female coefficient | Notifier tests cover female eGFR and CrCl; widget tests assert `46.6 / G3a` and `69.1`; screen goldens `calc_egfr_female_*`, `calc_crcl_female_*` show female selected | pass |
| All classification badge patterns | BMI 7 labels and CKD 6 labels must all be covered | `CalcCategoryBadge` renders every label with its non-color shape cue | Widget test finds 13 labels and shape keys; `calc_category_badges_all_{light,dark}.png` show all patterns | pass |
| Badge/chart overlap | User correction: classification badge and marker value must not visually collide | `CalcResultCard` uses `spacing.s8` when badge and chart coexist | Widget geometry tests require marker label top minus badge bottom >= 12 px for G2, G4, and BMI low | pass |
| App bar | SSOT appbar with menu, centered `計算ツール`, history icon | `CalcView` `AppBar` with `Symbols.menu`, `calcAppBarTitle`, `Symbols.history` | Screen goldens show appbar in all states | pass |
| Input fields | BMI: height/weight; eGFR: age/creatinine/sex; CrCl: age/weight/creatinine/sex | Separate form composites `CalcFormBmi`, `CalcFormEgfr`, `CalcFormCrCl` | Widget tests find the expected field keys and tool switching behavior | pass |
| Numeric input | User override: system default numeric input, no custom keyboard | `CalcInputField` remains `TextFormField` with numeric keyboard; no `CalcKeyboardPanel` implementation | No keyboard panel appears in screen goldens; plan keyboard-open image is intentionally skipped | justified-deviation |
| Result labels | Japanese labels must render, not tofu | Added NotoSansJP fallback to result hint and retained field unit fallback | Goldens show `すべての項目を入力してください`, `歳`, `G2 軽度低下`, `G4 高度低下` readable | pass |
| eGFR classification label | Result state must show stage label like `G2 軽度低下` | `_ckdStageLabel` maps all `CkdStage` values to l10n labels | Widget test `renders eGFR CKD stage label after calculation`; golden `calc_egfr_result-with-classification_*` | pass |
| BMI classification label | Result state must show BMI class, including low edge | `_bmiCategoryLabel` maps all `BmiCategory` values to l10n labels | Widget tests and `calc_bmi_underweight-edge_*` goldens cover `低体重` | pass |
| Chart marker readability | Marker circle/line/value must remain visible and not clipped | Chart atom remains 44 px; screen-level result card reserves badge/chart gap | Phase 4d chart atom goldens retain no-clipping evidence; Phase 5 screen goldens show marker values readable | pass |
| History collapsed state | Spec `history-collapsed` shows only header and expand-more | `_CalcHistorySection` hides rows when non-empty and collapsed | `calc_history_collapsed_{light,dark}.png` show `履歴 (7)` without rows | pass |
| History expanded state | Spec `history-expanded` caps list at 220 px with scroll affordance | `_CalcHistoryList` constrains max height to 220 px and adds bottom gradient when rows > 5 | `calc_history_expanded_{light,dark}.png` and `calc_history_boundary_50_*` show capped list with bottom fade | pass |
| History empty state | Empty history state should be visible, not a header-only `履歴 (0)` | `_CalcHistorySection` renders `CalcHistoryEmptyState` whenever history is empty | Widget test asserts `履歴 (0)` plus `履歴はありません`; `calc_history_empty_*` and `calc_history_boundary_empty_0_*` show empty card | pass |
| History empty interaction | User correction: when history count is 0, open/close should be disabled | `_CalcHistoryHeader` receives `onToggle: null` for empty history and uses `history_toggle_off` instead of expand icons | Widget test taps `履歴 (0)` and asserts the empty state remains; boundary golden asserts the same before capture | pass |
| History count boundaries | User correction: history golden must cover 0 fixed-empty and 1/50/51 closed/open | Golden test seeds 0/1/50/51 rows; 51 is capped by `RecordCalculationHistoryUsecase` to 50 visible rows | `calc_history_boundary_empty_0_*`, `calc_history_boundary_closed_{1,50,51}_*`, `calc_history_boundary_open_{1,50,51}_*`; test asserts 51 renders `履歴 (50)` | pass |
| Dark mode | Same states in dark mode | `runGoldenMatrix` emits light/dark for every state | 59 screen prefixes x 2 modes = 118 retained variants; classification atom patterns also have light/dark goldens | pass |

## Deviations

| Plan says | Repo state | Reason | Impact | Status |
|---|---|---|---|---|
| `valid-input` and `result-with-classification` are separate visual states for every calc type | BMI/eGFR runtime auto-classifies immediately after valid input; their `valid-input` goldens therefore show the classified result path | Current product interaction has no explicit calculate/classify button, and BMI/eGFR usecases return result + classification atomically | No user-facing missing state; the explicit classified path is covered. A future manual calculate step would need separate state wiring | justified-deviation |
| Mock `RecordCalculationHistoryUsecase` with mocktail in notifier tests | Tests use real in-memory Drift database with provider override | Usecase classes are `final`; in-memory integration gives stronger coverage without changing production types | Slightly broader test than pure unit, but deterministic and clears DB between tests | justified-deviation |
| Keyboard-open golden | Not implemented | User explicitly changed numeric input requirement to system default numeric input and no custom keyboard | No custom keyboard visual exists to capture | justified-deviation |
| SSOT result card has `gap: s2` and chart `margin-top: s2` | Flutter uses `s8` when badge and chart coexist | User reported the SSOT-equivalent spacing caused visually poor badge/value-label crowding; geometry test now requires >= 12 px gap | Intentional screen-level correction; atom chart dimensions remain spec-matched | justified-deviation |

## Verification

- `flutter test test/ui/calc/calc_view_test.dart` passed.
- `flutter test --update-goldens --tags golden test/ui/calc/calc_view_golden_test.dart` passed 118 variants.
- `flutter test test/ui/calc/widgets/calc_chart_atoms_test.dart` passed.
- `flutter test test/ui/calc/widgets/calc_result_atoms_test.dart` passed.
- `flutter test --tags golden test/ui/calc/widgets/calc_chart_atoms_golden_test.dart` passed.
- `flutter test --tags golden test/ui/calc/widgets/calc_result_atoms_golden_test.dart` passed.
- `flutter test --tags golden test/ui/calc/` passed.
- `flutter analyze` passed with no issues.
- `git diff --check` passed.
- Local information scan passed: no local absolute user path, email, or secret env var name match in changed text files.
- `file` confirmed edge goldens are `390 x 875`.
- Visual inspection:
  - `calc_bmi_underweight-edge_light.png` shows `低体重` and `18.0` separated.
  - `calc_egfr_low-edge_light.png` shows `G4 高度低下` and `25.8` separated.
  - `calc_chart_bmi_edges_light.png` and `calc_chart_egfr_edges_light.png` show left/right endpoint marker labels inside the crop.
  - `calc_chart_crcl_edges_light.png` shows low/high patient markers inside the track crop.
  - `calc_crcl_min-edge_light.png` and `calc_crcl_max-edge_light.png` show CrCl screen marker endpoints inside the result card.
  - `calc_egfr_female_light.png` shows female selected with `46.6 / G3a`.
  - `calc_crcl_female_light.png` shows female selected with `69.1`.
  - `calc_partial_bmi_height-only_light.png` and `calc_partial_bmi_weight-only_light.png` show both incomplete BMI subsets.
  - `calc_partial_egfr_age-only_light.png` and `calc_partial_egfr_creatinine-only_light.png` show both incomplete eGFR subsets.
  - `calc_partial_crcl_*_light.png` shows six incomplete CrCl subsets.
  - `calc_boundary_bmi_*_light.png`, `calc_boundary_egfr_*_light.png`, and `calc_boundary_crcl_*_light.png` show all numeric field lower/upper error labels.
  - `calc_history_boundary_empty_0_light.png` shows `履歴 (0)`, disabled empty icon, and `履歴はありません`.
  - `calc_history_boundary_closed_1_light.png` shows `履歴 (1)` with rows hidden.
  - `calc_history_boundary_open_1_light.png` shows one expanded row.
  - `calc_history_boundary_open_50_light.png` shows `履歴 (50)` with capped list and bottom fade.
  - `calc_history_boundary_open_51_light.png` also shows `履歴 (50)`, proving the 51st insert is not rendered as an extra row.
  - `calc_category_badges_all_light.png` and `calc_category_badges_all_dark.png` show all BMI/CKD labels without tofu or clipping.

## Gate Result

PASS. No `fail`, `unchecked`, or `pending` rows remain for Phase 5 screen-state golden coverage currently in scope.
