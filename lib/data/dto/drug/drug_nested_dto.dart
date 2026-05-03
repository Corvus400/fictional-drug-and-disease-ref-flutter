// OpenAPI DTO fields intentionally mirror the wire schema one-to-one.
// ignore_for_file: public_member_api_docs

final class CompositionInfoDto {
  const CompositionInfoDto({
    required this.activeIngredient,
    required this.activeIngredientAmount,
    required this.inactiveIngredients,
    required this.appearance,
    required this.identificationCode,
  });

  factory CompositionInfoDto.fromJson(Map<String, dynamic> json) {
    return CompositionInfoDto(
      activeIngredient: json['active_ingredient'] as String,
      activeIngredientAmount: DoseDto.fromJson(
        json['active_ingredient_amount'] as Map<String, dynamic>,
      ),
      inactiveIngredients: _stringList(json['inactive_ingredients']),
      appearance: json['appearance'] as String,
      identificationCode: json['identification_code'] as String?,
    );
  }

  final String activeIngredient;
  final DoseDto activeIngredientAmount;
  final List<String> inactiveIngredients;
  final String appearance;
  final String? identificationCode;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'active_ingredient': activeIngredient,
    'active_ingredient_amount': activeIngredientAmount.toJson(),
    'inactive_ingredients': inactiveIngredients,
    'appearance': appearance,
    'identification_code': identificationCode,
  };
}

final class DoseDto {
  const DoseDto({required this.amount, required this.unit, required this.per});

  factory DoseDto.fromJson(Map<String, dynamic> json) {
    return DoseDto(
      amount: json['amount'] as num,
      unit: json['unit'] as String,
      per: json['per'] as String?,
    );
  }

  final num amount;
  final String unit;
  final String? per;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'amount': amount,
    'unit': unit,
    'per': per,
  };
}

final class NumberedParagraphDto {
  const NumberedParagraphDto({
    required this.order,
    required this.subOrder,
    required this.content,
  });

  factory NumberedParagraphDto.fromJson(Map<String, dynamic> json) {
    return NumberedParagraphDto(
      order: json['order'] as int,
      subOrder: json['sub_order'] as int?,
      content: json['content'] as String,
    );
  }

  final int order;
  final int? subOrder;
  final String content;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'order': order,
    'sub_order': subOrder,
    'content': content,
  };
}

final class IndicationItemDto {
  const IndicationItemDto({required this.order, required this.content});

  factory IndicationItemDto.fromJson(Map<String, dynamic> json) {
    return IndicationItemDto(
      order: json['order'] as int,
      content: json['content'] as String,
    );
  }

  final int order;
  final String content;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'order': order,
    'content': content,
  };
}

final class DosageInfoDto {
  const DosageInfoDto({
    required this.standardDosage,
    required this.ageSpecificDosage,
    required this.renalAdjustment,
    required this.hepaticAdjustment,
  });

  factory DosageInfoDto.fromJson(Map<String, dynamic> json) {
    return DosageInfoDto(
      standardDosage: json['standard_dosage'] as String,
      ageSpecificDosage: _mapList(
        json['age_specific_dosage'],
        AgeDosageDto.fromJson,
      ),
      renalAdjustment: _mapList(
        json['renal_adjustment'],
        RenalDoseDto.fromJson,
      ),
      hepaticAdjustment: _mapList(
        json['hepatic_adjustment'],
        HepaticDoseDto.fromJson,
      ),
    );
  }

  final String standardDosage;
  final List<AgeDosageDto> ageSpecificDosage;
  final List<RenalDoseDto> renalAdjustment;
  final List<HepaticDoseDto> hepaticAdjustment;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'standard_dosage': standardDosage,
    'age_specific_dosage': ageSpecificDosage.map((e) => e.toJson()).toList(),
    'renal_adjustment': renalAdjustment.map((e) => e.toJson()).toList(),
    'hepatic_adjustment': hepaticAdjustment.map((e) => e.toJson()).toList(),
  };
}

final class AgeDosageDto {
  const AgeDosageDto({required this.range, required this.dose});

  factory AgeDosageDto.fromJson(Map<String, dynamic> json) {
    return AgeDosageDto(
      range: AgeRangeDto.fromJson(json['range'] as Map<String, dynamic>),
      dose: json['dose'] as String,
    );
  }

  final AgeRangeDto range;
  final String dose;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'range': range.toJson(),
    'dose': dose,
  };
}

final class AgeRangeDto {
  const AgeRangeDto({
    required this.minAgeMonths,
    required this.maxAgeMonths,
    required this.label,
  });

  factory AgeRangeDto.fromJson(Map<String, dynamic> json) {
    return AgeRangeDto(
      minAgeMonths: json['min_age_months'] as int?,
      maxAgeMonths: json['max_age_months'] as int?,
      label: json['label'] as String,
    );
  }

  final int? minAgeMonths;
  final int? maxAgeMonths;
  final String label;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'min_age_months': minAgeMonths,
    'max_age_months': maxAgeMonths,
    'label': label,
  };
}

final class RenalDoseDto {
  const RenalDoseDto({required this.range, required this.dose});

  factory RenalDoseDto.fromJson(Map<String, dynamic> json) {
    return RenalDoseDto(
      range: CrClRangeDto.fromJson(json['range'] as Map<String, dynamic>),
      dose: json['dose'] as String,
    );
  }

  final CrClRangeDto range;
  final String dose;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'range': range.toJson(),
    'dose': dose,
  };
}

final class CrClRangeDto {
  const CrClRangeDto({
    required this.minMlPerMin,
    required this.maxMlPerMin,
    required this.severity,
    required this.label,
  });

  factory CrClRangeDto.fromJson(Map<String, dynamic> json) {
    return CrClRangeDto(
      minMlPerMin: json['min_ml_per_min'] as int?,
      maxMlPerMin: json['max_ml_per_min'] as int?,
      severity: json['severity'] as String,
      label: json['label'] as String,
    );
  }

  final int? minMlPerMin;
  final int? maxMlPerMin;
  final String severity;
  final String label;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'min_ml_per_min': minMlPerMin,
    'max_ml_per_min': maxMlPerMin,
    'severity': severity,
    'label': label,
  };
}

final class HepaticDoseDto {
  const HepaticDoseDto({required this.severity, required this.dose});

  factory HepaticDoseDto.fromJson(Map<String, dynamic> json) {
    return HepaticDoseDto(
      severity: json['severity'] as String,
      dose: json['dose'] as String,
    );
  }

  final String severity;
  final String dose;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'severity': severity,
    'dose': dose,
  };
}

final class PrecautionPopulationDto {
  const PrecautionPopulationDto({required this.category, required this.note});

  factory PrecautionPopulationDto.fromJson(Map<String, dynamic> json) {
    return PrecautionPopulationDto(
      category: json['category'] as String,
      note: json['note'] as String,
    );
  }

  final String category;
  final String note;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'category': category,
    'note': note,
  };
}

final class InteractionInfoDto {
  const InteractionInfoDto({
    required this.combinationProhibited,
    required this.combinationCaution,
  });

  factory InteractionInfoDto.fromJson(Map<String, dynamic> json) {
    return InteractionInfoDto(
      combinationProhibited: _mapList(
        json['combination_prohibited'],
        InteractionEntryDto.fromJson,
      ),
      combinationCaution: _mapList(
        json['combination_caution'],
        InteractionEntryDto.fromJson,
      ),
    );
  }

  final List<InteractionEntryDto> combinationProhibited;
  final List<InteractionEntryDto> combinationCaution;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'combination_prohibited': combinationProhibited
        .map((e) => e.toJson())
        .toList(),
    'combination_caution': combinationCaution.map((e) => e.toJson()).toList(),
  };
}

final class InteractionEntryDto {
  const InteractionEntryDto({
    required this.drugId,
    required this.displayName,
    required this.clinicalSymptom,
    required this.mechanism,
  });

  factory InteractionEntryDto.fromJson(Map<String, dynamic> json) {
    return InteractionEntryDto(
      drugId: json['drug_id'] as String?,
      displayName: json['display_name'] as String,
      clinicalSymptom: json['clinical_symptom'] as String,
      mechanism: json['mechanism'] as String,
    );
  }

  final String? drugId;
  final String displayName;
  final String clinicalSymptom;
  final String mechanism;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'drug_id': drugId,
    'display_name': displayName,
    'clinical_symptom': clinicalSymptom,
    'mechanism': mechanism,
  };
}

final class AdverseReactionInfoDto {
  const AdverseReactionInfoDto({required this.serious, required this.other});

  factory AdverseReactionInfoDto.fromJson(Map<String, dynamic> json) {
    return AdverseReactionInfoDto(
      serious: _mapList(json['serious'], AdverseReactionDto.fromJson),
      other: AdverseReactionByFrequencyDto.fromJson(
        json['other'] as Map<String, dynamic>,
      ),
    );
  }

  final List<AdverseReactionDto> serious;
  final AdverseReactionByFrequencyDto other;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'serious': serious.map((e) => e.toJson()).toList(),
    'other': other.toJson(),
  };
}

final class AdverseReactionDto {
  const AdverseReactionDto({
    required this.name,
    required this.frequency,
    required this.symptom,
    required this.initialSigns,
    required this.countermeasure,
  });

  factory AdverseReactionDto.fromJson(Map<String, dynamic> json) {
    return AdverseReactionDto(
      name: json['name'] as String,
      frequency: json['frequency'] as String,
      symptom: json['symptom'] as String,
      initialSigns: json['initial_signs'] as String,
      countermeasure: json['countermeasure'] as String,
    );
  }

  final String name;
  final String frequency;
  final String symptom;
  final String initialSigns;
  final String countermeasure;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'frequency': frequency,
    'symptom': symptom,
    'initial_signs': initialSigns,
    'countermeasure': countermeasure,
  };
}

final class AdverseReactionByFrequencyDto {
  const AdverseReactionByFrequencyDto({
    required this.over5Percent,
    required this.between1And5Percent,
    required this.under1Percent,
    required this.frequencyUnknown,
  });

  factory AdverseReactionByFrequencyDto.fromJson(Map<String, dynamic> json) {
    return AdverseReactionByFrequencyDto(
      over5Percent: _stringList(json['over5_percent']),
      between1And5Percent: _stringList(json['between1_and5_percent']),
      under1Percent: _stringList(json['under1_percent']),
      frequencyUnknown: _stringList(json['frequency_unknown']),
    );
  }

  final List<String> over5Percent;
  final List<String> between1And5Percent;
  final List<String> under1Percent;
  final List<String> frequencyUnknown;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'over5_percent': over5Percent,
    'between1_and5_percent': between1And5Percent,
    'under1_percent': under1Percent,
    'frequency_unknown': frequencyUnknown,
  };
}

final class OverdoseInfoDto {
  const OverdoseInfoDto({required this.symptoms, required this.management});

  factory OverdoseInfoDto.fromJson(Map<String, dynamic> json) {
    return OverdoseInfoDto(
      symptoms: json['symptoms'] as String,
      management: json['management'] as String,
    );
  }

  final String symptoms;
  final String management;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'symptoms': symptoms,
    'management': management,
  };
}

final class PharmacokineticsInfoDto {
  const PharmacokineticsInfoDto({
    required this.bloodConcentration,
    required this.absorption,
    required this.distribution,
    required this.metabolism,
    required this.excretion,
    required this.parameters,
  });

  factory PharmacokineticsInfoDto.fromJson(Map<String, dynamic> json) {
    return PharmacokineticsInfoDto(
      bloodConcentration: json['blood_concentration'] as String?,
      absorption: json['absorption'] as String?,
      distribution: json['distribution'] as String?,
      metabolism: json['metabolism'] as String?,
      excretion: json['excretion'] as String?,
      parameters: _mapList(json['parameters'], PkParameterDto.fromJson),
    );
  }

  final String? bloodConcentration;
  final String? absorption;
  final String? distribution;
  final String? metabolism;
  final String? excretion;
  final List<PkParameterDto> parameters;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'blood_concentration': bloodConcentration,
    'absorption': absorption,
    'distribution': distribution,
    'metabolism': metabolism,
    'excretion': excretion,
    'parameters': parameters.map((e) => e.toJson()).toList(),
  };
}

final class PkParameterDto {
  const PkParameterDto({required this.name, required this.value});

  factory PkParameterDto.fromJson(Map<String, dynamic> json) {
    return PkParameterDto(
      name: json['name'] as String,
      value: json['value'] as String,
    );
  }

  final String name;
  final String value;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'value': value,
  };
}

final class ClinicalResultSectionDto {
  const ClinicalResultSectionDto({
    required this.heading,
    required this.content,
  });

  factory ClinicalResultSectionDto.fromJson(Map<String, dynamic> json) {
    return ClinicalResultSectionDto(
      heading: json['heading'] as String,
      content: json['content'] as String,
    );
  }

  final String heading;
  final String content;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'heading': heading,
    'content': content,
  };
}

final class PharmacologyInfoDto {
  const PharmacologyInfoDto({required this.mechanism, required this.effect});

  factory PharmacologyInfoDto.fromJson(Map<String, dynamic> json) {
    return PharmacologyInfoDto(
      mechanism: json['mechanism'] as String,
      effect: json['effect'] as String,
    );
  }

  final String mechanism;
  final String effect;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'mechanism': mechanism,
    'effect': effect,
  };
}

final class PhysicochemicalInfoDto {
  const PhysicochemicalInfoDto({
    required this.genericNameEnglish,
    required this.molecularFormula,
    required this.molecularWeight,
    required this.description,
  });

  factory PhysicochemicalInfoDto.fromJson(Map<String, dynamic> json) {
    return PhysicochemicalInfoDto(
      genericNameEnglish: json['generic_name_english'] as String,
      molecularFormula: json['molecular_formula'] as String,
      molecularWeight: (json['molecular_weight'] as num?)?.toDouble(),
      description: json['description'] as String,
    );
  }

  final String genericNameEnglish;
  final String molecularFormula;
  final double? molecularWeight;
  final String description;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'generic_name_english': genericNameEnglish,
    'molecular_formula': molecularFormula,
    'molecular_weight': molecularWeight,
    'description': description,
  };
}

final class PackageInfoDto {
  const PackageInfoDto({
    required this.size,
    required this.storageCondition,
    required this.expirationMonths,
  });

  factory PackageInfoDto.fromJson(Map<String, dynamic> json) {
    return PackageInfoDto(
      size: json['size'] as String,
      storageCondition: StorageConditionDto.fromJson(
        json['storage_condition'] as Map<String, dynamic>,
      ),
      expirationMonths: json['expiration_months'] as int,
    );
  }

  final String size;
  final StorageConditionDto storageCondition;
  final int expirationMonths;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'size': size,
    'storage_condition': storageCondition.toJson(),
    'expiration_months': expirationMonths,
  };
}

final class StorageConditionDto {
  const StorageConditionDto({
    required this.temperature,
    required this.lightProtection,
    required this.moistureProtection,
    required this.additionalNote,
  });

  factory StorageConditionDto.fromJson(Map<String, dynamic> json) {
    return StorageConditionDto(
      temperature: json['temperature'] as String,
      lightProtection: json['light_protection'] as bool,
      moistureProtection: json['moisture_protection'] as bool,
      additionalNote: json['additional_note'] as String?,
    );
  }

  final String temperature;
  final bool lightProtection;
  final bool moistureProtection;
  final String? additionalNote;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'temperature': temperature,
    'light_protection': lightProtection,
    'moisture_protection': moistureProtection,
    'additional_note': additionalNote,
  };
}

final class ReferenceDto {
  const ReferenceDto({required this.citation, required this.source});

  factory ReferenceDto.fromJson(Map<String, dynamic> json) {
    return ReferenceDto(
      citation: json['citation'] as String,
      source: json['source'] as String?,
    );
  }

  final String citation;
  final String? source;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'citation': citation,
    'source': source,
  };
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
