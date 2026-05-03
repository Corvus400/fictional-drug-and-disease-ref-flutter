import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_summary_dto.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';

/// Disease summary mapping helpers.
extension DiseaseSummaryDtoMapper on DiseaseSummaryDto {
  /// Maps this DTO to a domain model.
  DiseaseSummary toDomain() {
    return DiseaseSummary(
      id: id,
      name: name,
      icd10Chapter: icd10Chapter,
      medicalDepartment: medicalDepartment,
      chronicity: chronicity,
      infectious: infectious,
      nameKana: nameKana,
      revisedAt: revisedAt,
    );
  }
}

/// Disease list response mapping helpers.
extension DiseaseListResponseDtoMapper on DiseaseListResponseDto {
  /// Maps this DTO to a domain model.
  DiseaseListPage toDomain() {
    return DiseaseListPage(
      items: items.map((item) => item.toDomain()).toList(growable: false),
      page: page,
      pageSize: pageSize,
      totalPages: totalPages,
      totalCount: totalCount,
      disclaimer: disclaimer,
    );
  }
}

/// Disease detail mapping helpers.
extension DiseaseDtoMapper on DiseaseDto {
  /// Maps this DTO to a domain model.
  Disease toDomain() {
    return Disease(
      id: id,
      name: name,
      nameKana: nameKana,
      nameEnglish: nameEnglish,
      icd10Chapter: icd10Chapter,
      medicalDepartment: medicalDepartment,
      chronicity: chronicity,
      infectious: infectious,
      synonyms: synonyms,
      summary: summary,
      epidemiology: epidemiology,
      etiology: etiology,
      symptoms: symptoms,
      diagnosticCriteria: diagnosticCriteria,
      requiredExams: requiredExams,
      severityGrading: severityGrading,
      differentialDiagnoses: differentialDiagnoses,
      complications: complications,
      treatments: treatments,
      prognosis: prognosis,
      prevention: prevention,
      relatedDrugIds: relatedDrugIds,
      relatedDiseaseIds: relatedDiseaseIds,
      revisedAt: revisedAt,
      disclaimer: disclaimer,
    );
  }
}
