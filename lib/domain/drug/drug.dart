import 'package:fictional_drug_and_disease_ref/domain/drug/drug_nested.dart';

export 'package:fictional_drug_and_disease_ref/domain/drug/drug_nested.dart';

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

  /// Composition.
  final CompositionInfo composition;

  /// Warning paragraphs.
  final List<NumberedParagraph> warning;

  /// Contraindication paragraphs.
  final List<NumberedParagraph> contraindications;

  /// Indications.
  final List<IndicationItem> indications;

  /// Indication-related precaution paragraphs.
  final List<NumberedParagraph> indicationsRelatedPrecautions;

  /// Dosage.
  final DosageInfo dosage;

  /// Dosage-related precaution paragraphs.
  final List<NumberedParagraph> dosageRelatedPrecautions;

  /// Important precaution paragraphs.
  final List<NumberedParagraph> importantPrecautions;

  /// Specific-population precaution entries.
  final List<PrecautionPopulation> precautionsForSpecificPopulations;

  /// Optional interaction info.
  final InteractionInfo? interactions;

  /// Adverse reactions.
  final AdverseReactionInfo adverseReactions;

  /// Lab test effect paragraphs.
  final List<NumberedParagraph> effectsOnLabTests;

  /// Optional overdose info.
  final OverdoseInfo? overdose;

  /// Administration precaution paragraphs.
  final List<NumberedParagraph> administrationPrecautions;

  /// Other precaution paragraphs.
  final List<NumberedParagraph> otherPrecautions;

  /// Optional pharmacokinetics.
  final PharmacokineticsInfo? pharmacokinetics;

  /// Clinical result sections.
  final List<ClinicalResultSection> clinicalResults;

  /// Optional pharmacology.
  final PharmacologyInfo? pharmacology;

  /// Optional physicochemical properties.
  final PhysicochemicalInfo? physicochemicalProperties;

  /// Handling precaution paragraphs.
  final List<NumberedParagraph> handlingPrecautions;

  /// Approval condition paragraphs.
  final List<NumberedParagraph> approvalConditions;

  /// Package entries.
  final List<PackageInfo> packages;

  /// Reference entries.
  final List<Reference> references;

  /// Insurance note paragraphs.
  final List<NumberedParagraph> insuranceNotes;

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
