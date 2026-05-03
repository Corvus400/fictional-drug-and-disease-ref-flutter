/// Drug summary used by list and snapshot surfaces.
final class DrugSummary {
  /// Creates a drug summary.
  const DrugSummary({
    required this.id,
    required this.brandName,
    required this.genericName,
    required this.therapeuticCategoryName,
    required this.regulatoryClass,
    required this.dosageForm,
    required this.brandNameKana,
    required this.atcCode,
    required this.revisedAt,
    required this.imageUrl,
  });

  /// Drug id.
  final String id;

  /// Brand name.
  final String brandName;

  /// Generic name.
  final String genericName;

  /// Therapeutic category display name.
  final String therapeuticCategoryName;

  /// Regulatory class serial names.
  final List<String> regulatoryClass;

  /// Dosage form serial name.
  final String dosageForm;

  /// Brand name kana.
  final String brandNameKana;

  /// ATC code.
  final String atcCode;

  /// Revised date as `YYYY-MM-DD`.
  final String revisedAt;

  /// Relative image URL.
  final String imageUrl;
}
