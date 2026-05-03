import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DiseaseDto with nested epidemiology roundtrips correctly', () {
    final fixture = File(
      'test/fixtures/swagger/get_v1_diseases__id_.json',
    ).readAsStringSync();
    final json = jsonDecode(fixture) as Map<String, dynamic>;

    final dto = DiseaseDto.fromJson(json);

    expect(dto.id, 'disease_0079');
    expect(dto.epidemiology, isNotNull);
    expect(dto.severityGrading, isNotNull);
    expect(dto.toJson(), json);
  });
}
