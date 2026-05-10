# Calc Phase 8 Verdict

## Scope

Phase 8 covers final calc flow verification, whole-suite quality gates, device
installation readiness, and final plan reconciliation.

## User Corrections Included In Phase 8

| Requirement | Implementation | Evidence | Status |
| --- | --- | --- | --- |
| `calc_history_restoring_matrix.png` must contain tablet cases and total 24 cells | Existing matrix is 3 tools x 2 device classes x 2 orientations x 2 themes | `file` reports 3582 x 6772; visual inspection shows iPhone portrait/landscape and iPad portrait/landscape for light and dark | pass |
| Disclaimer must not overlay or cover other UI | Moved `DisclaimerRibbon` from `App` global `Stack` overlay into `AppShellBottomNavigation`, above `NavigationBar` in normal layout | `test/app_theme_mode_test.dart`; shell goldens below | pass |
| Disclaimer must be visible on search and detail screens | Added search, drug detail, and disease detail shell goldens using real screen bodies plus production bottom chrome | `disclaimer_shell_search_{light,dark}.png`, `disclaimer_shell_drug_detail_{light,dark}.png`, `disclaimer_shell_disease_detail_{light,dark}.png` | pass |
| Integration test DB must be ephemeral | `calc_tool_e2e_test.dart` runs `App` with `appDatabaseProvider.overrideWithValue(AppDatabase(NativeDatabase.memory()))` | Exact history count starts at 0, then BMI/eGFR/CrCl history counts are asserted per active tool | pass |
| Existing integration smoke test DB must also be ephemeral | `app_smoke_test.dart` now starts `App` with `AppDatabase(NativeDatabase.memory())` instead of `main_dev.dart` persistent storage | `flutter test --flavor dev -d B6A7E22E-C044-4371-B930-5D055055A4CB integration_test/app_smoke_test.dart` | pass |
| Integration tests must not appear to hang on long settle waits | Replaced `pumpAndSettle()` in `calc_tool_e2e_test.dart` with bounded short pumps plus state-specific waits, and added 2 minute per-test timeout to both integration tests | iPhone/iPad full `integration_test/` repeated after the change | pass |
| Integration test should be repeatable on iPhone and iPad simulators | Ran the full `integration_test/` directory twice per simulator after the hang fix | iPhone 17 simulator 2/2 pass; iPad Pro 11-inch simulator 2/2 pass | pass |
| Install only after full validation has passed | Ran the local install wrapper after analyze, full widget/unit/golden suite, full golden suite, integration repeats, and verdict scan passed | `install-fddr-flutter-dev-all-devices` installed all detected Android/iOS targets | pass |

## Verification

| Gate | Command | Result |
| --- | --- | --- |
| App shell structure and semantics label | `flutter test test/app_theme_mode_test.dart` | pass |
| Disclaimer shell goldens | `flutter test --tags golden test/ui/_common/disclaimer_ribbon_golden_test.dart` | pass |
| Calc widget flow | `flutter test test/ui/calc/calc_view_test.dart` | pass |
| Calc widget atoms | `flutter test test/ui/calc/widgets` | pass |
| Calc goldens | `flutter test --tags golden test/ui/calc/` | pass |
| Full analysis | `flutter analyze` | pass |
| Whitespace check | `git diff --check` | pass |
| Full widget/golden/unit suite | `flutter test` | pass |
| Full golden suite | `flutter test --tags golden` | pass |
| iPhone simulator integration pass 1 | `flutter test --flavor dev -d B6A7E22E-C044-4371-B930-5D055055A4CB integration_test/` | pass |
| iPhone simulator integration pass 2 | Same command | pass |
| iPad simulator integration pass 1 | `flutter test --flavor dev -d FB6C072E-B562-4894-A220-ABA5B3CB0594 integration_test/` | pass |
| iPad simulator integration pass 2 | Same command | pass |
| Device install | `install-fddr-flutter-dev-all-devices` | pass: Pixel 7 Pro, RYOMAのiPad, iPhone 17 simulator, iPad Pro 11-inch simulator |

## Plan Deviations

| Plan says | Repo state | Reason | Impact | Status |
| --- | --- | --- | --- | --- |
| Do not edit shell outside calc scope | `lib/app.dart` and `lib/ui/shell/app_shell.dart` changed | User explicitly identified disclaimer overlay as a blocking UI bug before integration testing | Fix is app-wide and required to avoid bottom navigation overlap | justified-deviation |
| Integration checks Disclaimer through Semantics finder | Integration checks `DisclaimerRibbon` existence and geometry; widget test checks the `Semantics` label property | `find.bySemanticsLabel` was not stable in integration/widget tree, while the `Semantics` widget property is deterministic | Accessibility label remains covered; integration avoids waiting on unstable semantics tree behavior | justified-deviation |

## Final Verdict

PASS. Phase 8 currently has no unresolved visual, interaction, integration,
quality-gate, or device-install blockers.
