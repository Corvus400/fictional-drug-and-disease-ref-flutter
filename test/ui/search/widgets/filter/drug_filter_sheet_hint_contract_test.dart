import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('drug filter hint and toggle contract', () {
    final source = File(
      'lib/ui/search/widgets/filter/drug_filter_sheet.dart',
    ).readAsStringSync();

    test('multi-value axes use multi hints and additive toggle', () {
      for (final axis in const [
        'regulatory_class',
        'dosage_form',
        'route',
        'precaution_category',
      ]) {
        final block = _axisBlock(source, axis);

        expect(
          block,
          contains('searchFilterHintMultiValue'),
          reason: '$axis must label itself as a multi-select axis.',
        );
        expect(
          block,
          contains('_toggle('),
          reason: '$axis must preserve additive multi-select behavior.',
        );
        expect(
          block,
          isNot(contains('_toggleSingle(')),
          reason: '$axis must not clear previous selections on tap.',
        );
      }
    });

    test('single-value axes use single-value behavior labels', () {
      final atc = _axisBlock(source, 'atc');
      expect(atc, contains('searchFilterHintSingleValue'));
      expect(atc, contains('_toggleSingle(_categoryAtc, value)'));
      expect(atc, isNot(contains('searchFilterHintMultiValue')));

      final therapeuticCategory = _axisBlock(
        source,
        'therapeutic_category',
      );
      expect(therapeuticCategory, contains('searchFilterHintHierarchy'));
      expect(
        therapeuticCategory,
        contains('_toggleSingle(_therapeuticCategory, value)'),
      );
      expect(
        therapeuticCategory,
        isNot(contains('searchFilterHintMultiValue')),
      );
    });

    test('text keyword axis does not advertise chip selection behavior', () {
      final adverseReaction = _axisBlock(source, 'adverse_reaction');

      expect(adverseReaction, contains('searchFilterHintPartialMatch'));
      expect(adverseReaction, isNot(contains('_toggle(')));
      expect(adverseReaction, isNot(contains('_toggleSingle(')));
    });
  });
}

String _axisBlock(String source, String axisId) {
  final idPattern = "id: '$axisId',";
  final idStart = source.indexOf(idPattern);
  expect(idStart, isNot(-1), reason: 'Axis $axisId must exist.');

  final nextAxisStart = source.indexOf(
    "_FilterAxis(\n              id: '",
    idStart + idPattern.length,
  );
  final axesEnd = source.indexOf('          ];', idStart);
  final blockEnd = nextAxisStart == -1 ? axesEnd : nextAxisStart;
  return source.substring(idStart, blockEnd);
}
