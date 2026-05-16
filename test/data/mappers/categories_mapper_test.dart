import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/categories_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toDomain maps CategoriesResponseDto fields', () {
    const dto = CategoriesResponseDto(
      atc: [AtcEntryDto(code: 'A', label: '消化器系')],
      therapeuticCategories: [
        TherapeuticCategoryEntryDto(
          id: 'alimentary_metabolism',
          label: '消化器系',
        ),
      ],
      routeOfAdministration: ['oral'],
      dosageForm: ['tablet'],
      regulatoryClass: ['ordinary'],
      icd10Chapters: [
        Icd10ChapterEntryDto(
          roman: 'I',
          code: 'A00-B99',
          label: '感染症',
        ),
      ],
      medicalDepartments: ['infectious_disease'],
    );

    final categories = dto.toDomain();

    expect(categories.atc.single.code, 'A');
    expect(categories.therapeuticCategories.single.id, 'alimentary_metabolism');
    expect(
      categories.therapeuticCategories.single.queryValue,
      'ALIMENTARY_METABOLISM',
    );
    expect(categories.routeOfAdministration, ['oral']);
    expect(categories.dosageForm, ['tablet']);
    expect(categories.regulatoryClass, ['ordinary']);
    expect(categories.icd10Chapters.single.roman, 'I');
    expect(categories.medicalDepartments, ['infectious_disease']);
  });

  test('toDomain maps all therapeutic category ids to search query values', () {
    final fixture = File(
      'test/fixtures/swagger/get_v1_categories.json',
    ).readAsStringSync();
    final json = jsonDecode(fixture) as Map<String, dynamic>;
    final categories = CategoriesResponseDto.fromJson(json).toDomain();

    expect(
      {
        for (final entry in categories.therapeuticCategories)
          entry.id: entry.queryValue,
      },
      {
        'alimentary_metabolism': 'ALIMENTARY_METABOLISM',
        'blood': 'BLOOD_BLOOD_FORMING_ORGANS',
        'cardiovascular': 'CARDIOVASCULAR_SYSTEM',
        'dermatologicals': 'DERMATOLOGICAL',
        'genito_urinary_hormones': 'GENITO_URINARY_SYSTEM_AND_SEX_HORMONES',
        'systemic_hormones': 'SYSTEMIC_HORMONAL_PREPARATIONS',
        'antiinfectives': 'ANTI_INFECTIVES_FOR_SYSTEMIC_USE',
        'antineoplastic_immunomodulators': 'ANTINEOPLASTIC_IMMUNOMODULATING',
        'musculo_skeletal': 'MUSCULO_SKELETAL_SYSTEM',
        'nervous': 'NERVOUS_SYSTEM',
        'antiparasitic': 'ANTIPARASITIC_PRODUCTS',
        'respiratory': 'RESPIRATORY_SYSTEM',
        'sensory': 'SENSORY_ORGANS',
        'various': 'VARIOUS',
      },
    );
  });
}
