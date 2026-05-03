import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_summary_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const summaryDto = DiseaseSummaryDto(
    id: 'disease_0001',
    name: '疾患名',
    icd10Chapter: 'chapter_i',
    medicalDepartment: ['infectious_disease'],
    chronicity: 'acute',
    infectious: true,
    nameKana: 'シッカンメイ',
    revisedAt: '2026-05-01',
  );

  test('toDomain maps DiseaseSummaryDto fields', () {
    final summary = summaryDto.toDomain();

    expect(summary.id, summaryDto.id);
    expect(summary.name, summaryDto.name);
    expect(summary.icd10Chapter, summaryDto.icd10Chapter);
    expect(summary.medicalDepartment, summaryDto.medicalDepartment);
    expect(summary.chronicity, summaryDto.chronicity);
    expect(summary.infectious, summaryDto.infectious);
    expect(summary.nameKana, summaryDto.nameKana);
    expect(summary.revisedAt, summaryDto.revisedAt);
  });

  test('toDomain extracts DiseaseListPage disclaimer and items', () {
    const dto = DiseaseListResponseDto(
      items: [summaryDto],
      page: 1,
      pageSize: 20,
      totalPages: 4,
      totalCount: 80,
      disclaimer: 'FICTIONAL DATA',
    );

    final page = dto.toDomain();

    expect(page.items.single.id, 'disease_0001');
    expect(page.totalCount, 80);
    expect(page.disclaimer, 'FICTIONAL DATA');
  });

  test('toDomain maps DiseaseDto root fields', () {
    const dto = DiseaseDto(
      id: 'disease_0001',
      name: '疾患名',
      nameKana: 'シッカンメイ',
      nameEnglish: null,
      icd10Chapter: 'chapter_i',
      medicalDepartment: ['infectious_disease'],
      chronicity: 'acute',
      infectious: true,
      synonyms: [],
      summary: '概要',
      epidemiology: null,
      etiology: '原因',
      symptoms: SymptomInfoDto(
        mainSymptoms: ['症状'],
        associatedSymptoms: [],
        onsetPattern: null,
      ),
      diagnosticCriteria: DiagnosticCriteriaInfoDto(
        required: ['基準'],
        supporting: [],
        notes: null,
      ),
      requiredExams: [],
      severityGrading: null,
      differentialDiagnoses: [],
      complications: [],
      treatments: TreatmentInfoDto(
        pharmacological: [],
        nonPharmacological: [],
        acutePhaseProtocol: [],
      ),
      prognosis: null,
      prevention: [],
      relatedDrugIds: ['drug_0001'],
      relatedDiseaseIds: [],
      revisedAt: '2026-05-01',
      disclaimer: 'FICTIONAL DATA',
    );

    final disease = dto.toDomain();

    expect(disease.id, dto.id);
    expect(disease.name, dto.name);
    expect(disease.symptoms, isA<SymptomInfo>());
    expect(disease.diagnosticCriteria, isA<DiagnosticCriteriaInfo>());
    expect(disease.treatments, isA<TreatmentInfo>());
    expect(disease.relatedDrugIds, dto.relatedDrugIds);
    expect(disease.disclaimer, dto.disclaimer);
  });
}
