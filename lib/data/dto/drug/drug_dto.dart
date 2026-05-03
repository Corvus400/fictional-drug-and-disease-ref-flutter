// OpenAPI DTO fields intentionally mirror the wire schema one-to-one.
// ignore_for_file: public_member_api_docs

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
      composition: _nullableMap(json['composition'])!,
      warning: _mapList(json['warning']),
      contraindications: _mapList(json['contraindications']),
      indications: _mapList(json['indications']),
      indicationsRelatedPrecautions: _mapList(
        json['indications_related_precautions'],
      ),
      dosage: _nullableMap(json['dosage'])!,
      dosageRelatedPrecautions: _mapList(json['dosage_related_precautions']),
      importantPrecautions: _mapList(json['important_precautions']),
      precautionsForSpecificPopulations: _mapList(
        json['precautions_for_specific_populations'],
      ),
      interactions: _nullableMap(json['interactions']),
      adverseReactions: _nullableMap(json['adverse_reactions'])!,
      effectsOnLabTests: _mapList(json['effects_on_lab_tests']),
      overdose: _nullableMap(json['overdose']),
      administrationPrecautions: _mapList(json['administration_precautions']),
      otherPrecautions: _mapList(json['other_precautions']),
      pharmacokinetics: _nullableMap(json['pharmacokinetics']),
      clinicalResults: _mapList(json['clinical_results']),
      pharmacology: _nullableMap(json['pharmacology']),
      physicochemicalProperties: _nullableMap(
        json['physicochemical_properties'],
      ),
      handlingPrecautions: _mapList(json['handling_precautions']),
      approvalConditions: _mapList(json['approval_conditions']),
      packages: _mapList(json['packages']),
      references: _mapList(json['references']),
      insuranceNotes: _mapList(json['insurance_notes']),
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
  final Map<String, dynamic> composition;
  final List<Map<String, dynamic>> warning;
  final List<Map<String, dynamic>> contraindications;
  final List<Map<String, dynamic>> indications;
  final List<Map<String, dynamic>> indicationsRelatedPrecautions;
  final Map<String, dynamic> dosage;
  final List<Map<String, dynamic>> dosageRelatedPrecautions;
  final List<Map<String, dynamic>> importantPrecautions;
  final List<Map<String, dynamic>> precautionsForSpecificPopulations;
  final Map<String, dynamic>? interactions;
  final Map<String, dynamic> adverseReactions;
  final List<Map<String, dynamic>> effectsOnLabTests;
  final Map<String, dynamic>? overdose;
  final List<Map<String, dynamic>> administrationPrecautions;
  final List<Map<String, dynamic>> otherPrecautions;
  final Map<String, dynamic>? pharmacokinetics;
  final List<Map<String, dynamic>> clinicalResults;
  final Map<String, dynamic>? pharmacology;
  final Map<String, dynamic>? physicochemicalProperties;
  final List<Map<String, dynamic>> handlingPrecautions;
  final List<Map<String, dynamic>> approvalConditions;
  final List<Map<String, dynamic>> packages;
  final List<Map<String, dynamic>> references;
  final List<Map<String, dynamic>> insuranceNotes;
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
      'composition': composition,
      'warning': warning,
      'contraindications': contraindications,
      'indications': indications,
      'indications_related_precautions': indicationsRelatedPrecautions,
      'dosage': dosage,
      'dosage_related_precautions': dosageRelatedPrecautions,
      'important_precautions': importantPrecautions,
      'precautions_for_specific_populations': precautionsForSpecificPopulations,
      'interactions': interactions,
      'adverse_reactions': adverseReactions,
      'effects_on_lab_tests': effectsOnLabTests,
      'overdose': overdose,
      'administration_precautions': administrationPrecautions,
      'other_precautions': otherPrecautions,
      'pharmacokinetics': pharmacokinetics,
      'clinical_results': clinicalResults,
      'pharmacology': pharmacology,
      'physicochemical_properties': physicochemicalProperties,
      'handling_precautions': handlingPrecautions,
      'approval_conditions': approvalConditions,
      'packages': packages,
      'references': references,
      'insurance_notes': insuranceNotes,
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

List<Map<String, dynamic>> _mapList(Object? value) {
  if (value == null) {
    throw const FormatException('Expected a JSON list.');
  }
  return (value as List<dynamic>).cast<Map<String, dynamic>>();
}

Map<String, dynamic>? _nullableMap(Object? value) {
  return value == null ? null : value as Map<String, dynamic>;
}
