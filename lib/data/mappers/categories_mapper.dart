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
            (entry) => TherapeuticCategoryEntry(
              id: entry.id,
              queryValue: therapeuticCategoryQueryValue(entry.id),
              label: entry.label,
            ),
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

/// Converts `/v1/categories` therapeutic category ids to drug-search query
/// values expected by `/v1/drugs?therapeutic_category=...`.
String therapeuticCategoryQueryValue(String id) {
  return switch (id) {
    'alimentary_metabolism' => 'ALIMENTARY_METABOLISM',
    'blood' => 'BLOOD_BLOOD_FORMING_ORGANS',
    'cardiovascular' => 'CARDIOVASCULAR_SYSTEM',
    'dermatologicals' => 'DERMATOLOGICAL',
    'genito_urinary_hormones' => 'GENITO_URINARY_SYSTEM_AND_SEX_HORMONES',
    'systemic_hormones' => 'SYSTEMIC_HORMONAL_PREPARATIONS',
    'antiinfectives' => 'ANTI_INFECTIVES_FOR_SYSTEMIC_USE',
    'antineoplastic_immunomodulators' => 'ANTINEOPLASTIC_IMMUNOMODULATING',
    'musculo_skeletal' => 'MUSCULO_SKELETAL_SYSTEM',
    'nervous' => 'NERVOUS_SYSTEM',
    'antiparasitic' => 'ANTIPARASITIC_PRODUCTS',
    'respiratory' => 'RESPIRATORY_SYSTEM',
    'sensory' => 'SENSORY_ORGANS',
    'various' => 'VARIOUS',
    _ => id,
  };
}
