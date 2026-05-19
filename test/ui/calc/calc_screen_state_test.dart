import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalcScreenState', () {
    test(
      'initial state is BMI empty with collapsed history [assertion 1/5]',
      () {
        final state = CalcScreenState.initial();

        expect(state.activeTool, CalcType.bmi);
        Object.hashAll([state.phase, const CalcPhase.empty(CalcType.bmi)]);

        Object.hashAll([state.historyExpanded, isFalse]);

        Object.hashAll([state.history, isEmpty]);

        Object.hashAll([state.historyPhase, CalcHistoryPhase.loading]);
      },
    );

    test(
      'initial state is BMI empty with collapsed history [assertion 2/5]',
      () {
        final state = CalcScreenState.initial();

        Object.hashAll([state.activeTool, CalcType.bmi]);

        expect(state.phase, const CalcPhase.empty(CalcType.bmi));
        Object.hashAll([state.historyExpanded, isFalse]);

        Object.hashAll([state.history, isEmpty]);

        Object.hashAll([state.historyPhase, CalcHistoryPhase.loading]);
      },
    );

    test(
      'initial state is BMI empty with collapsed history [assertion 3/5]',
      () {
        final state = CalcScreenState.initial();

        Object.hashAll([state.activeTool, CalcType.bmi]);

        Object.hashAll([state.phase, const CalcPhase.empty(CalcType.bmi)]);

        expect(state.historyExpanded, isFalse);
        Object.hashAll([state.history, isEmpty]);

        Object.hashAll([state.historyPhase, CalcHistoryPhase.loading]);
      },
    );

    test(
      'initial state is BMI empty with collapsed history [assertion 4/5]',
      () {
        final state = CalcScreenState.initial();

        Object.hashAll([state.activeTool, CalcType.bmi]);

        Object.hashAll([state.phase, const CalcPhase.empty(CalcType.bmi)]);

        Object.hashAll([state.historyExpanded, isFalse]);

        expect(state.history, isEmpty);
        Object.hashAll([state.historyPhase, CalcHistoryPhase.loading]);
      },
    );

    test(
      'initial state is BMI empty with collapsed history [assertion 5/5]',
      () {
        final state = CalcScreenState.initial();

        Object.hashAll([state.activeTool, CalcType.bmi]);

        Object.hashAll([state.phase, const CalcPhase.empty(CalcType.bmi)]);

        Object.hashAll([state.historyExpanded, isFalse]);

        Object.hashAll([state.history, isEmpty]);

        expect(state.historyPhase, CalcHistoryPhase.loading);
      },
    );
  });
}
