// OpenAPI DTO fields intentionally mirror the wire schema one-to-one.
// ignore_for_file: public_member_api_docs

final class EpidemiologyInfoDto {
  const EpidemiologyInfoDto({
    required this.prevalence,
    required this.onsetAgeRange,
    required this.sexRatio,
    required this.riskFactors,
  });

  factory EpidemiologyInfoDto.fromJson(Map<String, dynamic> json) {
    return EpidemiologyInfoDto(
      prevalence: _nullableMap(json['prevalence'], PrevalenceDto.fromJson),
      onsetAgeRange: _nullableMap(
        json['onset_age_range'],
        OnsetAgeRangeDto.fromJson,
      ),
      sexRatio: _nullableMap(json['sex_ratio'], SexDistributionDto.fromJson),
      riskFactors: _stringList(json['risk_factors']),
    );
  }

  final PrevalenceDto? prevalence;
  final OnsetAgeRangeDto? onsetAgeRange;
  final SexDistributionDto? sexRatio;
  final List<String> riskFactors;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'prevalence': prevalence?.toJson(),
    'onset_age_range': onsetAgeRange?.toJson(),
    'sex_ratio': sexRatio?.toJson(),
    'risk_factors': riskFactors,
  };
}

final class PrevalenceDto {
  const PrevalenceDto({
    required this.rate,
    required this.denominator,
    required this.unit,
    required this.label,
  });

  factory PrevalenceDto.fromJson(Map<String, dynamic> json) {
    return PrevalenceDto(
      rate: (json['rate'] as num?)?.toDouble(),
      denominator: json['denominator'] as int?,
      unit: json['unit'] as String,
      label: json['label'] as String,
    );
  }

  final double? rate;
  final int? denominator;
  final String unit;
  final String label;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'rate': rate,
    'denominator': denominator,
    'unit': unit,
    'label': label,
  };
}

final class OnsetAgeRangeDto {
  const OnsetAgeRangeDto({
    required this.minAgeYears,
    required this.maxAgeYears,
    required this.label,
  });

  factory OnsetAgeRangeDto.fromJson(Map<String, dynamic> json) {
    return OnsetAgeRangeDto(
      minAgeYears: json['min_age_years'] as int?,
      maxAgeYears: json['max_age_years'] as int?,
      label: json['label'] as String,
    );
  }

  final int? minAgeYears;
  final int? maxAgeYears;
  final String label;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'min_age_years': minAgeYears,
    'max_age_years': maxAgeYears,
    'label': label,
  };
}

final class SexDistributionDto {
  const SexDistributionDto({
    required this.maleRatio,
    required this.femaleRatio,
    required this.note,
  });

  factory SexDistributionDto.fromJson(Map<String, dynamic> json) {
    return SexDistributionDto(
      maleRatio: json['male_ratio'] as int,
      femaleRatio: json['female_ratio'] as int,
      note: json['note'] as String?,
    );
  }

  final int maleRatio;
  final int femaleRatio;
  final String? note;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'male_ratio': maleRatio,
    'female_ratio': femaleRatio,
    'note': note,
  };
}

final class SymptomInfoDto {
  const SymptomInfoDto({
    required this.mainSymptoms,
    required this.associatedSymptoms,
    required this.onsetPattern,
  });

  factory SymptomInfoDto.fromJson(Map<String, dynamic> json) {
    return SymptomInfoDto(
      mainSymptoms: _stringList(json['main_symptoms']),
      associatedSymptoms: _stringList(json['associated_symptoms']),
      onsetPattern: json['onset_pattern'] as String?,
    );
  }

  final List<String> mainSymptoms;
  final List<String> associatedSymptoms;
  final String? onsetPattern;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'main_symptoms': mainSymptoms,
    'associated_symptoms': associatedSymptoms,
    'onset_pattern': onsetPattern,
  };
}

final class DiagnosticCriteriaInfoDto {
  const DiagnosticCriteriaInfoDto({
    required this.required,
    required this.supporting,
    required this.notes,
  });

  factory DiagnosticCriteriaInfoDto.fromJson(Map<String, dynamic> json) {
    return DiagnosticCriteriaInfoDto(
      required: _stringList(json['required']),
      supporting: _stringList(json['supporting']),
      notes: json['notes'] as String?,
    );
  }

  final List<String> required;
  final List<String> supporting;
  final String? notes;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'required': required,
    'supporting': supporting,
    'notes': notes,
  };
}

final class ExamDto {
  const ExamDto({
    required this.name,
    required this.category,
    required this.typicalFinding,
    required this.referenceRange,
  });

  factory ExamDto.fromJson(Map<String, dynamic> json) {
    return ExamDto(
      name: json['name'] as String,
      category: json['category'] as String,
      typicalFinding: json['typical_finding'] as String,
      referenceRange: json['reference_range'] as String?,
    );
  }

  final String name;
  final String category;
  final String typicalFinding;
  final String? referenceRange;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'category': category,
    'typical_finding': typicalFinding,
    'reference_range': referenceRange,
  };
}

final class SeverityInfoDto {
  const SeverityInfoDto({
    required this.gradingSystem,
    required this.grades,
  });

  factory SeverityInfoDto.fromJson(Map<String, dynamic> json) {
    return SeverityInfoDto(
      gradingSystem: json['grading_system'] as String,
      grades: _mapList(json['grades'], GradeDto.fromJson),
    );
  }

  final String gradingSystem;
  final List<GradeDto> grades;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'grading_system': gradingSystem,
    'grades': grades.map((item) => item.toJson()).toList(),
  };
}

final class GradeDto {
  const GradeDto({
    required this.label,
    required this.criteria,
    required this.recommendedAction,
  });

  factory GradeDto.fromJson(Map<String, dynamic> json) {
    return GradeDto(
      label: json['label'] as String,
      criteria: json['criteria'] as String,
      recommendedAction: json['recommended_action'] as String,
    );
  }

  final String label;
  final String criteria;
  final String recommendedAction;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'label': label,
    'criteria': criteria,
    'recommended_action': recommendedAction,
  };
}

final class TreatmentInfoDto {
  const TreatmentInfoDto({
    required this.pharmacological,
    required this.nonPharmacological,
    required this.acutePhaseProtocol,
  });

  factory TreatmentInfoDto.fromJson(Map<String, dynamic> json) {
    return TreatmentInfoDto(
      pharmacological: _mapList(
        json['pharmacological'],
        PharmaTreatmentDto.fromJson,
      ),
      nonPharmacological: _mapList(
        json['non_pharmacological'],
        TreatmentSectionDto.fromJson,
      ),
      acutePhaseProtocol: _mapList(
        json['acute_phase_protocol'],
        ProtocolStepDto.fromJson,
      ),
    );
  }

  final List<PharmaTreatmentDto> pharmacological;
  final List<TreatmentSectionDto> nonPharmacological;
  final List<ProtocolStepDto> acutePhaseProtocol;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'pharmacological': pharmacological.map((item) => item.toJson()).toList(),
    'non_pharmacological': nonPharmacological
        .map((item) => item.toJson())
        .toList(),
    'acute_phase_protocol': acutePhaseProtocol
        .map((item) => item.toJson())
        .toList(),
  };
}

final class PharmaTreatmentDto {
  const PharmaTreatmentDto({
    required this.drugCategory,
    required this.drugIds,
    required this.indication,
    required this.notes,
  });

  factory PharmaTreatmentDto.fromJson(Map<String, dynamic> json) {
    return PharmaTreatmentDto(
      drugCategory: json['drug_category'] as String,
      drugIds: _stringList(json['drug_ids']),
      indication: json['indication'] as String,
      notes: json['notes'] as String,
    );
  }

  final String drugCategory;
  final List<String> drugIds;
  final String indication;
  final String notes;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'drug_category': drugCategory,
    'drug_ids': drugIds,
    'indication': indication,
    'notes': notes,
  };
}

final class TreatmentSectionDto {
  const TreatmentSectionDto({
    required this.heading,
    required this.items,
    required this.description,
  });

  factory TreatmentSectionDto.fromJson(Map<String, dynamic> json) {
    return TreatmentSectionDto(
      heading: json['heading'] as String,
      items: _stringList(json['items']),
      description: json['description'] as String?,
    );
  }

  final String heading;
  final List<String> items;
  final String? description;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'heading': heading,
    'items': items,
    'description': description,
  };
}

final class ProtocolStepDto {
  const ProtocolStepDto({
    required this.order,
    required this.action,
    required this.target,
  });

  factory ProtocolStepDto.fromJson(Map<String, dynamic> json) {
    return ProtocolStepDto(
      order: json['order'] as int,
      action: json['action'] as String,
      target: json['target'] as String?,
    );
  }

  final int order;
  final String action;
  final String? target;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'order': order,
    'action': action,
    'target': target,
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

T? _nullableMap<T>(Object? value, T Function(Map<String, dynamic>) fromJson) {
  return value == null ? null : fromJson(value as Map<String, dynamic>);
}
