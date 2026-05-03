// OpenAPI DTO fields intentionally mirror the wire schema one-to-one.
// ignore_for_file: public_member_api_docs

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_nested_dto.dart';

export 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_nested_dto.dart';

/// Drug detail DTO returned by `/v1/drugs/{id}`.
final class DrugDto {
  /// Creates a drug detail DTO.
  const DrugDto({
    required this.id,
    required this.genericName,
    required this.brandName,
    required this.brandNameKana,
    required this.atcCode,
    required this.yjCode,
    required this.therapeuticCategoryName,
    required this.regulatoryClass,
    required this.dosageForm,
    required this.routeOfAdministration,
    required this.composition,
    required this.warning,
    required this.contraindications,
    required this.indications,
    required this.indicationsRelatedPrecautions,
    required this.dosage,
    required this.dosageRelatedPrecautions,
    required this.importantPrecautions,
    required this.precautionsForSpecificPopulations,
    required this.interactions,
    required this.adverseReactions,
    required this.effectsOnLabTests,
    required this.overdose,
    required this.administrationPrecautions,
    required this.otherPrecautions,
    required this.pharmacokinetics,
    required this.clinicalResults,
    required this.pharmacology,
    required this.physicochemicalProperties,
    required this.handlingPrecautions,
    required this.approvalConditions,
    required this.packages,
    required this.references,
    required this.insuranceNotes,
    required this.manufacturer,
    required this.revisedAt,
    required this.relatedDiseaseIds,
    required this.imageUrl,
    required this.disclaimer,
  });

  /// Creates a DTO from JSON.
  factory DrugDto.fromJson(Map<String, dynamic> json) {
    return DrugDto(
      id: json['id'] as String,
      genericName: json['generic_name'] as String,
      brandName: json['brand_name'] as String,
      brandNameKana: json['brand_name_kana'] as String,
      atcCode: json['atc_code'] as String,
      yjCode: json['yj_code'] as String?,
      therapeuticCategoryName: json['therapeutic_category_name'] as String,
      regulatoryClass: _stringList(json['regulatory_class']),
      dosageForm: json['dosage_form'] as String,
      routeOfAdministration: json['route_of_administration'] as String,
      composition: CompositionInfoDto.fromJson(
        json['composition'] as Map<String, dynamic>,
      ),
      warning: _mapList(json['warning'], NumberedParagraphDto.fromJson),
      contraindications: _mapList(
        json['contraindications'],
        NumberedParagraphDto.fromJson,
      ),
      indications: _mapList(json['indications'], IndicationItemDto.fromJson),
      indicationsRelatedPrecautions: _mapList(
        json['indications_related_precautions'],
        NumberedParagraphDto.fromJson,
      ),
      dosage: DosageInfoDto.fromJson(json['dosage'] as Map<String, dynamic>),
      dosageRelatedPrecautions: _mapList(
        json['dosage_related_precautions'],
        NumberedParagraphDto.fromJson,
      ),
      importantPrecautions: _mapList(
        json['important_precautions'],
        NumberedParagraphDto.fromJson,
      ),
      precautionsForSpecificPopulations: _mapList(
        json['precautions_for_specific_populations'],
        PrecautionPopulationDto.fromJson,
      ),
      interactions: _nullableMap(
        json['interactions'],
        InteractionInfoDto.fromJson,
      ),
      adverseReactions: AdverseReactionInfoDto.fromJson(
        json['adverse_reactions'] as Map<String, dynamic>,
      ),
      effectsOnLabTests: _mapList(
        json['effects_on_lab_tests'],
        NumberedParagraphDto.fromJson,
      ),
      overdose: _nullableMap(json['overdose'], OverdoseInfoDto.fromJson),
      administrationPrecautions: _mapList(
        json['administration_precautions'],
        NumberedParagraphDto.fromJson,
      ),
      otherPrecautions: _mapList(
        json['other_precautions'],
        NumberedParagraphDto.fromJson,
      ),
      pharmacokinetics: _nullableMap(
        json['pharmacokinetics'],
        PharmacokineticsInfoDto.fromJson,
      ),
      clinicalResults: _mapList(
        json['clinical_results'],
        ClinicalResultSectionDto.fromJson,
      ),
      pharmacology: _nullableMap(
        json['pharmacology'],
        PharmacologyInfoDto.fromJson,
      ),
      physicochemicalProperties: _nullableMap(
        json['physicochemical_properties'],
        PhysicochemicalInfoDto.fromJson,
      ),
      handlingPrecautions: _mapList(
        json['handling_precautions'],
        NumberedParagraphDto.fromJson,
      ),
      approvalConditions: _mapList(
        json['approval_conditions'],
        NumberedParagraphDto.fromJson,
      ),
      packages: _mapList(json['packages'], PackageInfoDto.fromJson),
      references: _mapList(json['references'], ReferenceDto.fromJson),
      insuranceNotes: _mapList(
        json['insurance_notes'],
        NumberedParagraphDto.fromJson,
      ),
      manufacturer: json['manufacturer'] as String,
      revisedAt: json['revised_at'] as String,
      relatedDiseaseIds: _stringList(json['related_disease_ids']),
      imageUrl: json['image_url'] as String,
      disclaimer: json['disclaimer'] as String,
    );
  }

  final String id;
  final String genericName;
  final String brandName;
  final String brandNameKana;
  final String atcCode;
  final String? yjCode;
  final String therapeuticCategoryName;
  final List<String> regulatoryClass;
  final String dosageForm;
  final String routeOfAdministration;
  final CompositionInfoDto composition;
  final List<NumberedParagraphDto> warning;
  final List<NumberedParagraphDto> contraindications;
  final List<IndicationItemDto> indications;
  final List<NumberedParagraphDto> indicationsRelatedPrecautions;
  final DosageInfoDto dosage;
  final List<NumberedParagraphDto> dosageRelatedPrecautions;
  final List<NumberedParagraphDto> importantPrecautions;
  final List<PrecautionPopulationDto> precautionsForSpecificPopulations;
  final InteractionInfoDto? interactions;
  final AdverseReactionInfoDto adverseReactions;
  final List<NumberedParagraphDto> effectsOnLabTests;
  final OverdoseInfoDto? overdose;
  final List<NumberedParagraphDto> administrationPrecautions;
  final List<NumberedParagraphDto> otherPrecautions;
  final PharmacokineticsInfoDto? pharmacokinetics;
  final List<ClinicalResultSectionDto> clinicalResults;
  final PharmacologyInfoDto? pharmacology;
  final PhysicochemicalInfoDto? physicochemicalProperties;
  final List<NumberedParagraphDto> handlingPrecautions;
  final List<NumberedParagraphDto> approvalConditions;
  final List<PackageInfoDto> packages;
  final List<ReferenceDto> references;
  final List<NumberedParagraphDto> insuranceNotes;
  final String manufacturer;
  final String revisedAt;
  final List<String> relatedDiseaseIds;
  final String imageUrl;
  final String disclaimer;

  /// Converts this DTO to JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'generic_name': genericName,
      'brand_name': brandName,
      'brand_name_kana': brandNameKana,
      'atc_code': atcCode,
      'yj_code': yjCode,
      'therapeutic_category_name': therapeuticCategoryName,
      'regulatory_class': regulatoryClass,
      'dosage_form': dosageForm,
      'route_of_administration': routeOfAdministration,
      'composition': composition.toJson(),
      'warning': warning.map((item) => item.toJson()).toList(),
      'contraindications': contraindications
          .map((item) => item.toJson())
          .toList(),
      'indications': indications.map((item) => item.toJson()).toList(),
      'indications_related_precautions': indicationsRelatedPrecautions
          .map((item) => item.toJson())
          .toList(),
      'dosage': dosage.toJson(),
      'dosage_related_precautions': dosageRelatedPrecautions
          .map((item) => item.toJson())
          .toList(),
      'important_precautions': importantPrecautions
          .map((item) => item.toJson())
          .toList(),
      'precautions_for_specific_populations': precautionsForSpecificPopulations
          .map((item) => item.toJson())
          .toList(),
      'interactions': interactions?.toJson(),
      'adverse_reactions': adverseReactions.toJson(),
      'effects_on_lab_tests': effectsOnLabTests
          .map((item) => item.toJson())
          .toList(),
      'overdose': overdose?.toJson(),
      'administration_precautions': administrationPrecautions
          .map((item) => item.toJson())
          .toList(),
      'other_precautions': otherPrecautions
          .map((item) => item.toJson())
          .toList(),
      'pharmacokinetics': pharmacokinetics?.toJson(),
      'clinical_results': clinicalResults.map((item) => item.toJson()).toList(),
      'pharmacology': pharmacology?.toJson(),
      'physicochemical_properties': physicochemicalProperties?.toJson(),
      'handling_precautions': handlingPrecautions
          .map((item) => item.toJson())
          .toList(),
      'approval_conditions': approvalConditions
          .map((item) => item.toJson())
          .toList(),
      'packages': packages.map((item) => item.toJson()).toList(),
      'references': references.map((item) => item.toJson()).toList(),
      'insurance_notes': insuranceNotes.map((item) => item.toJson()).toList(),
      'manufacturer': manufacturer,
      'revised_at': revisedAt,
      'related_disease_ids': relatedDiseaseIds,
      'image_url': imageUrl,
      'disclaimer': disclaimer,
    };
  }
}

List<String> _stringList(Object? value) {
  if (value == null) {
    throw const FormatException('Expected a JSON list.');
  }
  return (value as List<dynamic>).cast<String>();
}

List<T> _mapList<T>(Object? value, T Function(Map<String, dynamic>) fromJson) {
  if (value == null) {
    throw const FormatException('Expected a JSON list.');
  }
  return (value as List<dynamic>)
      .map((item) => fromJson(item as Map<String, dynamic>))
      .toList(growable: false);
}

T? _nullableMap<T>(Object? value, T Function(Map<String, dynamic>) fromJson) {
  return value == null ? null : fromJson(value as Map<String, dynamic>);
}
