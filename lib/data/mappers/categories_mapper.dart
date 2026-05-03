import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/domain/category/categories.dart';

/// Categories mapping helpers.
extension CategoriesResponseDtoMapper on CategoriesResponseDto {
  /// Maps this DTO to a domain model.
  Categories toDomain() {
    return Categories(
      atc: atc
          .map((entry) => AtcEntry(code: entry.code, label: entry.label))
          .toList(growable: false),
      therapeuticCategories: therapeuticCategories
          .map(
            (entry) =>
                TherapeuticCategoryEntry(id: entry.id, label: entry.label),
          )
          .toList(growable: false),
      routeOfAdministration: routeOfAdministration,
      dosageForm: dosageForm,
      regulatoryClass: regulatoryClass,
      icd10Chapters: icd10Chapters
          .map(
            (entry) => Icd10ChapterEntry(
              roman: entry.roman,
              code: entry.code,
              label: entry.label,
            ),
          )
          .toList(growable: false),
      medicalDepartments: medicalDepartments,
    );
  }
}
