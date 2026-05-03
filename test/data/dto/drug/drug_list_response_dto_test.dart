import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DrugListResponseDto.fromJson parses Swagger sample', () {
    final fixture = File(
      'test/fixtures/swagger/get_v1_drugs.json',
    ).readAsStringSync();
    final json = jsonDecode(fixture) as Map<String, dynamic>;

    final dto = DrugListResponseDto.fromJson(json);

    expect(dto.items, isNotEmpty);
    expect(dto.page, 1);
    expect(dto.pageSize, 20);
    expect(dto.totalCount, 120);
    expect(dto.disclaimer, isNotEmpty);
  });
}
