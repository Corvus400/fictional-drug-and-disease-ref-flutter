import 'package:fictional_drug_and_disease_ref/application/usecases/record_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../golden/golden_test_helpers.dart';
import '../../helpers/test_app_database.dart';

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
  _calcInputBoundaryGoldens();
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
      sizes: const ['phone'],
      textScalers: const ['normal'],
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
      sizes: const ['phone'],
      textScalers: const ['normal'],
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

void _calcGolden({
  required _CalcGoldenTool tool,
  required _CalcGoldenState state,
}) {
  runGoldenMatrix(
    fileNamePrefix: 'calc_${tool.key}_${state.key}',
    description: 'Calc ${tool.key} ${state.key}',
    sizes: const ['phone'],
    textScalers: const ['normal'],
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

Future<void> _selectTool(WidgetTester tester, _CalcGoldenTool tool) async {
  if (tool == _CalcGoldenTool.bmi) {
    return;
  }
  await tester.tap(find.text(tool.label));
  await tester.pumpAndSettle();
}

Future<void> _driveState(
  WidgetTester tester,
  _CalcGoldenTool tool,
  _CalcGoldenState state,
) async {
  switch (state) {
    case _CalcGoldenState.empty:
      return;
    case _CalcGoldenState.partialInput:
      await _enterFirstField(tester, tool);
    case _CalcGoldenState.validInput:
    case _CalcGoldenState.resultWithClassification:
      await _enterValid(tester, tool);
    case _CalcGoldenState.outOfRange:
      await _enterOutOfRange(tester, tool);
  }
}

Future<void> _enterFirstField(
  WidgetTester tester,
  _CalcGoldenTool tool,
) async {
  switch (tool) {
    case _CalcGoldenTool.bmi:
      await _enterText(tester, 'calc-input-heightCm', '170');
    case _CalcGoldenTool.egfr:
      await _enterText(tester, 'calc-input-ageYears', '50');
    case _CalcGoldenTool.crcl:
      await _enterText(tester, 'calc-input-ageYears', '50');
  }
}

Future<void> _enterValid(WidgetTester tester, _CalcGoldenTool tool) async {
  switch (tool) {
    case _CalcGoldenTool.bmi:
      await _enterText(tester, 'calc-input-heightCm', '170');
      await _enterText(tester, 'calc-input-weightKg', '65');
    case _CalcGoldenTool.egfr:
      await _enterText(tester, 'calc-input-ageYears', '50');
      await _enterText(tester, 'calc-input-serumCreatinineMgDl', '1.0');
    case _CalcGoldenTool.crcl:
      await _enterText(tester, 'calc-input-ageYears', '50');
      await _enterText(tester, 'calc-input-weightKg', '65');
      await _enterText(tester, 'calc-input-serumCreatinineMgDl', '1.0');
  }
}

void _calcBmiUnderweightEdgeGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_bmi_underweight-edge',
    description: 'Calc bmi underweight edge',
    sizes: const ['phone'],
    textScalers: const ['normal'],
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
      await _enterText(tester, 'calc-input-heightCm', '170');
      await _enterText(tester, 'calc-input-weightKg', '52');
      await tester.pump();
      return null;
    },
  );
}

void _calcEgfrLowEdgeGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_egfr_low-edge',
    description: 'Calc egfr low edge',
    sizes: const ['phone'],
    textScalers: const ['normal'],
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
      await _selectTool(tester, _CalcGoldenTool.egfr);
      await _enterText(tester, 'calc-input-ageYears', '80');
      await _enterText(tester, 'calc-input-serumCreatinineMgDl', '2.0');
      await tester.pump();
      return null;
    },
  );
}

void _calcBmiMinEdgeGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_bmi_min-edge',
    description: 'Calc bmi min edge',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _enterText(tester, 'calc-input-heightCm', '200');
      await _enterText(tester, 'calc-input-weightKg', '40');
      await tester.pump();
      return null;
    },
  );
}

void _calcBmiMaxEdgeGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_bmi_max-edge',
    description: 'Calc bmi max edge',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _enterText(tester, 'calc-input-heightCm', '170');
      await _enterText(tester, 'calc-input-weightKg', '144.5');
      await tester.pump();
      return null;
    },
  );
}

void _calcEgfrMinEdgeGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_egfr_min-edge',
    description: 'Calc egfr min edge',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _selectTool(tester, _CalcGoldenTool.egfr);
      await _enterText(tester, 'calc-input-ageYears', '120');
      await _enterText(tester, 'calc-input-serumCreatinineMgDl', '20');
      await tester.pump();
      return null;
    },
  );
}

void _calcEgfrMaxEdgeGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_egfr_max-edge',
    description: 'Calc egfr max edge',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _selectTool(tester, _CalcGoldenTool.egfr);
      await _enterText(tester, 'calc-input-ageYears', '18');
      await _enterText(tester, 'calc-input-serumCreatinineMgDl', '0.1');
      await tester.pump();
      return null;
    },
  );
}

void _calcCrclMinEdgeGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_crcl_min-edge',
    description: 'Calc crcl min edge',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _selectTool(tester, _CalcGoldenTool.crcl);
      await _enterText(tester, 'calc-input-ageYears', '120');
      await _enterText(tester, 'calc-input-weightKg', '1');
      await _enterText(tester, 'calc-input-serumCreatinineMgDl', '20');
      await tester.pump();
      return null;
    },
  );
}

void _calcCrclMaxEdgeGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_crcl_max-edge',
    description: 'Calc crcl max edge',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _selectTool(tester, _CalcGoldenTool.crcl);
      await _enterText(tester, 'calc-input-ageYears', '18');
      await _enterText(tester, 'calc-input-weightKg', '300');
      await _enterText(tester, 'calc-input-serumCreatinineMgDl', '0.1');
      await tester.pump();
      return null;
    },
  );
}

void _calcEgfrFemaleGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_egfr_female',
    description: 'Calc egfr female',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _selectTool(tester, _CalcGoldenTool.egfr);
      await tester.tap(find.text('女性'));
      await tester.pumpAndSettle();
      await _enterText(tester, 'calc-input-ageYears', '50');
      await _enterText(tester, 'calc-input-serumCreatinineMgDl', '1.0');
      await tester.pump();
      return null;
    },
  );
}

void _calcCrclFemaleGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_crcl_female',
    description: 'Calc crcl female',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _selectTool(tester, _CalcGoldenTool.crcl);
      await tester.tap(find.text('女性'));
      await tester.pumpAndSettle();
      await _enterText(tester, 'calc-input-ageYears', '50');
      await _enterText(tester, 'calc-input-weightKg', '65');
      await _enterText(tester, 'calc-input-serumCreatinineMgDl', '1.0');
      await tester.pump();
      return null;
    },
  );
}

void _calcHistoryCollapsedGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_history_collapsed',
    description: 'Calc history collapsed',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _seedBmiHistory();
      await _loadHistory(tester);
      return null;
    },
  );
}

void _calcHistoryExpandedGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_history_expanded',
    description: 'Calc history expanded',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _seedBmiHistory();
      await _loadHistory(tester);
      await tester.tap(find.text('履歴 (7)'));
      await tester.pumpAndSettle();
      return null;
    },
  );
}

void _calcHistoryEmptyGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_history_empty',
    description: 'Calc history empty',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await tester.pumpAndSettle();
      await tester.tap(find.text('履歴 (0)'));
      await tester.pumpAndSettle();
      return null;
    },
  );
}

void _calcHistoryBoundaryEmptyGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_history_boundary_empty_0',
    description: 'Calc history boundary empty 0',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _seedBmiHistory(count: 0);
      await _loadHistory(tester);
      expect(find.text('履歴 (0)'), findsOneWidget);
      expect(find.text('履歴はありません'), findsOneWidget);
      expect(_historyHeaderIcon(Symbols.history_toggle_off), findsOneWidget);

      await tester.tap(find.text('履歴 (0)'));
      await tester.pumpAndSettle();

      expect(find.text('履歴 (0)'), findsOneWidget);
      expect(find.text('履歴はありません'), findsOneWidget);
      expect(_historyHeaderIcon(Symbols.history_toggle_off), findsOneWidget);
      return null;
    },
  );
}

void _calcHistoryBoundaryGolden({
  required int count,
  required int expectedCount,
  required _CalcHistoryBoundaryMode mode,
}) {
  runGoldenMatrix(
    fileNamePrefix: 'calc_history_boundary_${mode.key}_$count',
    description: 'Calc history boundary ${mode.key} $count',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _seedBmiHistory(count: count);
      await _loadHistory(tester);
      expect(find.text('履歴 ($expectedCount)'), findsOneWidget);

      if (expectedCount == 0) {
        expect(find.text('履歴はありません'), findsOneWidget);
        return null;
      }

      if (mode == _CalcHistoryBoundaryMode.open) {
        await tester.tap(find.text('履歴 ($expectedCount)'));
        await tester.pumpAndSettle();
        expect(_richTextContaining('BMI 22.5'), findsWidgets);
      } else {
        expect(_richTextContaining('BMI 22.5'), findsNothing);
      }
      return null;
    },
  );
}

void _calcResponsiveGoldens() {
  const responsiveSizes = <String, Size>{
    'iphone_portrait': Size(390, 844),
    'iphone_landscape': Size(844, 390),
    'ipad_portrait': Size(834, 1194),
    'ipad_landscape': Size(1194, 834),
    'split_view_compact': Size(480, 900),
  };
  final cases =
      <
        ({
          String fileNamePrefix,
          String description,
          String sizeKey,
          String layoutKey,
          bool expandHistory,
        })
      >[
        (
          fileNamePrefix: 'calc_iphone_portrait',
          description: 'Calc iPhone portrait',
          sizeKey: 'iphone_portrait',
          layoutKey: 'calc-layout-compact',
          expandHistory: false,
        ),
        (
          fileNamePrefix: 'calc_iphone_landscape',
          description: 'Calc iPhone landscape',
          sizeKey: 'iphone_landscape',
          layoutKey: 'calc-layout-landscape-phone',
          expandHistory: false,
        ),
        (
          fileNamePrefix: 'calc_ipad_portrait',
          description: 'Calc iPad portrait',
          sizeKey: 'ipad_portrait',
          layoutKey: 'calc-layout-ipad-portrait',
          expandHistory: true,
        ),
        (
          fileNamePrefix: 'calc_ipad_landscape',
          description: 'Calc iPad landscape',
          sizeKey: 'ipad_landscape',
          layoutKey: 'calc-layout-ipad-landscape',
          expandHistory: true,
        ),
        (
          fileNamePrefix: 'calc_split_view_compact',
          description: 'Calc split view compact',
          sizeKey: 'split_view_compact',
          layoutKey: 'calc-layout-compact',
          expandHistory: false,
        ),
      ];

  for (final responsiveCase in cases) {
    runGoldenMatrix(
      fileNamePrefix: responsiveCase.fileNamePrefix,
      description: responsiveCase.description,
      sizes: [responsiveCase.sizeKey],
      customSizes: responsiveSizes,
      textScalers: const ['normal'],
      builder: _calcViewBuilder,
      whilePerforming: (tester) async {
        await _enterValid(tester, _CalcGoldenTool.bmi);
        await tester.pump(const Duration(milliseconds: 250));
        await clearTestAppDatabase(_db);
        await _seedBmiHistory();
        await _loadHistory(tester);
        if (responsiveCase.expandHistory) {
          await _expandHistory(tester);
        }
        await tester.pump();
        expect(
          find.byKey(ValueKey<String>(responsiveCase.layoutKey)),
          findsOneWidget,
        );
        return null;
      },
    );
  }

  runGoldenMatrix(
    fileNamePrefix: 'calc_large_text',
    description: 'Calc large text',
    sizes: const ['phone'],
    textScalers: const ['large'],
    builder: _calcViewBuilder,
    whilePerforming: (tester) async {
      await _enterValid(tester, _CalcGoldenTool.bmi);
      await tester.pump(const Duration(milliseconds: 250));
      await clearTestAppDatabase(_db);
      await _seedBmiHistory();
      await _loadHistory(tester);
      await tester.pump();
      expect(
        tester
            .getSize(
              find.byKey(const ValueKey<String>('calc-input-heightCm-box')),
            )
            .height,
        56,
      );
      return null;
    },
  );
}

Widget _calcViewBuilder(ThemeData theme, Size size, TextScaler scaler) {
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
}

Future<void> _loadHistory(WidgetTester tester) async {
  final container = ProviderScope.containerOf(
    tester.element(find.byType(CalcView)),
  );
  await container.read(calcScreenProvider.notifier).loadHistory();
  await tester.pumpAndSettle();
}

Future<void> _expandHistory(WidgetTester tester) async {
  final container = ProviderScope.containerOf(
    tester.element(find.byType(CalcView)),
  );
  container.read(calcScreenProvider.notifier).toggleHistory();
  await tester.pumpAndSettle();
}

Future<void> _seedBmiHistory({int count = 7}) async {
  final repository = CalculationHistoryRepository(_db.calculationHistoriesDao);
  final samples = <({double heightCm, double weightKg, BmiCategory category})>[
    (heightCm: 170, weightKg: 65, category: BmiCategory.normal),
    (heightCm: 172, weightKg: 72, category: BmiCategory.normal),
    (heightCm: 168, weightKg: 74, category: BmiCategory.overweight),
    (heightCm: 175, weightKg: 67, category: BmiCategory.normal),
    (heightCm: 170, weightKg: 84, category: BmiCategory.overweight),
    (heightCm: 180, weightKg: 62, category: BmiCategory.normal),
    (heightCm: 165, weightKg: 85, category: BmiCategory.obese1),
  ];

  for (var index = 0; index < count; index += 1) {
    final sample = samples[index % samples.length];
    final inputs = BmiInputs(
      heightCm: sample.heightCm,
      weightKg: sample.weightKg,
    );
    final bmi =
        sample.weightKg / ((sample.heightCm / 100) * (sample.heightCm / 100));
    final usecase = RecordCalculationHistoryUsecase(
      calculationHistoryRepository: repository,
      clock: () => DateTime.utc(2026, 5, 10 - index),
      idFactory: () => 'bmi-history-$index',
    );
    await usecase.execute(
      CalcType.bmi,
      inputs,
      BmiResult(bmi: bmi, category: sample.category),
    );
  }
}

Finder _richTextContaining(String text) {
  return find.byWidgetPredicate(
    (widget) => widget is RichText && widget.text.toPlainText().contains(text),
  );
}

Finder _historyHeaderIcon(IconData icon) {
  return find.byWidgetPredicate(
    (widget) =>
        widget is Icon &&
        widget.key == const ValueKey<String>('calc-history-header-icon') &&
        widget.icon == icon,
  );
}

Future<void> _enterOutOfRange(WidgetTester tester, _CalcGoldenTool tool) async {
  switch (tool) {
    case _CalcGoldenTool.bmi:
      await _enterText(tester, 'calc-input-heightCm', '170');
      await _enterText(tester, 'calc-input-weightKg', '400');
    case _CalcGoldenTool.egfr:
      await _enterText(tester, 'calc-input-ageYears', '50');
      await _enterText(tester, 'calc-input-serumCreatinineMgDl', '25');
    case _CalcGoldenTool.crcl:
      await _enterText(tester, 'calc-input-ageYears', '50');
      await _enterText(tester, 'calc-input-weightKg', '400');
      await _enterText(tester, 'calc-input-serumCreatinineMgDl', '1.0');
  }
}

Future<void> _enterText(
  WidgetTester tester,
  String fieldKey,
  String value,
) async {
  final finder = find.descendant(
    of: find.byKey(ValueKey<String>(fieldKey)),
    matching: find.byType(TextFormField),
  );
  await tester.enterText(finder, value);
  await tester.pump();
}

enum _CalcGoldenTool {
  bmi('bmi', 'BMI'),
  egfr('egfr', 'eGFR'),
  crcl('crcl', 'CrCl')
  ;

  const _CalcGoldenTool(this.key, this.label);

  final String key;
  final String label;
}

enum _CalcGoldenState {
  empty('empty'),
  partialInput('partial-input'),
  validInput('valid-input'),
  outOfRange('out-of-range'),
  resultWithClassification('result-with-classification')
  ;

  const _CalcGoldenState(this.key);

  final String key;
}

enum _CalcHistoryBoundaryMode {
  closed('closed'),
  open('open')
  ;

  const _CalcHistoryBoundaryMode(this.key);

  final String key;
}
