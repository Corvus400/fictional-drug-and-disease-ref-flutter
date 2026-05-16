import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';

/// Disease keyword search target.
enum DiseaseKeywordTarget {
  /// Disease name.
  name('name'),

  /// English name.
  nameEnglish('name_english'),

  /// Synonyms.
  synonyms('synonyms'),

  /// Name, synonyms, symptoms and ICD-10 fields.
  all('all')
  ;

  const DiseaseKeywordTarget(this.serialName);

  /// Wire value.
  final String serialName;
}

/// Disease sort key.
enum DiseaseSort {
  /// Revised date descending.
  revisedAtDesc('-revised_at'),

  /// Disease name kana.
  nameKana('name_kana'),

  /// ICD-10 chapter.
  icd10Chapter('icd10_chapter')
  ;

  const DiseaseSort(this.serialName);

  /// Wire value.
  final String serialName;
}

/// Search parameters for `/v1/diseases`.
final class DiseaseSearchParams {
  /// Creates disease search parameters.
  const DiseaseSearchParams({
    this.page,
    this.pageSize,
    this.icd10Chapter,
    this.department,
    this.chronicity,
    this.infectious,
    this.keyword,
    this.keywordMatch,
    this.keywordTarget,
    this.symptomKeyword,
    this.onsetPattern,
    this.examCategory,
    this.hasPharmacologicalTreatment,
    this.hasSeverityGrading,
    this.sort,
  });

  /// Page number.
  final int? page;

  /// Page size.
  final int? pageSize;

  /// ICD-10 chapter serial names.
  final List<String>? icd10Chapter;

  /// Medical department serial names.
  final List<String>? department;

  /// Chronicity serial names.
  final List<String>? chronicity;

  /// Infectious filter.
  final bool? infectious;

  /// Keyword.
  final String? keyword;

  /// Keyword match mode.
  final KeywordMatch? keywordMatch;

  /// Keyword target.
  final DiseaseKeywordTarget? keywordTarget;

  /// Symptom keyword.
  final String? symptomKeyword;

  /// Onset pattern enum constant names.
  final List<String>? onsetPattern;

  /// Exam category enum constant names.
  final List<String>? examCategory;

  /// Pharmacological treatment filter.
  final bool? hasPharmacologicalTreatment;

  /// Severity grading filter.
  final bool? hasSeverityGrading;

  /// Sort key.
  final DiseaseSort? sort;
}
