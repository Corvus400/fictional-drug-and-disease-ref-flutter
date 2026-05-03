/// Drug detail used by detail surfaces and use cases.
final class Drug {
  /// Creates a drug detail.
  const Drug({
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

  /// Drug id.
  final String id;

  /// Generic name.
  final String genericName;

  /// Brand name.
  final String brandName;

  /// Brand name kana.
  final String brandNameKana;

  /// ATC code.
  final String atcCode;

  /// Optional YJ code.
  final String? yjCode;

  /// Therapeutic category display name.
  final String therapeuticCategoryName;

  /// Regulatory class serial names.
  final List<String> regulatoryClass;

  /// Dosage form serial name.
  final String dosageForm;

  /// Route of administration serial name.
  final String routeOfAdministration;

  /// Composition JSON object.
  final Map<String, dynamic> composition;

  /// Warning paragraphs.
  final List<Map<String, dynamic>> warning;

  /// Contraindication paragraphs.
  final List<Map<String, dynamic>> contraindications;

  /// Indications.
  final List<Map<String, dynamic>> indications;

  /// Indication-related precaution paragraphs.
  final List<Map<String, dynamic>> indicationsRelatedPrecautions;

  /// Dosage JSON object.
  final Map<String, dynamic> dosage;

  /// Dosage-related precaution paragraphs.
  final List<Map<String, dynamic>> dosageRelatedPrecautions;

  /// Important precaution paragraphs.
  final List<Map<String, dynamic>> importantPrecautions;

  /// Specific-population precaution entries.
  final List<Map<String, dynamic>> precautionsForSpecificPopulations;

  /// Optional interaction JSON object.
  final Map<String, dynamic>? interactions;

  /// Adverse reactions JSON object.
  final Map<String, dynamic> adverseReactions;

  /// Lab test effect paragraphs.
  final List<Map<String, dynamic>> effectsOnLabTests;

  /// Optional overdose JSON object.
  final Map<String, dynamic>? overdose;

  /// Administration precaution paragraphs.
  final List<Map<String, dynamic>> administrationPrecautions;

  /// Other precaution paragraphs.
  final List<Map<String, dynamic>> otherPrecautions;

  /// Optional pharmacokinetics JSON object.
  final Map<String, dynamic>? pharmacokinetics;

  /// Clinical result sections.
  final List<Map<String, dynamic>> clinicalResults;

  /// Optional pharmacology JSON object.
  final Map<String, dynamic>? pharmacology;

  /// Optional physicochemical properties JSON object.
  final Map<String, dynamic>? physicochemicalProperties;

  /// Handling precaution paragraphs.
  final List<Map<String, dynamic>> handlingPrecautions;

  /// Approval condition paragraphs.
  final List<Map<String, dynamic>> approvalConditions;

  /// Package entries.
  final List<Map<String, dynamic>> packages;

  /// Reference entries.
  final List<Map<String, dynamic>> references;

  /// Insurance note paragraphs.
  final List<Map<String, dynamic>> insuranceNotes;

  /// Manufacturer name.
  final String manufacturer;

  /// Revised date as `YYYY-MM-DD`.
  final String revisedAt;

  /// Related disease ids.
  final List<String> relatedDiseaseIds;

  /// Relative image URL.
  final String imageUrl;

  /// Response disclaimer.
  final String disclaimer;
}
