// The nested OpenAPI schema exposes many marker-like value types; documenting
// each one would duplicate the schema names without adding useful context.
// ignore_for_file: public_member_api_docs

/// JSON-backed nested disease detail value object.
abstract base class DiseaseNestedJson {
  /// Creates a JSON-backed nested value.
  const DiseaseNestedJson(this.json);

  /// Raw JSON payload for UI-specific rendering.
  final Map<String, dynamic> json;

  /// Converts this value back to JSON.
  Map<String, dynamic> toJson() => json;
}

final class EpidemiologyInfo extends DiseaseNestedJson {
  const EpidemiologyInfo(super.json);
}

final class SymptomInfo extends DiseaseNestedJson {
  const SymptomInfo(super.json);
}

final class DiagnosticCriteriaInfo extends DiseaseNestedJson {
  const DiagnosticCriteriaInfo(super.json);
}

final class Exam extends DiseaseNestedJson {
  const Exam(super.json);
}

final class SeverityInfo extends DiseaseNestedJson {
  const SeverityInfo(super.json);
}

final class TreatmentInfo extends DiseaseNestedJson {
  const TreatmentInfo(super.json);
}
