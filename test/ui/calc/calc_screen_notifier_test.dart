import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('CalcScreenNotifier', () {
    late AppDatabase db;
    late ProviderContainer container;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
    });

    tearDown(() async {
      await pumpEventQueue();
      container.dispose();
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test('build starts with BMI empty state and loads empty history', () async {
      final state = container.read(calcScreenProvider);

      expect(state.activeTool, CalcType.bmi);
      expect(state.phase, const CalcPhase.empty(CalcType.bmi));
      expect(state.historyExpanded, isFalse);
      expect(state.historyPhase, CalcHistoryPhase.loading);

      await pumpEventQueue();

      final loaded = container.read(calcScreenProvider);
      expect(loaded.history, isEmpty);
      expect(loaded.historyPhase, CalcHistoryPhase.empty);
    });

    test('selectTool resets phase for the selected calculation type', () async {
      final notifier = container.read(calcScreenProvider.notifier);

      await notifier.selectTool(CalcType.egfr);

      final state = container.read(calcScreenProvider);
      expect(state.activeTool, CalcType.egfr);
      expect(state.phase, const CalcPhase.empty(CalcType.egfr));
      expect(state.historyExpanded, isFalse);
      expect(state.history, isEmpty);
      expect(state.historyPhase, CalcHistoryPhase.empty);
    });

    test('updateField moves BMI from empty to partial input', () {
      container
          .read(calcScreenProvider.notifier)
          .updateField(CalcInputFieldKey.heightCm, '170');

      final state = container.read(calcScreenProvider);
      expect(
        state.phase,
        const CalcPhase.partialInput(
          CalcType.bmi,
          CalcInputDraft(values: {CalcInputFieldKey.heightCm: '170'}),
        ),
      );
    });

    test('valid BMI inputs calculate immediately and record history', () async {
      container.read(calcScreenProvider.notifier)
        ..updateField(CalcInputFieldKey.heightCm, '170')
        ..updateField(CalcInputFieldKey.weightKg, '65');

      final state = container.read(calcScreenProvider);
      final phase = state.phase as CalcPhaseResultWithClassification;
      expect(phase.calcType, CalcType.bmi);
      final result = phase.result as BmiResult;
      expect(result.bmi, closeTo(22.49, 0.01));
      expect(result.category, BmiCategory.normal);

      await Future<void>.delayed(const Duration(milliseconds: 250));
      await pumpEventQueue();

      final loaded = container.read(calcScreenProvider);
      expect(loaded.history, hasLength(1));
      expect(loaded.history.single.calcType, CalcType.bmi.storageKey);
      expect(loaded.historyPhase, CalcHistoryPhase.loaded);
    });

    test('out-of-range BMI inputs expose field errors', () {
      container.read(calcScreenProvider.notifier)
        ..updateField(CalcInputFieldKey.heightCm, '170')
        ..updateField(CalcInputFieldKey.weightKg, '400');

      final state = container.read(calcScreenProvider);
      final phase = state.phase as CalcPhaseOutOfRange;
      expect(phase.calcType, CalcType.bmi);
      expect(phase.errors, containsPair('weightKg', '1.0-300.0 kg'));
    });

    test('complete out-of-range fields expose errors immediately', () async {
      final notifier = container.read(calcScreenProvider.notifier);

      container
          .read(calcScreenProvider.notifier)
          .updateField(CalcInputFieldKey.heightCm, '9');
      var phase =
          container.read(calcScreenProvider).phase as CalcPhaseOutOfRange;
      expect(
        phase.inputs,
        const CalcInputDraft(
          values: {CalcInputFieldKey.heightCm: '9'},
        ),
      );
      expect(phase.errors, const {'heightCm': '50.0-250.0 cm'});

      await notifier.selectTool(CalcType.egfr);
      notifier.updateField(CalcInputFieldKey.ageYears, '17');
      phase = container.read(calcScreenProvider).phase as CalcPhaseOutOfRange;
      expect(
        phase.inputs,
        const CalcInputDraft(
          values: {CalcInputFieldKey.ageYears: '17'},
        ),
      );
      expect(phase.errors, const {'ageYears': '18-120 years'});

      await notifier.selectTool(CalcType.crcl);
      notifier.updateField(CalcInputFieldKey.weightKg, '0.9');
      phase = container.read(calcScreenProvider).phase as CalcPhaseOutOfRange;
      expect(
        phase.inputs,
        const CalcInputDraft(
          values: {CalcInputFieldKey.weightKg: '0.9'},
        ),
      );
      expect(phase.errors, const {'weightKg': '1.0-300.0 kg'});
    });

    test(
      'out-of-range BMI keeps previous draft when another field changes',
      () {
        final notifier = container.read(calcScreenProvider.notifier);

        for (final update in const [
          (field: CalcInputFieldKey.heightCm, value: '170'),
          (field: CalcInputFieldKey.weightKg, value: '400'),
          (field: CalcInputFieldKey.heightCm, value: '171'),
        ]) {
          notifier.updateField(update.field, update.value);
        }

        final phase =
            container.read(calcScreenProvider).phase as CalcPhaseOutOfRange;
        expect(
          phase.inputs,
          const CalcInputDraft(
            values: {
              CalcInputFieldKey.heightCm: '171',
              CalcInputFieldKey.weightKg: '400',
            },
          ),
        );
        expect(phase.errors, containsPair('weightKg', '1.0-300.0 kg'));
      },
    );

    test('out-of-range BMI exposes every field error independently', () {
      container.read(calcScreenProvider.notifier)
        ..updateField(CalcInputFieldKey.heightCm, '49.9')
        ..updateField(CalcInputFieldKey.weightKg, '300.1');

      final phase =
          container.read(calcScreenProvider).phase as CalcPhaseOutOfRange;
      expect(
        phase.errors,
        const {
          'heightCm': '50.0-250.0 cm',
          'weightKg': '1.0-300.0 kg',
        },
      );
    });

    test('valid eGFR inputs calculate with CKD stage classification', () async {
      final notifier = container.read(calcScreenProvider.notifier);
      await notifier.selectTool(CalcType.egfr);

      notifier
        ..updateField(CalcInputFieldKey.ageYears, '50')
        ..updateField(CalcInputFieldKey.serumCreatinineMgDl, '1.0');

      final state = container.read(calcScreenProvider);
      final phase = state.phase as CalcPhaseResultWithClassification;
      expect(phase.calcType, CalcType.egfr);
      final result = phase.result as EgfrResult;
      expect(result.eGfrMlMin173m2, closeTo(63.1, 0.1));
      expect(result.stage, CkdStage.g2);
      expect(phase.category, CkdStage.g2);
    });

    test('updateSex recalculates renal formulas with selected sex', () async {
      final notifier = container.read(calcScreenProvider.notifier);
      await notifier.selectTool(CalcType.egfr);
      notifier
        ..updateField(CalcInputFieldKey.ageYears, '50')
        ..updateField(CalcInputFieldKey.serumCreatinineMgDl, '1.0')
        ..updateSex(Sex.female);

      final phase =
          container.read(calcScreenProvider).phase
              as CalcPhaseResultWithClassification;
      final result = phase.result as EgfrResult;
      expect(result.eGfrMlMin173m2, closeTo(46.6, 0.1));
      expect(result.stage, CkdStage.g3a);
    });

    test('out-of-range eGFR keeps draft and sex when sex changes', () async {
      final notifier = container.read(calcScreenProvider.notifier);
      await notifier.selectTool(CalcType.egfr);

      notifier
        ..updateField(CalcInputFieldKey.ageYears, '17')
        ..updateField(CalcInputFieldKey.serumCreatinineMgDl, '1.0')
        ..updateSex(Sex.female);

      final phase =
          container.read(calcScreenProvider).phase as CalcPhaseOutOfRange;
      expect(
        phase.inputs,
        const CalcInputDraft(
          values: {
            CalcInputFieldKey.ageYears: '17',
            CalcInputFieldKey.serumCreatinineMgDl: '1.0',
          },
          sex: Sex.female,
        ),
      );
      expect(phase.errors, containsPair('ageYears', '18-120 years'));
    });

    test('out-of-range eGFR exposes every field error independently', () async {
      final notifier = container.read(calcScreenProvider.notifier);
      await notifier.selectTool(CalcType.egfr);

      notifier
        ..updateField(CalcInputFieldKey.ageYears, '17')
        ..updateField(CalcInputFieldKey.serumCreatinineMgDl, '20.1');

      final phase =
          container.read(calcScreenProvider).phase as CalcPhaseOutOfRange;
      expect(
        phase.errors,
        const {
          'ageYears': '18-120 years',
          'serumCreatinineMgDl': '0.10-20.00 mg/dL',
        },
      );
    });

    test('valid CrCl inputs calculate without classification', () async {
      final notifier = container.read(calcScreenProvider.notifier);
      await notifier.selectTool(CalcType.crcl);

      notifier
        ..updateField(CalcInputFieldKey.ageYears, '50')
        ..updateField(CalcInputFieldKey.weightKg, '65')
        ..updateField(CalcInputFieldKey.serumCreatinineMgDl, '1.0');

      final state = container.read(calcScreenProvider);
      final phase = state.phase as CalcPhaseValidInput;
      expect(phase.calcType, CalcType.crcl);
      final result = phase.result as CrClResult;
      expect(result.crClMlMin, closeTo(81.25, 0.01));
    });

    test('female CrCl inputs apply sex coefficient', () async {
      final notifier = container.read(calcScreenProvider.notifier);
      await notifier.selectTool(CalcType.crcl);

      notifier
        ..updateField(CalcInputFieldKey.ageYears, '50')
        ..updateField(CalcInputFieldKey.weightKg, '65')
        ..updateField(CalcInputFieldKey.serumCreatinineMgDl, '1.0')
        ..updateSex(Sex.female);

      final state = container.read(calcScreenProvider);
      final phase = state.phase as CalcPhaseValidInput;
      expect(phase.calcType, CalcType.crcl);
      final result = phase.result as CrClResult;
      expect(result.crClMlMin, closeTo(69.1, 0.1));
    });

    test(
      'out-of-range CrCl keeps other fields when edited to partial input',
      () async {
        final notifier = container.read(calcScreenProvider.notifier);
        await notifier.selectTool(CalcType.crcl);

        notifier
          ..updateField(CalcInputFieldKey.ageYears, '1')
          ..updateField(CalcInputFieldKey.weightKg, '1')
          ..updateField(CalcInputFieldKey.serumCreatinineMgDl, '1')
          ..updateField(CalcInputFieldKey.ageYears, '-');

        final phase =
            container.read(calcScreenProvider).phase as CalcPhasePartialInput;
        expect(
          phase.partialInputs,
          const CalcInputDraft(
            values: {
              CalcInputFieldKey.ageYears: '-',
              CalcInputFieldKey.weightKg: '1',
              CalcInputFieldKey.serumCreatinineMgDl: '1',
            },
          ),
        );
      },
    );

    test('out-of-range CrCl exposes every field error independently', () async {
      final notifier = container.read(calcScreenProvider.notifier);
      await notifier.selectTool(CalcType.crcl);

      notifier
        ..updateField(CalcInputFieldKey.ageYears, '17')
        ..updateField(CalcInputFieldKey.weightKg, '0.9')
        ..updateField(CalcInputFieldKey.serumCreatinineMgDl, '20.1');

      final phase =
          container.read(calcScreenProvider).phase as CalcPhaseOutOfRange;
      expect(
        phase.errors,
        const {
          'ageYears': '18-120 years',
          'weightKg': '1.0-300.0 kg',
          'serumCreatinineMgDl': '0.10-20.00 mg/dL',
        },
      );
    });

    test('restoreFromHistory restores typed BMI inputs and result', () async {
      final notifier = container.read(calcScreenProvider.notifier);
      container.read(calcScreenProvider.notifier)
        ..updateField(CalcInputFieldKey.heightCm, '170')
        ..updateField(CalcInputFieldKey.weightKg, '65');
      await Future<void>.delayed(const Duration(milliseconds: 250));
      await pumpEventQueue();
      final entry = container.read(calcScreenProvider).history.single;

      await notifier.selectTool(CalcType.crcl);
      notifier.restoreFromHistory(entry);

      final state = container.read(calcScreenProvider);
      final phase = state.phase as CalcPhaseResultWithClassification;
      expect(state.activeTool, CalcType.bmi);
      expect(phase.calcType, CalcType.bmi);
      expect(phase.inputs, const BmiInputs(heightCm: 170, weightKg: 65));
      expect((phase.result as BmiResult).category, BmiCategory.normal);
    });

    test('deleteHistory removes a row and reloads empty history', () async {
      final notifier = container.read(calcScreenProvider.notifier);
      container.read(calcScreenProvider.notifier)
        ..updateField(CalcInputFieldKey.heightCm, '170')
        ..updateField(CalcInputFieldKey.weightKg, '65');
      await Future<void>.delayed(const Duration(milliseconds: 250));
      await pumpEventQueue();
      final entry = container.read(calcScreenProvider).history.single;

      await notifier.deleteHistory(entry.id);

      final state = container.read(calcScreenProvider);
      expect(state.history, isEmpty);
      expect(state.historyPhase, CalcHistoryPhase.empty);
    });
  });
}
