/// Filter category master data.
final class Categories {
  /// Creates filter category master data.
  const Categories({
    required this.atc,
    required this.therapeuticCategories,
    required this.routeOfAdministration,
    required this.dosageForm,
    required this.regulatoryClass,
    required this.icd10Chapters,
    required this.medicalDepartments,
  });

  /// ATC entries.
  final List<AtcEntry> atc;

  /// Therapeutic category entries.
  final List<TherapeuticCategoryEntry> therapeuticCategories;

  /// Route serial names.
  final List<String> routeOfAdministration;

  /// Dosage form serial names.
  final List<String> dosageForm;

  /// Regulatory class serial names.
  final List<String> regulatoryClass;

  /// ICD-10 chapter entries.
  final List<Icd10ChapterEntry> icd10Chapters;

  /// Medical department serial names.
  final List<String> medicalDepartments;
}

/// ATC entry.
final class AtcEntry {
  /// Creates an ATC entry.
  const AtcEntry({required this.code, required this.label});

  /// ATC initial code.
  final String code;

  /// Display label.
  final String label;
}

/// Therapeutic category entry.
final class TherapeuticCategoryEntry {
  /// Creates a therapeutic category entry.
  const TherapeuticCategoryEntry({required this.id, required this.label});

  /// Category id.
  final String id;

  /// Display label.
  final String label;
}

/// ICD-10 chapter entry.
final class Icd10ChapterEntry {
  /// Creates an ICD-10 chapter entry.
  const Icd10ChapterEntry({
    required this.roman,
    required this.code,
    required this.label,
  });

  /// Roman chapter number.
  final String roman;

  /// ICD-10 code range.
  final String code;

  /// Display label.
  final String label;
}
