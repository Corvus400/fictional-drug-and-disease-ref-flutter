import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';

/// Extracts a bookmark/list snapshot from a disease detail.
DiseaseSummary diseaseSummaryFromDisease(Disease disease) {
  return DiseaseSummary(
    id: disease.id,
    name: disease.name,
    icd10Chapter: disease.icd10Chapter,
    medicalDepartment: disease.medicalDepartment,
    chronicity: disease.chronicity,
    infectious: disease.infectious,
    nameKana: disease.nameKana,
    revisedAt: disease.revisedAt,
  );
}
