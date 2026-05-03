// The nested OpenAPI schema exposes many small value types; documenting each
// field would duplicate schema names without adding useful context.
// ignore_for_file: public_member_api_docs

typedef JsonObject = Map<String, Object?>;

final class CompositionInfo {
  const CompositionInfo({
    required this.activeIngredient,
    required this.activeIngredientAmount,
    required this.inactiveIngredients,
    required this.appearance,
    required this.identificationCode,
  });

  final String activeIngredient;
  final Dose activeIngredientAmount;
  final List<String> inactiveIngredients;
  final String appearance;
  final String? identificationCode;

  JsonObject toJson() => <String, Object?>{
    'active_ingredient': activeIngredient,
    'active_ingredient_amount': activeIngredientAmount.toJson(),
    'inactive_ingredients': inactiveIngredients,
    'appearance': appearance,
    'identification_code': identificationCode,
  };
}

final class Dose {
  const Dose({required this.amount, required this.unit, required this.per});

  final num amount;
  final String unit;
  final String? per;

  JsonObject toJson() => <String, Object?>{
    'amount': amount,
    'unit': unit,
    'per': per,
  };
}

final class NumberedParagraph {
  const NumberedParagraph({
    required this.order,
    required this.subOrder,
    required this.content,
  });

  final int order;
  final int? subOrder;
  final String content;

  JsonObject toJson() => <String, Object?>{
    'order': order,
    'sub_order': subOrder,
    'content': content,
  };
}

final class IndicationItem {
  const IndicationItem({required this.order, required this.content});

  final int order;
  final String content;

  JsonObject toJson() => <String, Object?>{
    'order': order,
    'content': content,
  };
}

final class DosageInfo {
  const DosageInfo({
    required this.standardDosage,
    required this.ageSpecificDosage,
    required this.renalAdjustment,
    required this.hepaticAdjustment,
  });

  final String standardDosage;
  final List<AgeDosage> ageSpecificDosage;
  final List<RenalDose> renalAdjustment;
  final List<HepaticDose> hepaticAdjustment;

  JsonObject toJson() => <String, Object?>{
    'standard_dosage': standardDosage,
    'age_specific_dosage': _toJsonList(
      ageSpecificDosage,
      (item) => item.toJson(),
    ),
    'renal_adjustment': _toJsonList(renalAdjustment, (item) => item.toJson()),
    'hepatic_adjustment': _toJsonList(
      hepaticAdjustment,
      (item) => item.toJson(),
    ),
  };
}

final class AgeDosage {
  const AgeDosage({required this.range, required this.dose});

  final AgeRange range;
  final String dose;

  JsonObject toJson() => <String, Object?>{
    'range': range.toJson(),
    'dose': dose,
  };
}

final class AgeRange {
  const AgeRange({
    required this.minAgeMonths,
    required this.maxAgeMonths,
    required this.label,
  });

  final int? minAgeMonths;
  final int? maxAgeMonths;
  final String label;

  JsonObject toJson() => <String, Object?>{
    'min_age_months': minAgeMonths,
    'max_age_months': maxAgeMonths,
    'label': label,
  };
}

final class RenalDose {
  const RenalDose({required this.range, required this.dose});

  final CrClRange range;
  final String dose;

  JsonObject toJson() => <String, Object?>{
    'range': range.toJson(),
    'dose': dose,
  };
}

final class CrClRange {
  const CrClRange({
    required this.minMlPerMin,
    required this.maxMlPerMin,
    required this.severity,
    required this.label,
  });

  final int? minMlPerMin;
  final int? maxMlPerMin;
  final String severity;
  final String label;

  JsonObject toJson() => <String, Object?>{
    'min_ml_per_min': minMlPerMin,
    'max_ml_per_min': maxMlPerMin,
    'severity': severity,
    'label': label,
  };
}

final class HepaticDose {
  const HepaticDose({required this.severity, required this.dose});

  final String severity;
  final String dose;

  JsonObject toJson() => <String, Object?>{
    'severity': severity,
    'dose': dose,
  };
}

final class PrecautionPopulation {
  const PrecautionPopulation({required this.category, required this.note});

  final String category;
  final String note;

  JsonObject toJson() => <String, Object?>{
    'category': category,
    'note': note,
  };
}

final class InteractionInfo {
  const InteractionInfo({
    required this.combinationProhibited,
    required this.combinationCaution,
  });

  final List<InteractionEntry> combinationProhibited;
  final List<InteractionEntry> combinationCaution;

  JsonObject toJson() => <String, Object?>{
    'combination_prohibited': _toJsonList(
      combinationProhibited,
      (item) => item.toJson(),
    ),
    'combination_caution': _toJsonList(
      combinationCaution,
      (item) => item.toJson(),
    ),
  };
}

final class InteractionEntry {
  const InteractionEntry({
    required this.drugId,
    required this.displayName,
    required this.clinicalSymptom,
    required this.mechanism,
  });

  final String? drugId;
  final String displayName;
  final String clinicalSymptom;
  final String mechanism;

  JsonObject toJson() => <String, Object?>{
    'drug_id': drugId,
    'display_name': displayName,
    'clinical_symptom': clinicalSymptom,
    'mechanism': mechanism,
  };
}

final class AdverseReactionInfo {
  const AdverseReactionInfo({required this.serious, required this.other});

  final List<AdverseReaction> serious;
  final AdverseReactionByFrequency other;

  JsonObject toJson() => <String, Object?>{
    'serious': _toJsonList(serious, (item) => item.toJson()),
    'other': other.toJson(),
  };
}

final class AdverseReaction {
  const AdverseReaction({
    required this.name,
    required this.frequency,
    required this.symptom,
    required this.initialSigns,
    required this.countermeasure,
  });

  final String name;
  final String frequency;
  final String symptom;
  final String initialSigns;
  final String countermeasure;

  JsonObject toJson() => <String, Object?>{
    'name': name,
    'frequency': frequency,
    'symptom': symptom,
    'initial_signs': initialSigns,
    'countermeasure': countermeasure,
  };
}

final class AdverseReactionByFrequency {
  const AdverseReactionByFrequency({
    required this.over5Percent,
    required this.between1And5Percent,
    required this.under1Percent,
    required this.frequencyUnknown,
  });

  final List<String> over5Percent;
  final List<String> between1And5Percent;
  final List<String> under1Percent;
  final List<String> frequencyUnknown;

  JsonObject toJson() => <String, Object?>{
    'over5_percent': over5Percent,
    'between1_and5_percent': between1And5Percent,
    'under1_percent': under1Percent,
    'frequency_unknown': frequencyUnknown,
  };
}

final class OverdoseInfo {
  const OverdoseInfo({required this.symptoms, required this.management});

  final String symptoms;
  final String management;

  JsonObject toJson() => <String, Object?>{
    'symptoms': symptoms,
    'management': management,
  };
}

final class PharmacokineticsInfo {
  const PharmacokineticsInfo({
    required this.bloodConcentration,
    required this.absorption,
    required this.distribution,
    required this.metabolism,
    required this.excretion,
    required this.parameters,
  });

  final String? bloodConcentration;
  final String? absorption;
  final String? distribution;
  final String? metabolism;
  final String? excretion;
  final List<PkParameter> parameters;

  JsonObject toJson() => <String, Object?>{
    'blood_concentration': bloodConcentration,
    'absorption': absorption,
    'distribution': distribution,
    'metabolism': metabolism,
    'excretion': excretion,
    'parameters': _toJsonList(parameters, (item) => item.toJson()),
  };
}

final class PkParameter {
  const PkParameter({required this.name, required this.value});

  final String name;
  final String value;

  JsonObject toJson() => <String, Object?>{'name': name, 'value': value};
}

final class ClinicalResultSection {
  const ClinicalResultSection({required this.heading, required this.content});

  final String heading;
  final String content;

  JsonObject toJson() => <String, Object?>{
    'heading': heading,
    'content': content,
  };
}

final class PharmacologyInfo {
  const PharmacologyInfo({required this.mechanism, required this.effect});

  final String mechanism;
  final String effect;

  JsonObject toJson() => <String, Object?>{
    'mechanism': mechanism,
    'effect': effect,
  };
}

final class PhysicochemicalInfo {
  const PhysicochemicalInfo({
    required this.genericNameEnglish,
    required this.molecularFormula,
    required this.molecularWeight,
    required this.description,
  });

  final String genericNameEnglish;
  final String molecularFormula;
  final double? molecularWeight;
  final String description;

  JsonObject toJson() => <String, Object?>{
    'generic_name_english': genericNameEnglish,
    'molecular_formula': molecularFormula,
    'molecular_weight': molecularWeight,
    'description': description,
  };
}

final class PackageInfo {
  const PackageInfo({
    required this.size,
    required this.storageCondition,
    required this.expirationMonths,
  });

  final String size;
  final StorageCondition storageCondition;
  final int expirationMonths;

  JsonObject toJson() => <String, Object?>{
    'size': size,
    'storage_condition': storageCondition.toJson(),
    'expiration_months': expirationMonths,
  };
}

final class StorageCondition {
  const StorageCondition({
    required this.temperature,
    required this.lightProtection,
    required this.moistureProtection,
    required this.additionalNote,
  });

  final String temperature;
  final bool lightProtection;
  final bool moistureProtection;
  final String? additionalNote;

  JsonObject toJson() => <String, Object?>{
    'temperature': temperature,
    'light_protection': lightProtection,
    'moisture_protection': moistureProtection,
    'additional_note': additionalNote,
  };
}

final class Reference {
  const Reference({required this.citation, required this.source});

  final String citation;
  final String? source;

  JsonObject toJson() => <String, Object?>{
    'citation': citation,
    'source': source,
  };
}

List<JsonObject> _toJsonList<T>(
  Iterable<T> items,
  JsonObject Function(T item) toJson,
) {
  return items.map(toJson).toList(growable: false);
}
