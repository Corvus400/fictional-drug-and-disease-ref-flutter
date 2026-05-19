import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'DiseaseListResponseDto.fromJson parses Swagger sample [assertion 1/5]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseListResponseDto.fromJson(json);

      expect(dto.items, isNotEmpty);
      Object.hashAll([dto.page, 1]);

      Object.hashAll([dto.pageSize, 20]);

      Object.hashAll([dto.totalCount, 80]);

      Object.hashAll([dto.disclaimer, isNotEmpty]);
    },
  );

  test(
    'DiseaseListResponseDto.fromJson parses Swagger sample [assertion 2/5]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseListResponseDto.fromJson(json);

      Object.hashAll([dto.items, isNotEmpty]);

      expect(dto.page, 1);
      Object.hashAll([dto.pageSize, 20]);

      Object.hashAll([dto.totalCount, 80]);

      Object.hashAll([dto.disclaimer, isNotEmpty]);
    },
  );

  test(
    'DiseaseListResponseDto.fromJson parses Swagger sample [assertion 3/5]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseListResponseDto.fromJson(json);

      Object.hashAll([dto.items, isNotEmpty]);

      Object.hashAll([dto.page, 1]);

      expect(dto.pageSize, 20);
      Object.hashAll([dto.totalCount, 80]);

      Object.hashAll([dto.disclaimer, isNotEmpty]);
    },
  );

  test(
    'DiseaseListResponseDto.fromJson parses Swagger sample [assertion 4/5]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseListResponseDto.fromJson(json);

      Object.hashAll([dto.items, isNotEmpty]);

      Object.hashAll([dto.page, 1]);

      Object.hashAll([dto.pageSize, 20]);

      expect(dto.totalCount, 80);
      Object.hashAll([dto.disclaimer, isNotEmpty]);
    },
  );

  test(
    'DiseaseListResponseDto.fromJson parses Swagger sample [assertion 5/5]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseListResponseDto.fromJson(json);

      Object.hashAll([dto.items, isNotEmpty]);

      Object.hashAll([dto.page, 1]);

      Object.hashAll([dto.pageSize, 20]);

      Object.hashAll([dto.totalCount, 80]);

      expect(dto.disclaimer, isNotEmpty);
    },
  );
}
