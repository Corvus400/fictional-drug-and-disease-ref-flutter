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
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../helpers/test_app_database.dart';

part 'calc_view_input_keyboard_test.part.dart';

part 'calc_view_results_partial_test.part.dart';

part 'calc_view_validation_responsive_test.part.dart';

part 'calc_view_history_test.part.dart';

late AppDatabase db;

void main() {
  group('CalcView', () {
    setUpAll(() {
      db = createTestAppDatabase();
    });

    _calcViewInputKeyboardTests();
    _calcViewResultsPartialTests();
    _calcViewValidationResponsiveTests();
    _calcViewHistoryTests();

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });
  });
}

Finder _inputField(String key) {
  return find.descendant(
    of: find.byKey(ValueKey<String>(key)),
    matching: find.byType(TextFormField),
  );
}

String _inputText(WidgetTester tester, String key) {
  return tester.widget<TextFormField>(_inputField(key)).controller!.text;
}

EditableText _editableText(WidgetTester tester, String key) {
  return tester.widget<EditableText>(
    find.descendant(
      of: find.byKey(ValueKey<String>(key)),
      matching: find.byType(EditableText),
    ),
  );
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

BorderRadius _borderRadiusAt(WidgetTester tester, Finder finder, int index) {
  return tester.widget<ClipRRect>(finder.at(index)).borderRadius
      as BorderRadius;
}

double _deleteRevealWidthAt(WidgetTester tester, int index) {
  return tester
      .getSize(
        find.byKey(const ValueKey<String>('history-delete-reveal')).at(index),
      )
      .width;
}

CalcScreenState _historyStateForRows(int count) {
  return CalcScreenState.initial().copyWith(
    historyExpanded: true,
    historyPhase: CalcHistoryPhase.loaded,
    history: List<CalculationHistoryEntry>.generate(count, _bmiHistoryEntry),
  );
}

CalculationHistoryEntry _bmiHistoryEntry(int index) {
  const inputsCodec = CalculationInputsCodec();
  const resultCodec = CalculationResultCodec();
  final inputs = BmiInputs(
    heightCm: 170.0 + index,
    weightKg: 65.0 + index,
  );
  final result = Bmi.calculate(inputs);

  return CalculationHistoryEntry(
    id: 'history-radius-$index',
    calcType: CalcType.bmi.storageKey,
    inputsJson: inputsCodec.encode(inputs),
    resultJson: resultCodec.encode(result),
    calculatedAt: DateTime.utc(2026, 5, 10 - index),
  );
}

Future<void> _seedBmiHistory(AppDatabase db, {required int count}) async {
  final repository = CalculationHistoryRepository(db.calculationHistoriesDao);
  final samples = <({double heightCm, double weightKg, BmiCategory category})>[
    (heightCm: 170, weightKg: 65, category: BmiCategory.normal),
    (heightCm: 172, weightKg: 72, category: BmiCategory.normal),
    (heightCm: 168, weightKg: 74, category: BmiCategory.overweight),
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

Future<void> _tapSex(WidgetTester tester, String label) async {
  final finder = find.text(label);
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Widget _testApp(
  AppDatabase db, {
  TextScaler? textScaler,
  TargetPlatform? platform,
  CalcScreenState? calcState,
  Widget home = const CalcView(),
}) {
  final theme = AppTheme.light();
  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
      if (calcState != null)
        calcScreenProvider.overrideWithBuild((ref, notifier) => calcState),
    ],
    child: MaterialApp(
      theme: platform == null ? theme : theme.copyWith(platform: platform),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: textScaler == null
          ? null
          : (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: textScaler),
              child: child!,
            ),
      home: home,
    ),
  );
}

CalcScreenState _restoringState(CalcType tool) {
  return switch (tool) {
    CalcType.bmi => _bmiRestoringState(),
    CalcType.egfr => _egfrRestoringState(),
    CalcType.crcl => _crclRestoringState(),
  };
}

CalcScreenState _bmiRestoringState() {
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
    historyExpanded: false,
    history: const [],
    historyPhase: CalcHistoryPhase.loaded,
  );
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
    history: const [],
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
  return const CalcScreenState(
    activeTool: CalcType.crcl,
    phase: CalcPhase.validInput(CalcType.crcl, inputs, result),
    historyExpanded: false,
    history: [],
    historyPhase: CalcHistoryPhase.loaded,
  );
}
