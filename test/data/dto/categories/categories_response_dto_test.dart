import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CategoriesResponseDto.fromJson parses Swagger sample', () {
    final fixture = File(
      'test/fixtures/swagger/get_v1_categories.json',
    ).readAsStringSync();
    final json = jsonDecode(fixture) as Map<String, dynamic>;

    final dto = CategoriesResponseDto.fromJson(json);

    expect(dto.atc.first.code, 'A');
    expect(dto.therapeuticCategories.first.id, 'alimentary_metabolism');
    expect(dto.routeOfAdministration, contains('oral'));
    expect(dto.dosageForm, contains('tablet'));
    expect(dto.regulatoryClass, contains('prescription_required'));
    expect(dto.icd10Chapters.first.roman, 'I');
    expect(dto.medicalDepartments, contains('infectious_disease'));
  });
}
