# Calc Phase 7 Design Verdict

Phase 7: history row swipe-to-delete, restore interaction, restoring visual
state, and history expansion animation.

## Evidence

| Target | Spec value | Flutter implementation | Evidence | Status |
|---|---|---|---|---|
| Swipe direction | History row exposes delete on left swipe | `Dismissible.direction = endToStart` | `test/ui/calc/widgets/calc_history_row_test.dart` | pass |
| Swipe threshold | Reveal after 40% swipe | `dismissThresholds: {endToStart: 0.4}` | Widget test asserts threshold and reveal | pass |
| Delete action size/color | Exposed delete rail, destructive color | `deleteRevealed` row uses 72px rail and `calcError` | `calc_swipe_to_delete_{light,dark}.png` | pass |
| Restore work timing | Lock only during actual restore processing | `_restoreFromHistory` uses `try/finally` with no artificial delay | `restores a history row without artificial delay` | pass |
| Restore visual placement | Indicator appears inline near result chart, not as modal | `CalcHistoryRestoringIndicator` is rendered in `CalcResultCard` visualization slot | `calc_history_restoring_after_{light,dark}.png` | pass |
| Restore disabled state | Screen content is disabled/dimmed while restoring | `IgnorePointer` wraps the responsive body; form/history/tool controls and result content are dimmed | `disables calc tool switching while history is restoring` and restoring goldens | pass |
| Restore unmount safety | No state update after the view is removed | `finally` checks `mounted` before clearing the flag | `does not call setState after unmount during history restore` | pass |
| Tool coverage | BMI, eGFR, and CrCl show the indicator in the same result-card slot | State-injected widget test covers all three tools | `places restoring indicator in the result card for every tool` | pass |
| Device/theme coverage | iPhone/iPad, portrait/landscape, light/dark, all tools | 3 tools x 2 devices x 2 orientations x 2 themes | `calc_history_restoring_matrix.png` (24 cells) | pass |
| History expansion duration | 320ms | `AnimatedSize(duration: Duration(milliseconds: 320))` | `lib/ui/calc/calc_history_section.dart` | pass |
| History expansion easing | cubic-bezier(.2,0,0,1) | `Cubic(0.2, 0, 0, 1)` | `lib/ui/calc/calc_history_section.dart` | pass |
| Existing screen retention | Existing calc screen states remain stable after input controller sync | Updated goldens reflect normalized input text (`1`, not `1.0`) consistent with SSOT references | `flutter test --tags golden test/ui/calc/` | pass |

## Commands

```bash
CALC_SPEC_HTML="/Users/todayamar/Desktop/Claude Design/計算ツール/Calc Tools Spec.html" CALC_SPEC_REF_DIR="$PWD/tmp/calc_spec_refs" PLAYWRIGHT_INDEX_MJS="/Users/todayamar/.npm/_npx/e41f203b7505f1fb/node_modules/playwright/index.mjs" node tmp/capture_calc_spec_refs.mjs
flutter test test/ui/calc/widgets/calc_history_row_test.dart
flutter test test/ui/calc/calc_view_test.dart
flutter test --tags golden test/ui/calc/
flutter analyze
git diff --check
```

## Plan Deviations

| Plan says | Repo state | Reason | Impact | Status |
|---|---|---|---|---|
| Show restore overlay spinner for 200ms after tapping history row | Production code locks only during the actual restore call; golden uses `debugRestoringHistory` to render the visual state | User correction: artificial 200ms delay for visibility is not acceptable | Runtime has no artificial wait; visual state remains testable | justified-deviation |
| Goldens include `calc_history_restoring_after_<light|dark>.png` | Those files exist, plus a 24-cell matrix `calc_history_restoring_matrix.png` | User requested tool, device, orientation, and theme coverage | Coverage is stricter than the original plan | justified-deviation |

## Residual Risk

- The current restore operation is synchronous and usually too fast for users to
  see the indicator during normal use. If future restore work becomes async or
  heavier, the same lock/indicator path will remain active for the real
  processing duration.
