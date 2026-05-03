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
      composition: CompositionInfo(composition.toJson()),
      warning: warning.map((item) => NumberedParagraph(item.toJson())).toList(),
      contraindications: contraindications
          .map((item) => NumberedParagraph(item.toJson()))
          .toList(),
      indications: indications
          .map((item) => IndicationItem(item.toJson()))
          .toList(),
      indicationsRelatedPrecautions: indicationsRelatedPrecautions
          .map((item) => NumberedParagraph(item.toJson()))
          .toList(),
      dosage: DosageInfo(dosage.toJson()),
      dosageRelatedPrecautions: dosageRelatedPrecautions
          .map((item) => NumberedParagraph(item.toJson()))
          .toList(),
      importantPrecautions: importantPrecautions
          .map((item) => NumberedParagraph(item.toJson()))
          .toList(),
      precautionsForSpecificPopulations: precautionsForSpecificPopulations
          .map((item) => PrecautionPopulation(item.toJson()))
          .toList(),
      interactions: interactions == null
          ? null
          : InteractionInfo(interactions!.toJson()),
      adverseReactions: AdverseReactionInfo(adverseReactions.toJson()),
      effectsOnLabTests: effectsOnLabTests
          .map((item) => NumberedParagraph(item.toJson()))
          .toList(),
      overdose: overdose == null ? null : OverdoseInfo(overdose!.toJson()),
      administrationPrecautions: administrationPrecautions
          .map((item) => NumberedParagraph(item.toJson()))
          .toList(),
      otherPrecautions: otherPrecautions
          .map((item) => NumberedParagraph(item.toJson()))
          .toList(),
      pharmacokinetics: pharmacokinetics == null
          ? null
          : PharmacokineticsInfo(pharmacokinetics!.toJson()),
      clinicalResults: clinicalResults
          .map((item) => ClinicalResultSection(item.toJson()))
          .toList(),
      pharmacology: pharmacology == null
          ? null
          : PharmacologyInfo(pharmacology!.toJson()),
      physicochemicalProperties: physicochemicalProperties == null
          ? null
          : PhysicochemicalInfo(physicochemicalProperties!.toJson()),
      handlingPrecautions: handlingPrecautions
          .map((item) => NumberedParagraph(item.toJson()))
          .toList(),
      approvalConditions: approvalConditions
          .map((item) => NumberedParagraph(item.toJson()))
          .toList(),
      packages: packages.map((item) => PackageInfo(item.toJson())).toList(),
      references: references.map((item) => Reference(item.toJson())).toList(),
      insuranceNotes: insuranceNotes
          .map((item) => NumberedParagraph(item.toJson()))
          .toList(),
      manufacturer: manufacturer,
      revisedAt: revisedAt,
      relatedDiseaseIds: relatedDiseaseIds,
      imageUrl: imageUrl,
      disclaimer: disclaimer,
    );
  }
}
