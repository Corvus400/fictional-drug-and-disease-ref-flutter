import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DiseaseListResponseDto.fromJson parses Swagger sample', () {
    final fixture = File(
      'test/fixtures/swagger/get_v1_diseases.json',
    ).readAsStringSync();
    final json = jsonDecode(fixture) as Map<String, dynamic>;

    final dto = DiseaseListResponseDto.fromJson(json);

    expect(dto.items, isNotEmpty);
    expect(dto.page, 1);
    expect(dto.pageSize, 20);
    expect(dto.totalCount, 80);
    expect(dto.disclaimer, isNotEmpty);
  });
}
