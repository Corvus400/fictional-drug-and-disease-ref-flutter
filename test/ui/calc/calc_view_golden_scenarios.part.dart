part of 'calc_view_golden_test.dart';

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

void _calcMultiErrorGoldens() {
  final cases =
      <
        ({
          _CalcGoldenTool tool,
          String key,
          Map<String, String> fields,
          List<String> errorTexts,
        })
      >[
        (
          tool: _CalcGoldenTool.bmi,
          key: 'height-weight',
          fields: {
            'calc-input-heightCm': '49.9',
            'calc-input-weightKg': '300.1',
          },
          errorTexts: ['50.0-250.0 cm', '1.0-300.0 kg'],
        ),
        (
          tool: _CalcGoldenTool.egfr,
          key: 'age-creatinine',
          fields: {
            'calc-input-ageYears': '17',
            'calc-input-serumCreatinineMgDl': '20.1',
          },
          errorTexts: ['18-120 years', '0.10-20.00 mg/dL'],
        ),
        (
          tool: _CalcGoldenTool.crcl,
          key: 'age-weight-creatinine',
          fields: {
            'calc-input-ageYears': '17',
            'calc-input-weightKg': '0.9',
            'calc-input-serumCreatinineMgDl': '20.1',
          },
          errorTexts: [
            '18-120 years',
            '1.0-300.0 kg',
            '0.10-20.00 mg/dL',
          ],
        ),
      ];

  for (final multiErrorCase in cases) {
    runGoldenMatrix(
      fileNamePrefix:
          'calc_multi_error_${multiErrorCase.tool.key}_${multiErrorCase.key}',
      description:
          'Calc multi error ${multiErrorCase.tool.key} ${multiErrorCase.key}',
      sizes: const ['phone'],
      textScalers: const ['normal'],
      builder: _calcViewBuilder,
      whilePerforming: (tester) async {
        await _selectTool(tester, multiErrorCase.tool);
        for (final entry in multiErrorCase.fields.entries) {
          await _enterText(tester, entry.key, entry.value);
        }
        for (final errorText in multiErrorCase.errorTexts) {
          expect(find.text(errorText), findsOneWidget);
        }
        return null;
      },
    );
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

void _calcHistoryRestoringGolden() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_history_restoring_after',
    description: 'Calc history restoring after',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: _calcRestoringOverlayBuilder,
  );
}

void _calcHistoryRestoringMatrixGolden() {
  const tools = _CalcGoldenTool.values;
  const devices =
      <
        ({
          String label,
          Size size,
        })
      >[
        (label: 'iPhone portrait', size: Size(390, 844)),
        (label: 'iPhone landscape', size: Size(844, 390)),
        (label: 'iPad portrait', size: Size(834, 1194)),
        (label: 'iPad landscape', size: Size(1194, 834)),
      ];
  const modes = <({String label, Brightness brightness})>[
    (label: 'light', brightness: Brightness.light),
    (label: 'dark', brightness: Brightness.dark),
  ];

  unawaited(
    goldenTest(
      'Calc history restoring 24-state matrix',
      fileName: 'calc_history_restoring_matrix',
      // ignore: avoid_redundant_argument_values, keep the golden tag explicit.
      tags: const ['golden'],
      builder: () => GoldenTestGroup(
        columns: 3,
        children: [
          for (final mode in modes)
            for (final device in devices)
              for (final tool in tools)
                GoldenTestScenario(
                  name: '${tool.key} / ${device.label} / ${mode.label}',
                  constraints: BoxConstraints.tight(device.size),
                  child: _calcRestoringMatrixCell(
                    tool: tool,
                    theme: mode.brightness == Brightness.light
                        ? AppTheme.light()
                        : AppTheme.dark(),
                    size: device.size,
                  ),
                ),
        ],
      ),
    ),
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
      expect(_historyHeaderIcon(Icons.history_toggle_off), findsOneWidget);

      await tester.tap(find.text('履歴 (0)'));
      await tester.pumpAndSettle();

      expect(find.text('履歴 (0)'), findsOneWidget);
      expect(find.text('履歴はありません'), findsOneWidget);
      expect(_historyHeaderIcon(Icons.history_toggle_off), findsOneWidget);
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
