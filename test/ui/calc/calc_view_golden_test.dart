import 'package:fictional_drug_and_disease_ref/application/usecases/record_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_inputs_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_result_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../golden/golden_test_config.dart';
import '../../golden/golden_test_helpers.dart';
import '../../helpers/test_app_database.dart';

part 'calc_view_golden_scenarios.part.dart';
part 'calc_view_golden_responsive.part.dart';
part 'calc_view_golden_models.part.dart';

late AppDatabase _db;

void main() {
  setUpAll(() {
    _db = createTestAppDatabase();
  });

  tearDown(() async {
    await clearTestAppDatabase(_db);
  });

  tearDownAll(() async {
    await _db.close();
  });

  for (final tool in _CalcGoldenTool.values) {
    for (final state in _CalcGoldenState.values) {
      _calcGolden(tool: tool, state: state);
    }
  }
  _calcPartialSubsetGoldens();
  _calcImmediateErrorGoldens();
  _calcInputBoundaryGoldens();
  _calcMultiErrorGoldens();
  _calcIosInputToolbarGolden();
  _calcBmiUnderweightEdgeGolden();
  _calcEgfrLowEdgeGolden();
  _calcBmiMinEdgeGolden();
  _calcBmiMaxEdgeGolden();
  _calcEgfrMinEdgeGolden();
  _calcEgfrMaxEdgeGolden();
  _calcCrclMinEdgeGolden();
  _calcCrclMaxEdgeGolden();
  _calcEgfrFemaleGolden();
  _calcCrclFemaleGolden();
  _calcHistoryCollapsedGolden();
  _calcHistoryExpandedGolden();
  _calcHistoryEmptyGolden();
  _calcHistoryRestoringGolden();
  _calcHistoryRestoringMatrixGolden();
  _calcHistoryBoundaryEmptyGolden();
  for (final mode in _CalcHistoryBoundaryMode.values) {
    _calcHistoryBoundaryGolden(count: 1, expectedCount: 1, mode: mode);
    _calcHistoryBoundaryGolden(count: 50, expectedCount: 50, mode: mode);
    _calcHistoryBoundaryGolden(count: 51, expectedCount: 50, mode: mode);
  }
  _calcResponsiveGoldens();
}

void _calcInputBoundaryGoldens() {
  final cases =
      <
        ({
          _CalcGoldenTool tool,
          String key,
          Map<String, String> fields,
          String errorText,
        })
      >[
        (
          tool: _CalcGoldenTool.bmi,
          key: 'height-low',
          fields: {'calc-input-heightCm': '49.9', 'calc-input-weightKg': '65'},
          errorText: '50.0-250.0 cm',
        ),
        (
          tool: _CalcGoldenTool.bmi,
          key: 'height-high',
          fields: {'calc-input-heightCm': '250.1', 'calc-input-weightKg': '65'},
          errorText: '50.0-250.0 cm',
        ),
        (
          tool: _CalcGoldenTool.bmi,
          key: 'weight-low',
          fields: {'calc-input-heightCm': '170', 'calc-input-weightKg': '0.9'},
          errorText: '1.0-300.0 kg',
        ),
        (
          tool: _CalcGoldenTool.bmi,
          key: 'weight-high',
          fields: {
            'calc-input-heightCm': '170',
            'calc-input-weightKg': '300.1',
          },
          errorText: '1.0-300.0 kg',
        ),
        (
          tool: _CalcGoldenTool.egfr,
          key: 'age-low',
          fields: {
            'calc-input-ageYears': '17',
            'calc-input-serumCreatinineMgDl': '1.0',
          },
          errorText: '18-120 years',
        ),
        (
          tool: _CalcGoldenTool.egfr,
          key: 'age-high',
          fields: {
            'calc-input-ageYears': '121',
            'calc-input-serumCreatinineMgDl': '1.0',
          },
          errorText: '18-120 years',
        ),
        (
          tool: _CalcGoldenTool.egfr,
          key: 'creatinine-low',
          fields: {
            'calc-input-ageYears': '50',
            'calc-input-serumCreatinineMgDl': '0.09',
          },
          errorText: '0.10-20.00 mg/dL',
        ),
        (
          tool: _CalcGoldenTool.egfr,
          key: 'creatinine-high',
          fields: {
            'calc-input-ageYears': '50',
            'calc-input-serumCreatinineMgDl': '20.1',
          },
          errorText: '0.10-20.00 mg/dL',
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'age-low',
          fields: {
            'calc-input-ageYears': '17',
            'calc-input-weightKg': '65',
            'calc-input-serumCreatinineMgDl': '1.0',
          },
          errorText: '18-120 years',
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'age-high',
          fields: {
            'calc-input-ageYears': '121',
            'calc-input-weightKg': '65',
            'calc-input-serumCreatinineMgDl': '1.0',
          },
          errorText: '18-120 years',
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'weight-low',
          fields: {
            'calc-input-ageYears': '50',
            'calc-input-weightKg': '0.9',
            'calc-input-serumCreatinineMgDl': '1.0',
          },
          errorText: '1.0-300.0 kg',
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'weight-high',
          fields: {
            'calc-input-ageYears': '50',
            'calc-input-weightKg': '300.1',
            'calc-input-serumCreatinineMgDl': '1.0',
          },
          errorText: '1.0-300.0 kg',
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'creatinine-low',
          fields: {
            'calc-input-ageYears': '50',
            'calc-input-weightKg': '65',
            'calc-input-serumCreatinineMgDl': '0.09',
          },
          errorText: '0.10-20.00 mg/dL',
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'creatinine-high',
          fields: {
            'calc-input-ageYears': '50',
            'calc-input-weightKg': '65',
            'calc-input-serumCreatinineMgDl': '20.1',
          },
          errorText: '0.10-20.00 mg/dL',
        ),
      ];

  for (final boundaryCase in cases) {
    runGoldenMatrix(
      fileNamePrefix:
          'calc_boundary_${boundaryCase.tool.key}_${boundaryCase.key}',
      description: 'Calc boundary ${boundaryCase.tool.key} ${boundaryCase.key}',
      builder: _calcViewBuilder,
      whilePerforming: (tester) async {
        await _selectTool(tester, boundaryCase.tool);
        for (final entry in boundaryCase.fields.entries) {
          await _enterText(tester, entry.key, entry.value);
        }
        expect(find.text(boundaryCase.errorText), findsOneWidget);
        return null;
      },
    );
  }
}

void _calcImmediateErrorGoldens() {
  final cases =
      <
        ({
          _CalcGoldenTool tool,
          String key,
          Map<String, String> fields,
          String errorText,
        })
      >[
        (
          tool: _CalcGoldenTool.bmi,
          key: 'height-low-single',
          fields: {'calc-input-heightCm': '9'},
          errorText: '50.0-250.0 cm',
        ),
        (
          tool: _CalcGoldenTool.egfr,
          key: 'age-low-single',
          fields: {'calc-input-ageYears': '17'},
          errorText: '18-120 years',
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'weight-low-single',
          fields: {'calc-input-weightKg': '0.9'},
          errorText: '1.0-300.0 kg',
        ),
      ];

  for (final immediateCase in cases) {
    runGoldenMatrix(
      fileNamePrefix:
          'calc_immediate_error_${immediateCase.tool.key}_${immediateCase.key}',
      description:
          'Calc immediate error ${immediateCase.tool.key} ${immediateCase.key}',
      builder: _calcViewBuilder,
      whilePerforming: (tester) async {
        await _selectTool(tester, immediateCase.tool);
        for (final entry in immediateCase.fields.entries) {
          await _enterText(tester, entry.key, entry.value);
        }
        expect(find.text(immediateCase.errorText), findsOneWidget);
        return null;
      },
    );
  }
}

void _calcPartialSubsetGoldens() {
  final cases =
      <
        ({
          _CalcGoldenTool tool,
          String key,
          Map<String, String> fields,
        })
      >[
        (
          tool: _CalcGoldenTool.bmi,
          key: 'height-only',
          fields: {'calc-input-heightCm': '170'},
        ),
        (
          tool: _CalcGoldenTool.bmi,
          key: 'weight-only',
          fields: {'calc-input-weightKg': '65'},
        ),
        (
          tool: _CalcGoldenTool.egfr,
          key: 'age-only',
          fields: {'calc-input-ageYears': '50'},
        ),
        (
          tool: _CalcGoldenTool.egfr,
          key: 'creatinine-only',
          fields: {'calc-input-serumCreatinineMgDl': '1.0'},
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'age-only',
          fields: {'calc-input-ageYears': '50'},
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'weight-only',
          fields: {'calc-input-weightKg': '65'},
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'creatinine-only',
          fields: {'calc-input-serumCreatinineMgDl': '1.0'},
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'age-weight',
          fields: {'calc-input-ageYears': '50', 'calc-input-weightKg': '65'},
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'age-creatinine',
          fields: {
            'calc-input-ageYears': '50',
            'calc-input-serumCreatinineMgDl': '1.0',
          },
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'weight-creatinine',
          fields: {
            'calc-input-weightKg': '65',
            'calc-input-serumCreatinineMgDl': '1.0',
          },
        ),
      ];

  for (final partialCase in cases) {
    runGoldenMatrix(
      fileNamePrefix: 'calc_partial_${partialCase.tool.key}_${partialCase.key}',
      description: 'Calc partial ${partialCase.tool.key} ${partialCase.key}',
      builder: _calcViewBuilder,
      whilePerforming: (tester) async {
        await _selectTool(tester, partialCase.tool);
        for (final entry in partialCase.fields.entries) {
          await _enterText(tester, entry.key, entry.value);
        }
        expect(find.text('すべての項目を入力してください'), findsOneWidget);
        return null;
      },
    );
  }
}

void _calcIosInputToolbarGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_ios_input_toolbar',
    description: 'Calc iOS input toolbar',
    builder: _calcIosViewBuilder,
    whilePerforming: (tester) async {
      await tester.tap(
        find
            .descendant(
              of: find.byKey(const ValueKey<String>('calc-input-heightCm')),
              matching: find.byType(TextFormField),
            )
            .first,
      );
      await tester.pumpAndSettle();
      final size = MediaQuery.sizeOf(tester.element(find.byType(CalcView)));
      final expectedMatcher = size.shortestSide >= 600
          ? findsNothing
          : findsOneWidget;
      expect(
        find.byKey(const ValueKey<String>('calc-input-toolbar')),
        expectedMatcher,
      );
      return null;
    },
  );
}

void _calcGolden({
  required _CalcGoldenTool tool,
  required _CalcGoldenState state,
}) {
  runGoldenMatrix(
    fileNamePrefix: 'calc_${tool.key}_${state.key}',
    description: 'Calc ${tool.key} ${state.key}',
    builder: (theme, size, scaler) {
      return ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(_db)],
        child: MaterialApp(
          theme: theme,
          darkTheme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const CalcView(),
        ),
      );
    },
    whilePerforming: (tester) async {
      await _selectTool(tester, tool);
      await _driveState(tester, tool, state);
      await tester.pump();
      return null;
    },
  );
}
