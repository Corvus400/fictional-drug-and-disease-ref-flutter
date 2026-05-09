# Calc Phase 3 Verdict

## Scope

Phase 3: typed calculation domain models, calculation formulas, validation, typed JSON codecs, calculation history use cases, 50-row FIFO cap, and use case providers.

## Red / Green Evidence

| Step | 判定 | 根拠 |
|---|---|---|
| Red | yes | `flutter test test/domain/calc/ test/application/usecases/` failed on missing `lib/domain/calc/*` and calculation use case imports. |
| Green | yes | After implementation, `flutter test test/domain/calc/ test/application/usecases/ test/application/providers/usecase_providers_test.dart` passed, 50 tests. |
| Static analysis | yes | `flutter analyze` passed with `No issues found!`. |
| Phase 1 regression check | yes | `flutter test test/ui/calc/design_contract_test.dart` passed, 6 tests, after analyzer cleanup. |

## Domain / Formula Contract

| チェック項目 | 判定 | 根拠 | 実装 |
|---|---|---|---|
| `CalcType` | yes | `bmi` / `egfr` / `crcl` storage keys and display names are typed enum values. | `lib/domain/calc/calc_type.dart` |
| `Sex` | yes | `male` / `female` storage keys and eGFR coefficient are typed enum values. | `lib/domain/calc/sex.dart` |
| BMI formula | yes | Known case 170cm / 65kg -> 22.491..., normal. | `lib/domain/calc/bmi.dart` |
| BMI 7 classes | yes | Boundaries <18.5 / 18.5 / 25 / 30 / 35 / 40 / 45 are tested. | `lib/domain/calc/bmi.dart` |
| eGFR formula | yes | Japanese coefficient formula tested for male/female, including female multiplier. | `lib/domain/calc/egfr.dart` |
| CKD stages | yes | G1/G2/G3a/G3b/G4/G5 boundaries are tested. | `lib/domain/calc/egfr.dart` |
| CrCl formula | yes | Cockcroft-Gault formula tested for male/female, including 0.85 female multiplier. | `lib/domain/calc/crcl.dart` |
| validation ranges | yes | BMI, eGFR, and CrCl inclusive min/max and invalid fields/ranges are tested. | `lib/domain/calc/*.dart` |

## Codec / History Contract

| チェック項目 | 判定 | 根拠 | 実装 |
|---|---|---|---|
| inputs codec | yes | BMI/eGFR/CrCl encode-decode roundtrip tests verify schema keys from calculation-history plan. | `lib/domain/calc/codecs/calc_inputs_codec.dart` |
| result codec | yes | BMI category strings, CKD stage strings, and CrCl result schema are roundtrip-tested. | `lib/domain/calc/codecs/calc_result_codec.dart` |
| invalid payload handling | yes | codec tests verify `FormatException` for malformed payloads. | `lib/domain/calc/codecs/*.dart` |
| record use case | yes | records typed inputs/results into existing repository with UUID v4-style generated id and UTC timestamp. | `lib/application/usecases/record_calculation_history_usecase.dart` |
| 50-row FIFO | yes | 51 BMI records leave newest 50 rows; oldest row is deleted. | `test/application/usecases/record_calculation_history_usecase_test.dart` |
| list use case | yes | Empty and newest-50 success paths are tested. | `lib/application/usecases/list_calculation_history_usecase.dart` |
| delete use case | yes | deleting one row by id is tested. | `lib/application/usecases/delete_calculation_history_usecase.dart` |
| providers | yes | 6 calculation use case providers are registered and tested. | `lib/application/providers/usecase_providers.dart` |

## Plan-State 照合

| Plan says | Repo state | Reason | Impact | Status |
|---|---|---|---|---|
| Use hand-written immutable + copyWith domain classes, no freezed/json_serializable | Domain classes are hand-written, `@immutable`, with `copyWith`, `==`, and `hashCode`; no generator annotations added. | exact | No build_runner requirement added for calc domain. | exact |
| Use typed DTO/domain models, no `Map<String, dynamic>` in calc domain | `rg "Map<String, dynamic>|dynamic>" lib/domain/calc ...` returned no matches. Codecs use typed models at boundary and `Map<String, Object?>` for JSON parsing only. | exact | C8 satisfied for Phase 3. | exact |
| Codecs throw `FormatException` on parse failure | Invalid input/result payload tests cover this. | exact | Repository/usecase callers can convert failures to app errors. | exact |
| Record use case delegates persistence to `CalculationHistoryRepository` and enforces FIFO | Record use case calls repository insert/find/deleteOldestByCalcType. | exact | Existing DAO/repository remains the storage boundary. | exact |
| Return typed use case result classes | Calculate/list/record/delete use cases expose sealed result classes. | exact | UI can switch on typed success/invalid/empty/failure states. | exact |
| Phase 3 has no Golden requirement | No new golden files were added in Phase 3. | exact | UI visual checks resume in Phase 4. | exact |
| `id` is UUID v4 client-generated | Default id factory generates UUID v4-format ids with version/variant bits, without adding a package. | Avoided new dependency while preserving UUID v4 format. | No runtime package dependency added. | justified-deviation |
| Analyzer must pass before commit | `flutter analyze` initially found Phase 1 const/import issues plus Phase 3 issues; all fixed and analyzer now passes. | exact | Phase 3 commit includes small analyzer cleanup in `app_typography.dart` and `design_contract_test.dart`. | justified-deviation |

## Verification Commands

```bash
flutter test test/domain/calc/ test/application/usecases/ test/application/providers/usecase_providers_test.dart
flutter test test/ui/calc/design_contract_test.dart
flutter analyze
rg -n "Map<String, dynamic>|dynamic>" lib/domain/calc lib/application/usecases/record_calculation_history_usecase.dart lib/application/usecases/list_calculation_history_usecase.dart lib/application/usecases/delete_calculation_history_usecase.dart test/domain/calc test/application/usecases/*calculation_history_usecase_test.dart
rg -n "<local path/email patterns>" lib test pubspec.yaml pubspec.lock tmp
git diff --check
```

Result: test/analyze/check commands passed; both `rg` checks returned no matches.

## Residual Risk

- `RecordCalculationHistoryUsecase.execute` accepts `Object` inputs/result because Dart has no direct union parameter syntax for the three typed variants; unsupported objects fail before persistence and return a failure result.
- Per-calc restored-history envelope models are not introduced in Phase 3; existing `CalculationHistoryEntry` still carries JSON strings and Phase 5 UI will decode them through the typed codecs.
