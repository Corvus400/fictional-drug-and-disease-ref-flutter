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
    expect(categories.routeOfAdministration, ['oral']);
    expect(categories.dosageForm, ['tablet']);
    expect(categories.regulatoryClass, ['ordinary']);
    expect(categories.icd10Chapters.single.roman, 'I');
    expect(categories.medicalDepartments, ['infectious_disease']);
  });
}
