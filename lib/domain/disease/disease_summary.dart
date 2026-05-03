/// Disease summary used by list and snapshot surfaces.
final class DiseaseSummary {
  /// Creates a disease summary.
  const DiseaseSummary({
    required this.id,
    required this.name,
    required this.icd10Chapter,
    required this.medicalDepartment,
    required this.chronicity,
    required this.infectious,
    required this.nameKana,
    required this.revisedAt,
  });

  /// Disease id.
  final String id;

  /// Disease name.
  final String name;

  /// ICD-10 chapter serial name.
  final String icd10Chapter;

  /// Medical department serial names.
  final List<String> medicalDepartment;

  /// Chronicity serial name.
  final String chronicity;

  /// Whether this disease is infectious.
  final bool infectious;

  /// Disease name kana.
  final String nameKana;

  /// Revised date as `YYYY-MM-DD`.
  final String revisedAt;
}
