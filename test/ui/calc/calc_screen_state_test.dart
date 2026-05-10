import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalcScreenState', () {
    test('initial state is BMI empty with collapsed history', () {
      final state = CalcScreenState.initial();

      expect(state.activeTool, CalcType.bmi);
      expect(state.phase, const CalcPhase.empty(CalcType.bmi));
      expect(state.historyExpanded, isFalse);
      expect(state.history, isEmpty);
      expect(state.historyPhase, CalcHistoryPhase.loading);
    });
  });
}
