// The nested OpenAPI schema exposes many small value types; documenting each
// field would duplicate schema names without adding useful context.
// ignore_for_file: public_member_api_docs

typedef JsonObject = Map<String, Object?>;

final class EpidemiologyInfo {
  const EpidemiologyInfo({
    required this.prevalence,
    required this.onsetAgeRange,
    required this.sexRatio,
    required this.riskFactors,
  });

  final Prevalence? prevalence;
  final OnsetAgeRange? onsetAgeRange;
  final SexDistribution? sexRatio;
  final List<String> riskFactors;

  JsonObject toJson() => <String, Object?>{
    'prevalence': prevalence?.toJson(),
    'onset_age_range': onsetAgeRange?.toJson(),
    'sex_ratio': sexRatio?.toJson(),
    'risk_factors': riskFactors,
  };
}

final class Prevalence {
  const Prevalence({
    required this.rate,
    required this.denominator,
    required this.unit,
    required this.label,
  });

  final double? rate;
  final int? denominator;
  final String unit;
  final String label;

  JsonObject toJson() => <String, Object?>{
    'rate': rate,
    'denominator': denominator,
    'unit': unit,
    'label': label,
  };
}

final class OnsetAgeRange {
  const OnsetAgeRange({
    required this.minAgeYears,
    required this.maxAgeYears,
    required this.label,
  });

  final int? minAgeYears;
  final int? maxAgeYears;
  final String label;

  JsonObject toJson() => <String, Object?>{
    'min_age_years': minAgeYears,
    'max_age_years': maxAgeYears,
    'label': label,
  };
}

final class SexDistribution {
  const SexDistribution({
    required this.maleRatio,
    required this.femaleRatio,
    required this.note,
  });

  final int maleRatio;
  final int femaleRatio;
  final String? note;

  JsonObject toJson() => <String, Object?>{
    'male_ratio': maleRatio,
    'female_ratio': femaleRatio,
    'note': note,
  };
}

final class SymptomInfo {
  const SymptomInfo({
    required this.mainSymptoms,
    required this.associatedSymptoms,
    required this.onsetPattern,
  });

  final List<String> mainSymptoms;
  final List<String> associatedSymptoms;
  final String? onsetPattern;

  JsonObject toJson() => <String, Object?>{
    'main_symptoms': mainSymptoms,
    'associated_symptoms': associatedSymptoms,
    'onset_pattern': onsetPattern,
  };
}

final class DiagnosticCriteriaInfo {
  const DiagnosticCriteriaInfo({
    required this.required,
    required this.supporting,
    required this.notes,
  });

  final List<String> required;
  final List<String> supporting;
  final String? notes;

  JsonObject toJson() => <String, Object?>{
    'required': required,
    'supporting': supporting,
    'notes': notes,
  };
}

final class Exam {
  const Exam({
    required this.name,
    required this.category,
    required this.typicalFinding,
    required this.referenceRange,
  });

  final String name;
  final String category;
  final String typicalFinding;
  final String? referenceRange;

  JsonObject toJson() => <String, Object?>{
    'name': name,
    'category': category,
    'typical_finding': typicalFinding,
    'reference_range': referenceRange,
  };
}

final class SeverityInfo {
  const SeverityInfo({
    required this.gradingSystem,
    required this.grades,
  });

  final String gradingSystem;
  final List<Grade> grades;

  JsonObject toJson() => <String, Object?>{
    'grading_system': gradingSystem,
    'grades': _toJsonList(grades, (item) => item.toJson()),
  };
}

final class Grade {
  const Grade({
    required this.label,
    required this.criteria,
    required this.recommendedAction,
  });

  final String label;
  final String criteria;
  final String recommendedAction;

  JsonObject toJson() => <String, Object?>{
    'label': label,
    'criteria': criteria,
    'recommended_action': recommendedAction,
  };
}

final class TreatmentInfo {
  const TreatmentInfo({
    required this.pharmacological,
    required this.nonPharmacological,
    required this.acutePhaseProtocol,
  });

  final List<PharmaTreatment> pharmacological;
  final List<TreatmentSection> nonPharmacological;
  final List<ProtocolStep> acutePhaseProtocol;

  JsonObject toJson() => <String, Object?>{
    'pharmacological': _toJsonList(pharmacological, (item) => item.toJson()),
    'non_pharmacological': _toJsonList(
      nonPharmacological,
      (item) => item.toJson(),
    ),
    'acute_phase_protocol': _toJsonList(
      acutePhaseProtocol,
      (item) => item.toJson(),
    ),
  };
}

final class PharmaTreatment {
  const PharmaTreatment({
    required this.drugCategory,
    required this.drugIds,
    required this.indication,
    required this.notes,
  });

  final String drugCategory;
  final List<String> drugIds;
  final String indication;
  final String notes;

  JsonObject toJson() => <String, Object?>{
    'drug_category': drugCategory,
    'drug_ids': drugIds,
    'indication': indication,
    'notes': notes,
  };
}

final class TreatmentSection {
  const TreatmentSection({
    required this.heading,
    required this.items,
    required this.description,
  });

  final String heading;
  final List<String> items;
  final String? description;

  JsonObject toJson() => <String, Object?>{
    'heading': heading,
    'items': items,
    'description': description,
  };
}

final class ProtocolStep {
  const ProtocolStep({
    required this.order,
    required this.action,
    required this.target,
  });

  final int order;
  final String action;
  final String? target;

  JsonObject toJson() => <String, Object?>{
    'order': order,
    'action': action,
    'target': target,
  };
}

List<JsonObject> _toJsonList<T>(
  Iterable<T> items,
  JsonObject Function(T item) toJson,
) {
  return items.map(toJson).toList(growable: false);
}
