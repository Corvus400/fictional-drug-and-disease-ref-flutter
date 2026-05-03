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
      composition: composition.toDomain(),
      warning: warning.map((item) => item.toDomain()).toList(growable: false),
      contraindications: contraindications
          .map((item) => item.toDomain())
          .toList(growable: false),
      indications: indications
          .map((item) => item.toDomain())
          .toList(growable: false),
      indicationsRelatedPrecautions: indicationsRelatedPrecautions
          .map((item) => item.toDomain())
          .toList(growable: false),
      dosage: dosage.toDomain(),
      dosageRelatedPrecautions: dosageRelatedPrecautions
          .map((item) => item.toDomain())
          .toList(growable: false),
      importantPrecautions: importantPrecautions
          .map((item) => item.toDomain())
          .toList(growable: false),
      precautionsForSpecificPopulations: precautionsForSpecificPopulations
          .map((item) => item.toDomain())
          .toList(growable: false),
      interactions: interactions?.toDomain(),
      adverseReactions: adverseReactions.toDomain(),
      effectsOnLabTests: effectsOnLabTests
          .map((item) => item.toDomain())
          .toList(growable: false),
      overdose: overdose?.toDomain(),
      administrationPrecautions: administrationPrecautions
          .map((item) => item.toDomain())
          .toList(growable: false),
      otherPrecautions: otherPrecautions
          .map((item) => item.toDomain())
          .toList(growable: false),
      pharmacokinetics: pharmacokinetics?.toDomain(),
      clinicalResults: clinicalResults
          .map((item) => item.toDomain())
          .toList(growable: false),
      pharmacology: pharmacology?.toDomain(),
      physicochemicalProperties: physicochemicalProperties?.toDomain(),
      handlingPrecautions: handlingPrecautions
          .map((item) => item.toDomain())
          .toList(growable: false),
      approvalConditions: approvalConditions
          .map((item) => item.toDomain())
          .toList(growable: false),
      packages: packages.map((item) => item.toDomain()).toList(growable: false),
      references: references
          .map((item) => item.toDomain())
          .toList(growable: false),
      insuranceNotes: insuranceNotes
          .map((item) => item.toDomain())
          .toList(growable: false),
      manufacturer: manufacturer,
      revisedAt: revisedAt,
      relatedDiseaseIds: relatedDiseaseIds,
      imageUrl: imageUrl,
      disclaimer: disclaimer,
    );
  }
}

extension on CompositionInfoDto {
  CompositionInfo toDomain() {
    return CompositionInfo(
      activeIngredient: activeIngredient,
      activeIngredientAmount: activeIngredientAmount.toDomain(),
      inactiveIngredients: inactiveIngredients,
      appearance: appearance,
      identificationCode: identificationCode,
    );
  }
}

extension on DoseDto {
  Dose toDomain() => Dose(amount: amount, unit: unit, per: per);
}

extension on NumberedParagraphDto {
  NumberedParagraph toDomain() {
    return NumberedParagraph(
      order: order,
      subOrder: subOrder,
      content: content,
    );
  }
}

extension on IndicationItemDto {
  IndicationItem toDomain() => IndicationItem(order: order, content: content);
}

extension on DosageInfoDto {
  DosageInfo toDomain() {
    return DosageInfo(
      standardDosage: standardDosage,
      ageSpecificDosage: ageSpecificDosage
          .map((item) => item.toDomain())
          .toList(growable: false),
      renalAdjustment: renalAdjustment
          .map((item) => item.toDomain())
          .toList(growable: false),
      hepaticAdjustment: hepaticAdjustment
          .map((item) => item.toDomain())
          .toList(growable: false),
    );
  }
}

extension on AgeDosageDto {
  AgeDosage toDomain() => AgeDosage(range: range.toDomain(), dose: dose);
}

extension on AgeRangeDto {
  AgeRange toDomain() {
    return AgeRange(
      minAgeMonths: minAgeMonths,
      maxAgeMonths: maxAgeMonths,
      label: label,
    );
  }
}

extension on RenalDoseDto {
  RenalDose toDomain() => RenalDose(range: range.toDomain(), dose: dose);
}

extension on CrClRangeDto {
  CrClRange toDomain() {
    return CrClRange(
      minMlPerMin: minMlPerMin,
      maxMlPerMin: maxMlPerMin,
      severity: severity,
      label: label,
    );
  }
}

extension on HepaticDoseDto {
  HepaticDose toDomain() => HepaticDose(severity: severity, dose: dose);
}

extension on PrecautionPopulationDto {
  PrecautionPopulation toDomain() {
    return PrecautionPopulation(category: category, note: note);
  }
}

extension on InteractionInfoDto {
  InteractionInfo toDomain() {
    return InteractionInfo(
      combinationProhibited: combinationProhibited
          .map((item) => item.toDomain())
          .toList(growable: false),
      combinationCaution: combinationCaution
          .map((item) => item.toDomain())
          .toList(growable: false),
    );
  }
}

extension on InteractionEntryDto {
  InteractionEntry toDomain() {
    return InteractionEntry(
      drugId: drugId,
      displayName: displayName,
      clinicalSymptom: clinicalSymptom,
      mechanism: mechanism,
    );
  }
}

extension on AdverseReactionInfoDto {
  AdverseReactionInfo toDomain() {
    return AdverseReactionInfo(
      serious: serious.map((item) => item.toDomain()).toList(growable: false),
      other: other.toDomain(),
    );
  }
}

extension on AdverseReactionDto {
  AdverseReaction toDomain() {
    return AdverseReaction(
      name: name,
      frequency: frequency,
      symptom: symptom,
      initialSigns: initialSigns,
      countermeasure: countermeasure,
    );
  }
}

extension on AdverseReactionByFrequencyDto {
  AdverseReactionByFrequency toDomain() {
    return AdverseReactionByFrequency(
      over5Percent: over5Percent,
      between1And5Percent: between1And5Percent,
      under1Percent: under1Percent,
      frequencyUnknown: frequencyUnknown,
    );
  }
}

extension on OverdoseInfoDto {
  OverdoseInfo toDomain() {
    return OverdoseInfo(symptoms: symptoms, management: management);
  }
}

extension on PharmacokineticsInfoDto {
  PharmacokineticsInfo toDomain() {
    return PharmacokineticsInfo(
      bloodConcentration: bloodConcentration,
      absorption: absorption,
      distribution: distribution,
      metabolism: metabolism,
      excretion: excretion,
      parameters: parameters
          .map((item) => item.toDomain())
          .toList(growable: false),
    );
  }
}

extension on PkParameterDto {
  PkParameter toDomain() => PkParameter(name: name, value: value);
}

extension on ClinicalResultSectionDto {
  ClinicalResultSection toDomain() {
    return ClinicalResultSection(heading: heading, content: content);
  }
}

extension on PharmacologyInfoDto {
  PharmacologyInfo toDomain() {
    return PharmacologyInfo(mechanism: mechanism, effect: effect);
  }
}

extension on PhysicochemicalInfoDto {
  PhysicochemicalInfo toDomain() {
    return PhysicochemicalInfo(
      genericNameEnglish: genericNameEnglish,
      molecularFormula: molecularFormula,
      molecularWeight: molecularWeight,
      description: description,
    );
  }
}

extension on PackageInfoDto {
  PackageInfo toDomain() {
    return PackageInfo(
      size: size,
      storageCondition: storageCondition.toDomain(),
      expirationMonths: expirationMonths,
    );
  }
}

extension on StorageConditionDto {
  StorageCondition toDomain() {
    return StorageCondition(
      temperature: temperature,
      lightProtection: lightProtection,
      moistureProtection: moistureProtection,
      additionalNote: additionalNote,
    );
  }
}

extension on ReferenceDto {
  Reference toDomain() => Reference(citation: citation, source: source);
}
