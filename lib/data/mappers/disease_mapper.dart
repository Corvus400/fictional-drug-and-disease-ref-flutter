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
      epidemiology: epidemiology?.toDomain(),
      etiology: etiology,
      symptoms: symptoms.toDomain(),
      diagnosticCriteria: diagnosticCriteria.toDomain(),
      requiredExams: requiredExams
          .map((item) => item.toDomain())
          .toList(growable: false),
      severityGrading: severityGrading?.toDomain(),
      differentialDiagnoses: differentialDiagnoses,
      complications: complications,
      treatments: treatments.toDomain(),
      prognosis: prognosis,
      prevention: prevention,
      relatedDrugIds: relatedDrugIds,
      relatedDiseaseIds: relatedDiseaseIds,
      revisedAt: revisedAt,
      disclaimer: disclaimer,
    );
  }
}

extension on EpidemiologyInfoDto {
  EpidemiologyInfo toDomain() {
    return EpidemiologyInfo(
      prevalence: prevalence?.toDomain(),
      onsetAgeRange: onsetAgeRange?.toDomain(),
      sexRatio: sexRatio?.toDomain(),
      riskFactors: riskFactors,
    );
  }
}

extension on PrevalenceDto {
  Prevalence toDomain() {
    return Prevalence(
      rate: rate,
      denominator: denominator,
      unit: unit,
      label: label,
    );
  }
}

extension on OnsetAgeRangeDto {
  OnsetAgeRange toDomain() {
    return OnsetAgeRange(
      minAgeYears: minAgeYears,
      maxAgeYears: maxAgeYears,
      label: label,
    );
  }
}

extension on SexDistributionDto {
  SexDistribution toDomain() {
    return SexDistribution(
      maleRatio: maleRatio,
      femaleRatio: femaleRatio,
      note: note,
    );
  }
}

extension on SymptomInfoDto {
  SymptomInfo toDomain() {
    return SymptomInfo(
      mainSymptoms: mainSymptoms,
      associatedSymptoms: associatedSymptoms,
      onsetPattern: onsetPattern,
    );
  }
}

extension on DiagnosticCriteriaInfoDto {
  DiagnosticCriteriaInfo toDomain() {
    return DiagnosticCriteriaInfo(
      required: required,
      supporting: supporting,
      notes: notes,
    );
  }
}

extension on ExamDto {
  Exam toDomain() {
    return Exam(
      name: name,
      category: category,
      typicalFinding: typicalFinding,
      referenceRange: referenceRange,
    );
  }
}

extension on SeverityInfoDto {
  SeverityInfo toDomain() {
    return SeverityInfo(
      gradingSystem: gradingSystem,
      grades: grades.map((item) => item.toDomain()).toList(growable: false),
    );
  }
}

extension on GradeDto {
  Grade toDomain() {
    return Grade(
      label: label,
      criteria: criteria,
      recommendedAction: recommendedAction,
    );
  }
}

extension on TreatmentInfoDto {
  TreatmentInfo toDomain() {
    return TreatmentInfo(
      pharmacological: pharmacological
          .map((item) => item.toDomain())
          .toList(growable: false),
      nonPharmacological: nonPharmacological
          .map((item) => item.toDomain())
          .toList(growable: false),
      acutePhaseProtocol: acutePhaseProtocol
          .map((item) => item.toDomain())
          .toList(growable: false),
    );
  }
}

extension on PharmaTreatmentDto {
  PharmaTreatment toDomain() {
    return PharmaTreatment(
      drugCategory: drugCategory,
      drugIds: drugIds,
      indication: indication,
      notes: notes,
    );
  }
}

extension on TreatmentSectionDto {
  TreatmentSection toDomain() {
    return TreatmentSection(
      heading: heading,
      items: items,
      description: description,
    );
  }
}

extension on ProtocolStepDto {
  ProtocolStep toDomain() {
    return ProtocolStep(order: order, action: action, target: target);
  }
}
