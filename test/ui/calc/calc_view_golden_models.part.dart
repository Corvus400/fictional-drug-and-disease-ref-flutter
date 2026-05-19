part of 'calc_view_golden_test.dart';

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
