import 'package:fictional_drug_and_disease_ref/domain/disease/disease_nested.dart';

export 'package:fictional_drug_and_disease_ref/domain/disease/disease_nested.dart';

/// Disease detail used by detail surfaces and use cases.
final class Disease {
  /// Creates a disease detail.
  const Disease({
    required this.id,
    required this.name,
    required this.nameKana,
    required this.nameEnglish,
    required this.icd10Chapter,
    required this.medicalDepartment,
    required this.chronicity,
    required this.infectious,
    required this.synonyms,
    required this.summary,
    required this.epidemiology,
    required this.etiology,
    required this.symptoms,
    required this.diagnosticCriteria,
    required this.requiredExams,
    required this.severityGrading,
    required this.differentialDiagnoses,
    required this.complications,
    required this.treatments,
    required this.prognosis,
    required this.prevention,
    required this.relatedDrugIds,
    required this.relatedDiseaseIds,
    required this.revisedAt,
    required this.disclaimer,
  });

  /// Disease id.
  final String id;

  /// Disease name.
  final String name;

  /// Disease name kana.
  final String nameKana;

  /// Optional English name.
  final String? nameEnglish;

  /// ICD-10 chapter serial name.
  final String icd10Chapter;

  /// Medical department serial names.
  final List<String> medicalDepartment;

  /// Chronicity serial name.
  final String chronicity;

  /// Whether this disease is infectious.
  final bool infectious;

  /// Synonym names.
  final List<String> synonyms;

  /// Summary markdown.
  final String summary;

  /// Optional epidemiology info.
  final EpidemiologyInfo? epidemiology;

  /// Etiology markdown.
  final String etiology;

  /// Symptoms.
  final SymptomInfo symptoms;

  /// Diagnostic criteria.
  final DiagnosticCriteriaInfo diagnosticCriteria;

  /// Required exam entries.
  final List<Exam> requiredExams;

  /// Optional severity grading.
  final SeverityInfo? severityGrading;

  /// Differential diagnoses.
  final List<String> differentialDiagnoses;

  /// Complications.
  final List<String> complications;

  /// Treatments.
  final TreatmentInfo treatments;

  /// Optional prognosis markdown.
  final String? prognosis;

  /// Prevention items.
  final List<String> prevention;

  /// Related drug ids.
  final List<String> relatedDrugIds;

  /// Related disease ids.
  final List<String> relatedDiseaseIds;

  /// Revised date as `YYYY-MM-DD`.
  final String revisedAt;

  /// Response disclaimer.
  final String disclaimer;
}
