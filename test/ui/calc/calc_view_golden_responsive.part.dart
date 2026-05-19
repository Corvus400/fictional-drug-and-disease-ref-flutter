part of 'calc_view_golden_test.dart';

void _calcResponsiveGoldens() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_responsive',
    description: 'Calc responsive layout',
    builder: (theme, size, scaler) {
      return _calcResponsiveMatrixCell(
        theme: theme,
        size: size,
        expandHistory: size.shortestSide >= 600,
      );
    },
  );
}

Widget _calcResponsiveMatrixCell({
  required ThemeData theme,
  required Size size,
  required bool expandHistory,
}) {
  final state = _calcResponsiveMatrixState(expandHistory: expandHistory);

  return MediaQuery(
    data: MediaQueryData(
      size: size,
      devicePixelRatio: GoldenMatrix.devicePixelRatio,
      textScaler: TextScaler.noScaling,
    ),
    child: SizedBox(
      width: size.width,
      height: size.height,
      child: ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          calcScreenProvider.overrideWithBuild((ref, notifier) => state),
        ],
        child: MaterialApp(
          theme: theme,
          darkTheme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const CalcView(),
        ),
      ),
    ),
  );
}

CalcScreenState _calcResponsiveMatrixState({required bool expandHistory}) {
  const inputs = BmiInputs(heightCm: 170, weightKg: 65);
  final result = BmiResult(
    bmi: inputs.weightKg / ((inputs.heightCm / 100) * (inputs.heightCm / 100)),
    category: BmiCategory.normal,
  );

  return CalcScreenState(
    activeTool: CalcType.bmi,
    phase: CalcPhase.resultWithClassification(
      CalcType.bmi,
      inputs,
      result,
      result.category,
    ),
    historyExpanded: expandHistory,
    history: _matrixBmiHistory(),
    historyPhase: CalcHistoryPhase.loaded,
  );
}

List<CalculationHistoryEntry> _matrixBmiHistory() {
  const inputsCodec = CalculationInputsCodec();
  const resultCodec = CalculationResultCodec();
  final samples = <({double heightCm, double weightKg, BmiCategory category})>[
    (heightCm: 170, weightKg: 65, category: BmiCategory.normal),
    (heightCm: 172, weightKg: 72, category: BmiCategory.normal),
    (heightCm: 168, weightKg: 74, category: BmiCategory.overweight),
    (heightCm: 175, weightKg: 67, category: BmiCategory.normal),
    (heightCm: 170, weightKg: 84, category: BmiCategory.overweight),
    (heightCm: 180, weightKg: 62, category: BmiCategory.normal),
    (heightCm: 165, weightKg: 85, category: BmiCategory.obese1),
  ];

  return [
    for (var index = 0; index < samples.length; index += 1)
      () {
        final sample = samples[index];
        final inputs = BmiInputs(
          heightCm: sample.heightCm,
          weightKg: sample.weightKg,
        );
        final result = BmiResult(
          bmi:
              sample.weightKg /
              ((sample.heightCm / 100) * (sample.heightCm / 100)),
          category: sample.category,
        );
        return CalculationHistoryEntry(
          id: 'matrix-bmi-history-$index',
          calcType: CalcType.bmi.storageKey,
          inputsJson: inputsCodec.encode(inputs),
          resultJson: resultCodec.encode(result),
          calculatedAt: DateTime.utc(2026, 5, 10 - index),
        );
      }(),
  ];
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

Widget _calcIosViewBuilder(ThemeData theme, Size size, TextScaler scaler) {
  final iosTheme = theme.copyWith(platform: TargetPlatform.iOS);
  return ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(_db)],
    child: MaterialApp(
      theme: iosTheme,
      darkTheme: iosTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CalcView(),
    ),
  );
}

Widget _calcRestoringOverlayBuilder(
  ThemeData theme,
  Size size,
  TextScaler scaler,
) {
  return MediaQuery(
    data: MediaQueryData(
      size: size,
      devicePixelRatio: GoldenMatrix.devicePixelRatio,
      textScaler: scaler,
    ),
    child: SizedBox(
      width: size.width,
      height: size.height,
      child: ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          calcScreenProvider.overrideWithBuild(
            (ref, notifier) => _calcResponsiveMatrixState(
              expandHistory: true,
            ),
          ),
        ],
        child: MaterialApp(
          theme: theme,
          darkTheme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TickerMode(
            enabled: false,
            child: CalcView(
              debugRestoringHistory: true,
              debugRestoringProgressValue: 0.65,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _calcRestoringMatrixCell({
  required _CalcGoldenTool tool,
  required ThemeData theme,
  required Size size,
}) {
  return MediaQuery(
    data: MediaQueryData(
      size: size,
      devicePixelRatio: GoldenMatrix.devicePixelRatio,
      textScaler: TextScaler.noScaling,
    ),
    child: SizedBox(
      width: size.width,
      height: size.height,
      child: ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          calcScreenProvider.overrideWithBuild(
            (ref, notifier) => _calcRestoringState(tool),
          ),
        ],
        child: MaterialApp(
          theme: theme,
          darkTheme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TickerMode(
            enabled: false,
            child: CalcView(
              debugRestoringHistory: true,
              debugRestoringProgressValue: 0.65,
            ),
          ),
        ),
      ),
    ),
  );
}

CalcScreenState _calcRestoringState(_CalcGoldenTool tool) {
  return switch (tool) {
    _CalcGoldenTool.bmi => _calcResponsiveMatrixState(expandHistory: false),
    _CalcGoldenTool.egfr => _egfrRestoringState(),
    _CalcGoldenTool.crcl => _crclRestoringState(),
  };
}

CalcScreenState _egfrRestoringState() {
  const inputs = EgfrInputs(
    ageYears: 50,
    sex: Sex.male,
    serumCreatinineMgDl: 1,
  );
  const result = EgfrResult(eGfrMlMin173m2: 63.1, stage: CkdStage.g2);
  return CalcScreenState(
    activeTool: CalcType.egfr,
    phase: CalcPhase.resultWithClassification(
      CalcType.egfr,
      inputs,
      result,
      result.stage,
    ),
    historyExpanded: false,
    history: _matrixBmiHistory(),
    historyPhase: CalcHistoryPhase.loaded,
  );
}

CalcScreenState _crclRestoringState() {
  const inputs = CrClInputs(
    ageYears: 50,
    sex: Sex.male,
    weightKg: 65,
    serumCreatinineMgDl: 1,
  );
  const result = CrClResult(crClMlMin: 81.3);
  return CalcScreenState(
    activeTool: CalcType.crcl,
    phase: const CalcPhase.validInput(
      CalcType.crcl,
      inputs,
      result,
    ),
    historyExpanded: false,
    history: _matrixBmiHistory(),
    historyPhase: CalcHistoryPhase.loaded,
  );
}

Future<void> _loadHistory(WidgetTester tester) async {
  final container = ProviderScope.containerOf(
    tester.element(find.byType(CalcView)),
  );
  await container.read(calcScreenProvider.notifier).loadHistory();
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
