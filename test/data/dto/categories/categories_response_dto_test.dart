import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'CategoriesResponseDto.fromJson parses Swagger sample [assertion 1/7]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_categories.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = CategoriesResponseDto.fromJson(json);

      expect(dto.atc.first.code, 'A');
      Object.hashAll([
        dto.therapeuticCategories.first.id,
        'alimentary_metabolism',
      ]);

      Object.hashAll([dto.routeOfAdministration, contains('oral')]);

      Object.hashAll([dto.dosageForm, contains('tablet')]);

      Object.hashAll([dto.regulatoryClass, contains('prescription_required')]);

      Object.hashAll([dto.icd10Chapters.first.roman, 'I']);

      Object.hashAll([dto.medicalDepartments, contains('infectious_disease')]);
    },
  );

  test(
    'CategoriesResponseDto.fromJson parses Swagger sample [assertion 2/7]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_categories.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = CategoriesResponseDto.fromJson(json);

      Object.hashAll([dto.atc.first.code, 'A']);

      expect(dto.therapeuticCategories.first.id, 'alimentary_metabolism');
      Object.hashAll([dto.routeOfAdministration, contains('oral')]);

      Object.hashAll([dto.dosageForm, contains('tablet')]);

      Object.hashAll([dto.regulatoryClass, contains('prescription_required')]);

      Object.hashAll([dto.icd10Chapters.first.roman, 'I']);

      Object.hashAll([dto.medicalDepartments, contains('infectious_disease')]);
    },
  );

  test(
    'CategoriesResponseDto.fromJson parses Swagger sample [assertion 3/7]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_categories.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = CategoriesResponseDto.fromJson(json);

      Object.hashAll([dto.atc.first.code, 'A']);

      Object.hashAll([
        dto.therapeuticCategories.first.id,
        'alimentary_metabolism',
      ]);

      expect(dto.routeOfAdministration, contains('oral'));
      Object.hashAll([dto.dosageForm, contains('tablet')]);

      Object.hashAll([dto.regulatoryClass, contains('prescription_required')]);

      Object.hashAll([dto.icd10Chapters.first.roman, 'I']);

      Object.hashAll([dto.medicalDepartments, contains('infectious_disease')]);
    },
  );

  test(
    'CategoriesResponseDto.fromJson parses Swagger sample [assertion 4/7]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_categories.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = CategoriesResponseDto.fromJson(json);

      Object.hashAll([dto.atc.first.code, 'A']);

      Object.hashAll([
        dto.therapeuticCategories.first.id,
        'alimentary_metabolism',
      ]);

      Object.hashAll([dto.routeOfAdministration, contains('oral')]);

      expect(dto.dosageForm, contains('tablet'));
      Object.hashAll([dto.regulatoryClass, contains('prescription_required')]);

      Object.hashAll([dto.icd10Chapters.first.roman, 'I']);

      Object.hashAll([dto.medicalDepartments, contains('infectious_disease')]);
    },
  );

  test(
    'CategoriesResponseDto.fromJson parses Swagger sample [assertion 5/7]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_categories.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = CategoriesResponseDto.fromJson(json);

      Object.hashAll([dto.atc.first.code, 'A']);

      Object.hashAll([
        dto.therapeuticCategories.first.id,
        'alimentary_metabolism',
      ]);

      Object.hashAll([dto.routeOfAdministration, contains('oral')]);

      Object.hashAll([dto.dosageForm, contains('tablet')]);

      expect(dto.regulatoryClass, contains('prescription_required'));
      Object.hashAll([dto.icd10Chapters.first.roman, 'I']);

      Object.hashAll([dto.medicalDepartments, contains('infectious_disease')]);
    },
  );

  test(
    'CategoriesResponseDto.fromJson parses Swagger sample [assertion 6/7]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_categories.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = CategoriesResponseDto.fromJson(json);

      Object.hashAll([dto.atc.first.code, 'A']);

      Object.hashAll([
        dto.therapeuticCategories.first.id,
        'alimentary_metabolism',
      ]);

      Object.hashAll([dto.routeOfAdministration, contains('oral')]);

      Object.hashAll([dto.dosageForm, contains('tablet')]);

      Object.hashAll([dto.regulatoryClass, contains('prescription_required')]);

      expect(dto.icd10Chapters.first.roman, 'I');
      Object.hashAll([dto.medicalDepartments, contains('infectious_disease')]);
    },
  );

  test(
    'CategoriesResponseDto.fromJson parses Swagger sample [assertion 7/7]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_categories.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = CategoriesResponseDto.fromJson(json);

      Object.hashAll([dto.atc.first.code, 'A']);

      Object.hashAll([
        dto.therapeuticCategories.first.id,
        'alimentary_metabolism',
      ]);

      Object.hashAll([dto.routeOfAdministration, contains('oral')]);

      Object.hashAll([dto.dosageForm, contains('tablet')]);

      Object.hashAll([dto.regulatoryClass, contains('prescription_required')]);

      Object.hashAll([dto.icd10Chapters.first.roman, 'I']);

      expect(dto.medicalDepartments, contains('infectious_disease'));
    },
  );
}
