import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_summary_dto.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

/// Drug DTO mapping helpers.
extension DrugSummaryDtoMapper on DrugSummaryDto {
  /// Maps this DTO to a domain model.
  DrugSummary toDomain() {
    return DrugSummary(
      id: id,
      brandName: brandName,
      genericName: genericName,
      therapeuticCategoryName: therapeuticCategoryName,
      regulatoryClass: regulatoryClass,
      dosageForm: dosageForm,
      brandNameKana: brandNameKana,
      atcCode: atcCode,
      revisedAt: revisedAt,
      imageUrl: imageUrl,
    );
  }
}

/// Drug list response mapping helpers.
extension DrugListResponseDtoMapper on DrugListResponseDto {
  /// Maps this DTO to a domain model.
  DrugListPage toDomain() {
    return DrugListPage(
      items: items.map((item) => item.toDomain()).toList(growable: false),
      page: page,
      pageSize: pageSize,
      totalPages: totalPages,
      totalCount: totalCount,
      disclaimer: disclaimer,
    );
  }
}

/// Drug detail mapping helpers.
extension DrugDtoMapper on DrugDto {
  /// Maps this DTO to a domain model.
  Drug toDomain() {
    return Drug(
      id: id,
      genericName: genericName,
      brandName: brandName,
      brandNameKana: brandNameKana,
      atcCode: atcCode,
      yjCode: yjCode,
      therapeuticCategoryName: therapeuticCategoryName,
      regulatoryClass: regulatoryClass,
      dosageForm: dosageForm,
      routeOfAdministration: routeOfAdministration,
      composition: composition,
      warning: warning,
      contraindications: contraindications,
      indications: indications,
      indicationsRelatedPrecautions: indicationsRelatedPrecautions,
      dosage: dosage,
      dosageRelatedPrecautions: dosageRelatedPrecautions,
      importantPrecautions: importantPrecautions,
      precautionsForSpecificPopulations: precautionsForSpecificPopulations,
      interactions: interactions,
      adverseReactions: adverseReactions,
      effectsOnLabTests: effectsOnLabTests,
      overdose: overdose,
      administrationPrecautions: administrationPrecautions,
      otherPrecautions: otherPrecautions,
      pharmacokinetics: pharmacokinetics,
      clinicalResults: clinicalResults,
      pharmacology: pharmacology,
      physicochemicalProperties: physicochemicalProperties,
      handlingPrecautions: handlingPrecautions,
      approvalConditions: approvalConditions,
      packages: packages,
      references: references,
      insuranceNotes: insuranceNotes,
      manufacturer: manufacturer,
      revisedAt: revisedAt,
      relatedDiseaseIds: relatedDiseaseIds,
      imageUrl: imageUrl,
      disclaimer: disclaimer,
    );
  }
}
