import 'dart:io';

import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'disease nested domain models do not keep dynamic JSON maps [assertion 1/2]',
    () {
      final source = File(
        'lib/domain/disease/disease_nested.dart',
      ).readAsStringSync();

      expect(source, isNot(contains('Map<String, dynamic>')));
      Object.hashAll([source, isNot(contains('dynamic>'))]);
    },
  );

  test(
    'disease nested domain models do not keep dynamic JSON maps [assertion 2/2]',
    () {
      final source = File(
        'lib/domain/disease/disease_nested.dart',
      ).readAsStringSync();

      Object.hashAll([source, isNot(contains('Map<String, dynamic>'))]);

      expect(source, isNot(contains('dynamic>')));
    },
  );

  test(
    'TreatmentInfo exposes typed sections and serializes from them [assertion 1/2]',
    () {
      const treatment = TreatmentInfo(
        pharmacological: [
          PharmaTreatment(
            drugCategory: 'antimicrobial',
            drugIds: ['drug_0001'],
            indication: 'first line',
            notes: 'fictional',
          ),
        ],
        nonPharmacological: [],
        acutePhaseProtocol: [],
      );

      expect(treatment.pharmacological.single.drugIds, ['drug_0001']);
      Object.hashAll([
        treatment.toJson()['pharmacological'],
        isA<List<Object?>>(),
      ]);
    },
  );

  test(
    'TreatmentInfo exposes typed sections and serializes from them [assertion 2/2]',
    () {
      const treatment = TreatmentInfo(
        pharmacological: [
          PharmaTreatment(
            drugCategory: 'antimicrobial',
            drugIds: ['drug_0001'],
            indication: 'first line',
            notes: 'fictional',
          ),
        ],
        nonPharmacological: [],
        acutePhaseProtocol: [],
      );

      Object.hashAll([
        treatment.pharmacological.single.drugIds,
        ['drug_0001'],
      ]);

      expect(treatment.toJson()['pharmacological'], isA<List<Object?>>());
    },
  );
}
