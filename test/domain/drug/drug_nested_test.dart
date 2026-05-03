import 'dart:io';

import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('drug nested domain models do not keep dynamic JSON maps', () {
    final source = File('lib/domain/drug/drug_nested.dart').readAsStringSync();

    expect(source, isNot(contains('Map<String, dynamic>')));
    expect(source, isNot(contains('dynamic>')));
  });

  test('CompositionInfo exposes typed fields and serializes from them', () {
    const composition = CompositionInfo(
      activeIngredient: 'ingredient',
      activeIngredientAmount: Dose(amount: 10, unit: 'mg', per: null),
      inactiveIngredients: ['starch'],
      appearance: 'white tablet',
      identificationCode: 'A1',
    );

    expect(composition.activeIngredientAmount.unit, 'mg');
    expect(composition.toJson()['active_ingredient'], 'ingredient');
  });
}
