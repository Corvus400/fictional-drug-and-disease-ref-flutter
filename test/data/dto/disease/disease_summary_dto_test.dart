import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_summary_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DiseaseSummaryDto.fromJson parses Swagger sample item[0]', () {
    final fixture = File(
      'test/fixtures/swagger/get_v1_diseases.json',
    ).readAsStringSync();
    final json = jsonDecode(fixture) as Map<String, dynamic>;
    final item = (json['items'] as List<dynamic>).first as Map<String, dynamic>;

    final dto = DiseaseSummaryDto.fromJson(item);

    expect(dto.id, 'disease_0000');
    expect(dto.name, 'ヒソネナ');
    expect(dto.icd10Chapter, 'chapter_i');
    expect(dto.medicalDepartment, ['infectious_disease', 'emergency']);
    expect(dto.infectious, isTrue);
  });
}
