// OpenAPI DTO fields intentionally mirror the wire schema one-to-one.
// ignore_for_file: public_member_api_docs

/// Disease detail DTO returned by `/v1/diseases/{id}`.
final class DiseaseDto {
  const DiseaseDto({
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

  factory DiseaseDto.fromJson(Map<String, dynamic> json) {
    return DiseaseDto(
      id: json['id'] as String,
      name: json['name'] as String,
      nameKana: json['name_kana'] as String,
      nameEnglish: json['name_english'] as String?,
      icd10Chapter: json['icd10_chapter'] as String,
      medicalDepartment: _stringList(json['medical_department']),
      chronicity: json['chronicity'] as String,
      infectious: json['infectious'] as bool,
      synonyms: _stringList(json['synonyms']),
      summary: json['summary'] as String,
      epidemiology: _nullableMap(json['epidemiology']),
      etiology: json['etiology'] as String,
      symptoms: _nullableMap(json['symptoms'])!,
      diagnosticCriteria: _nullableMap(json['diagnostic_criteria'])!,
      requiredExams: _mapList(json['required_exams']),
      severityGrading: _nullableMap(json['severity_grading']),
      differentialDiagnoses: _stringList(json['differential_diagnoses']),
      complications: _stringList(json['complications']),
      treatments: _nullableMap(json['treatments'])!,
      prognosis: json['prognosis'] as String?,
      prevention: _stringList(json['prevention']),
      relatedDrugIds: _stringList(json['related_drug_ids']),
      relatedDiseaseIds: _stringList(json['related_disease_ids']),
      revisedAt: json['revised_at'] as String,
      disclaimer: json['disclaimer'] as String,
    );
  }

  final String id;
  final String name;
  final String nameKana;
  final String? nameEnglish;
  final String icd10Chapter;
  final List<String> medicalDepartment;
  final String chronicity;
  final bool infectious;
  final List<String> synonyms;
  final String summary;
  final Map<String, dynamic>? epidemiology;
  final String etiology;
  final Map<String, dynamic> symptoms;
  final Map<String, dynamic> diagnosticCriteria;
  final List<Map<String, dynamic>> requiredExams;
  final Map<String, dynamic>? severityGrading;
  final List<String> differentialDiagnoses;
  final List<String> complications;
  final Map<String, dynamic> treatments;
  final String? prognosis;
  final List<String> prevention;
  final List<String> relatedDrugIds;
  final List<String> relatedDiseaseIds;
  final String revisedAt;
  final String disclaimer;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'name_kana': nameKana,
      'name_english': nameEnglish,
      'icd10_chapter': icd10Chapter,
      'medical_department': medicalDepartment,
      'chronicity': chronicity,
      'infectious': infectious,
      'synonyms': synonyms,
      'summary': summary,
      'epidemiology': epidemiology,
      'etiology': etiology,
      'symptoms': symptoms,
      'diagnostic_criteria': diagnosticCriteria,
      'required_exams': requiredExams,
      'severity_grading': severityGrading,
      'differential_diagnoses': differentialDiagnoses,
      'complications': complications,
      'treatments': treatments,
      'prognosis': prognosis,
      'prevention': prevention,
      'related_drug_ids': relatedDrugIds,
      'related_disease_ids': relatedDiseaseIds,
      'revised_at': revisedAt,
      'disclaimer': disclaimer,
    };
  }
}

List<String> _stringList(Object? value) {
  if (value == null) {
    throw const FormatException('Expected a JSON list.');
  }
  return (value as List<dynamic>).cast<String>();
}

List<Map<String, dynamic>> _mapList(Object? value) {
  if (value == null) {
    throw const FormatException('Expected a JSON list.');
  }
  return (value as List<dynamic>).cast<Map<String, dynamic>>();
}

Map<String, dynamic>? _nullableMap(Object? value) {
  return value == null ? null : value as Map<String, dynamic>;
}
