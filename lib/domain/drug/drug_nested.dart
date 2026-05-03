// The nested OpenAPI schema exposes many marker-like value types; documenting
// each one would duplicate the schema names without adding useful context.
// ignore_for_file: public_member_api_docs

/// JSON-backed nested drug detail value object.
abstract base class DrugNestedJson {
  /// Creates a JSON-backed nested value.
  const DrugNestedJson(this.json);

  /// Raw JSON payload for UI-specific rendering.
  final Map<String, dynamic> json;

  /// Converts this value back to JSON.
  Map<String, dynamic> toJson() => json;
}

final class CompositionInfo extends DrugNestedJson {
  const CompositionInfo(super.json);
}

final class NumberedParagraph extends DrugNestedJson {
  const NumberedParagraph(super.json);
}

final class IndicationItem extends DrugNestedJson {
  const IndicationItem(super.json);
}

final class DosageInfo extends DrugNestedJson {
  const DosageInfo(super.json);
}

final class PrecautionPopulation extends DrugNestedJson {
  const PrecautionPopulation(super.json);
}

final class InteractionInfo extends DrugNestedJson {
  const InteractionInfo(super.json);
}

final class AdverseReactionInfo extends DrugNestedJson {
  const AdverseReactionInfo(super.json);
}

final class OverdoseInfo extends DrugNestedJson {
  const OverdoseInfo(super.json);
}

final class PharmacokineticsInfo extends DrugNestedJson {
  const PharmacokineticsInfo(super.json);
}

final class ClinicalResultSection extends DrugNestedJson {
  const ClinicalResultSection(super.json);
}

final class PharmacologyInfo extends DrugNestedJson {
  const PharmacologyInfo(super.json);
}

final class PhysicochemicalInfo extends DrugNestedJson {
  const PhysicochemicalInfo(super.json);
}

final class PackageInfo extends DrugNestedJson {
  const PackageInfo(super.json);
}

final class Reference extends DrugNestedJson {
  const Reference(super.json);
}
