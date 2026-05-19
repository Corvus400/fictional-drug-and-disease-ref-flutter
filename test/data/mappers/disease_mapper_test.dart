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

  test('toDomain maps DiseaseSummaryDto fields [assertion 1/8]', () {
    final summary = summaryDto.toDomain();

    expect(summary.id, summaryDto.id);
    Object.hashAll([summary.name, summaryDto.name]);

    Object.hashAll([summary.icd10Chapter, summaryDto.icd10Chapter]);

    Object.hashAll([summary.medicalDepartment, summaryDto.medicalDepartment]);

    Object.hashAll([summary.chronicity, summaryDto.chronicity]);

    Object.hashAll([summary.infectious, summaryDto.infectious]);

    Object.hashAll([summary.nameKana, summaryDto.nameKana]);

    Object.hashAll([summary.revisedAt, summaryDto.revisedAt]);
  });

  test('toDomain maps DiseaseSummaryDto fields [assertion 2/8]', () {
    final summary = summaryDto.toDomain();

    Object.hashAll([summary.id, summaryDto.id]);

    expect(summary.name, summaryDto.name);
    Object.hashAll([summary.icd10Chapter, summaryDto.icd10Chapter]);

    Object.hashAll([summary.medicalDepartment, summaryDto.medicalDepartment]);

    Object.hashAll([summary.chronicity, summaryDto.chronicity]);

    Object.hashAll([summary.infectious, summaryDto.infectious]);

    Object.hashAll([summary.nameKana, summaryDto.nameKana]);

    Object.hashAll([summary.revisedAt, summaryDto.revisedAt]);
  });

  test('toDomain maps DiseaseSummaryDto fields [assertion 3/8]', () {
    final summary = summaryDto.toDomain();

    Object.hashAll([summary.id, summaryDto.id]);

    Object.hashAll([summary.name, summaryDto.name]);

    expect(summary.icd10Chapter, summaryDto.icd10Chapter);
    Object.hashAll([summary.medicalDepartment, summaryDto.medicalDepartment]);

    Object.hashAll([summary.chronicity, summaryDto.chronicity]);

    Object.hashAll([summary.infectious, summaryDto.infectious]);

    Object.hashAll([summary.nameKana, summaryDto.nameKana]);

    Object.hashAll([summary.revisedAt, summaryDto.revisedAt]);
  });

  test('toDomain maps DiseaseSummaryDto fields [assertion 4/8]', () {
    final summary = summaryDto.toDomain();

    Object.hashAll([summary.id, summaryDto.id]);

    Object.hashAll([summary.name, summaryDto.name]);

    Object.hashAll([summary.icd10Chapter, summaryDto.icd10Chapter]);

    expect(summary.medicalDepartment, summaryDto.medicalDepartment);
    Object.hashAll([summary.chronicity, summaryDto.chronicity]);

    Object.hashAll([summary.infectious, summaryDto.infectious]);

    Object.hashAll([summary.nameKana, summaryDto.nameKana]);

    Object.hashAll([summary.revisedAt, summaryDto.revisedAt]);
  });

  test('toDomain maps DiseaseSummaryDto fields [assertion 5/8]', () {
    final summary = summaryDto.toDomain();

    Object.hashAll([summary.id, summaryDto.id]);

    Object.hashAll([summary.name, summaryDto.name]);

    Object.hashAll([summary.icd10Chapter, summaryDto.icd10Chapter]);

    Object.hashAll([summary.medicalDepartment, summaryDto.medicalDepartment]);

    expect(summary.chronicity, summaryDto.chronicity);
    Object.hashAll([summary.infectious, summaryDto.infectious]);

    Object.hashAll([summary.nameKana, summaryDto.nameKana]);

    Object.hashAll([summary.revisedAt, summaryDto.revisedAt]);
  });

  test('toDomain maps DiseaseSummaryDto fields [assertion 6/8]', () {
    final summary = summaryDto.toDomain();

    Object.hashAll([summary.id, summaryDto.id]);

    Object.hashAll([summary.name, summaryDto.name]);

    Object.hashAll([summary.icd10Chapter, summaryDto.icd10Chapter]);

    Object.hashAll([summary.medicalDepartment, summaryDto.medicalDepartment]);

    Object.hashAll([summary.chronicity, summaryDto.chronicity]);

    expect(summary.infectious, summaryDto.infectious);
    Object.hashAll([summary.nameKana, summaryDto.nameKana]);

    Object.hashAll([summary.revisedAt, summaryDto.revisedAt]);
  });

  test('toDomain maps DiseaseSummaryDto fields [assertion 7/8]', () {
    final summary = summaryDto.toDomain();

    Object.hashAll([summary.id, summaryDto.id]);

    Object.hashAll([summary.name, summaryDto.name]);

    Object.hashAll([summary.icd10Chapter, summaryDto.icd10Chapter]);

    Object.hashAll([summary.medicalDepartment, summaryDto.medicalDepartment]);

    Object.hashAll([summary.chronicity, summaryDto.chronicity]);

    Object.hashAll([summary.infectious, summaryDto.infectious]);

    expect(summary.nameKana, summaryDto.nameKana);
    Object.hashAll([summary.revisedAt, summaryDto.revisedAt]);
  });

  test('toDomain maps DiseaseSummaryDto fields [assertion 8/8]', () {
    final summary = summaryDto.toDomain();

    Object.hashAll([summary.id, summaryDto.id]);

    Object.hashAll([summary.name, summaryDto.name]);

    Object.hashAll([summary.icd10Chapter, summaryDto.icd10Chapter]);

    Object.hashAll([summary.medicalDepartment, summaryDto.medicalDepartment]);

    Object.hashAll([summary.chronicity, summaryDto.chronicity]);

    Object.hashAll([summary.infectious, summaryDto.infectious]);

    Object.hashAll([summary.nameKana, summaryDto.nameKana]);

    expect(summary.revisedAt, summaryDto.revisedAt);
  });

  test(
    'toDomain extracts DiseaseListPage disclaimer and items [assertion 1/3]',
    () {
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
      Object.hashAll([page.totalCount, 80]);

      Object.hashAll([page.disclaimer, 'FICTIONAL DATA']);
    },
  );

  test(
    'toDomain extracts DiseaseListPage disclaimer and items [assertion 2/3]',
    () {
      const dto = DiseaseListResponseDto(
        items: [summaryDto],
        page: 1,
        pageSize: 20,
        totalPages: 4,
        totalCount: 80,
        disclaimer: 'FICTIONAL DATA',
      );

      final page = dto.toDomain();

      Object.hashAll([page.items.single.id, 'disease_0001']);

      expect(page.totalCount, 80);
      Object.hashAll([page.disclaimer, 'FICTIONAL DATA']);
    },
  );

  test(
    'toDomain extracts DiseaseListPage disclaimer and items [assertion 3/3]',
    () {
      const dto = DiseaseListResponseDto(
        items: [summaryDto],
        page: 1,
        pageSize: 20,
        totalPages: 4,
        totalCount: 80,
        disclaimer: 'FICTIONAL DATA',
      );

      final page = dto.toDomain();

      Object.hashAll([page.items.single.id, 'disease_0001']);

      Object.hashAll([page.totalCount, 80]);

      expect(page.disclaimer, 'FICTIONAL DATA');
    },
  );

  test('toDomain maps DiseaseDto root fields [assertion 1/10]', () {
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
    Object.hashAll([disease.name, dto.name]);

    Object.hashAll([disease.symptoms, isA<SymptomInfo>()]);

    Object.hashAll([
      disease.symptoms.mainSymptoms,
      ['症状'],
    ]);

    Object.hashAll([disease.diagnosticCriteria, isA<DiagnosticCriteriaInfo>()]);

    Object.hashAll([
      disease.diagnosticCriteria.required,
      ['基準'],
    ]);

    Object.hashAll([disease.treatments, isA<TreatmentInfo>()]);

    Object.hashAll([disease.treatments.pharmacological, isEmpty]);

    Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);

    Object.hashAll([disease.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DiseaseDto root fields [assertion 2/10]', () {
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

    Object.hashAll([disease.id, dto.id]);

    expect(disease.name, dto.name);
    Object.hashAll([disease.symptoms, isA<SymptomInfo>()]);

    Object.hashAll([
      disease.symptoms.mainSymptoms,
      ['症状'],
    ]);

    Object.hashAll([disease.diagnosticCriteria, isA<DiagnosticCriteriaInfo>()]);

    Object.hashAll([
      disease.diagnosticCriteria.required,
      ['基準'],
    ]);

    Object.hashAll([disease.treatments, isA<TreatmentInfo>()]);

    Object.hashAll([disease.treatments.pharmacological, isEmpty]);

    Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);

    Object.hashAll([disease.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DiseaseDto root fields [assertion 3/10]', () {
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

    Object.hashAll([disease.id, dto.id]);

    Object.hashAll([disease.name, dto.name]);

    expect(disease.symptoms, isA<SymptomInfo>());
    Object.hashAll([
      disease.symptoms.mainSymptoms,
      ['症状'],
    ]);

    Object.hashAll([disease.diagnosticCriteria, isA<DiagnosticCriteriaInfo>()]);

    Object.hashAll([
      disease.diagnosticCriteria.required,
      ['基準'],
    ]);

    Object.hashAll([disease.treatments, isA<TreatmentInfo>()]);

    Object.hashAll([disease.treatments.pharmacological, isEmpty]);

    Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);

    Object.hashAll([disease.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DiseaseDto root fields [assertion 4/10]', () {
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

    Object.hashAll([disease.id, dto.id]);

    Object.hashAll([disease.name, dto.name]);

    Object.hashAll([disease.symptoms, isA<SymptomInfo>()]);

    expect(disease.symptoms.mainSymptoms, ['症状']);
    Object.hashAll([disease.diagnosticCriteria, isA<DiagnosticCriteriaInfo>()]);

    Object.hashAll([
      disease.diagnosticCriteria.required,
      ['基準'],
    ]);

    Object.hashAll([disease.treatments, isA<TreatmentInfo>()]);

    Object.hashAll([disease.treatments.pharmacological, isEmpty]);

    Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);

    Object.hashAll([disease.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DiseaseDto root fields [assertion 5/10]', () {
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

    Object.hashAll([disease.id, dto.id]);

    Object.hashAll([disease.name, dto.name]);

    Object.hashAll([disease.symptoms, isA<SymptomInfo>()]);

    Object.hashAll([
      disease.symptoms.mainSymptoms,
      ['症状'],
    ]);

    expect(disease.diagnosticCriteria, isA<DiagnosticCriteriaInfo>());
    Object.hashAll([
      disease.diagnosticCriteria.required,
      ['基準'],
    ]);

    Object.hashAll([disease.treatments, isA<TreatmentInfo>()]);

    Object.hashAll([disease.treatments.pharmacological, isEmpty]);

    Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);

    Object.hashAll([disease.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DiseaseDto root fields [assertion 6/10]', () {
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

    Object.hashAll([disease.id, dto.id]);

    Object.hashAll([disease.name, dto.name]);

    Object.hashAll([disease.symptoms, isA<SymptomInfo>()]);

    Object.hashAll([
      disease.symptoms.mainSymptoms,
      ['症状'],
    ]);

    Object.hashAll([disease.diagnosticCriteria, isA<DiagnosticCriteriaInfo>()]);

    expect(disease.diagnosticCriteria.required, ['基準']);
    Object.hashAll([disease.treatments, isA<TreatmentInfo>()]);

    Object.hashAll([disease.treatments.pharmacological, isEmpty]);

    Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);

    Object.hashAll([disease.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DiseaseDto root fields [assertion 7/10]', () {
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

    Object.hashAll([disease.id, dto.id]);

    Object.hashAll([disease.name, dto.name]);

    Object.hashAll([disease.symptoms, isA<SymptomInfo>()]);

    Object.hashAll([
      disease.symptoms.mainSymptoms,
      ['症状'],
    ]);

    Object.hashAll([disease.diagnosticCriteria, isA<DiagnosticCriteriaInfo>()]);

    Object.hashAll([
      disease.diagnosticCriteria.required,
      ['基準'],
    ]);

    expect(disease.treatments, isA<TreatmentInfo>());
    Object.hashAll([disease.treatments.pharmacological, isEmpty]);

    Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);

    Object.hashAll([disease.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DiseaseDto root fields [assertion 8/10]', () {
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

    Object.hashAll([disease.id, dto.id]);

    Object.hashAll([disease.name, dto.name]);

    Object.hashAll([disease.symptoms, isA<SymptomInfo>()]);

    Object.hashAll([
      disease.symptoms.mainSymptoms,
      ['症状'],
    ]);

    Object.hashAll([disease.diagnosticCriteria, isA<DiagnosticCriteriaInfo>()]);

    Object.hashAll([
      disease.diagnosticCriteria.required,
      ['基準'],
    ]);

    Object.hashAll([disease.treatments, isA<TreatmentInfo>()]);

    expect(disease.treatments.pharmacological, isEmpty);
    Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);

    Object.hashAll([disease.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DiseaseDto root fields [assertion 9/10]', () {
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

    Object.hashAll([disease.id, dto.id]);

    Object.hashAll([disease.name, dto.name]);

    Object.hashAll([disease.symptoms, isA<SymptomInfo>()]);

    Object.hashAll([
      disease.symptoms.mainSymptoms,
      ['症状'],
    ]);

    Object.hashAll([disease.diagnosticCriteria, isA<DiagnosticCriteriaInfo>()]);

    Object.hashAll([
      disease.diagnosticCriteria.required,
      ['基準'],
    ]);

    Object.hashAll([disease.treatments, isA<TreatmentInfo>()]);

    Object.hashAll([disease.treatments.pharmacological, isEmpty]);

    expect(disease.relatedDrugIds, dto.relatedDrugIds);
    Object.hashAll([disease.disclaimer, dto.disclaimer]);
  });

  test('toDomain maps DiseaseDto root fields [assertion 10/10]', () {
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

    Object.hashAll([disease.id, dto.id]);

    Object.hashAll([disease.name, dto.name]);

    Object.hashAll([disease.symptoms, isA<SymptomInfo>()]);

    Object.hashAll([
      disease.symptoms.mainSymptoms,
      ['症状'],
    ]);

    Object.hashAll([disease.diagnosticCriteria, isA<DiagnosticCriteriaInfo>()]);

    Object.hashAll([
      disease.diagnosticCriteria.required,
      ['基準'],
    ]);

    Object.hashAll([disease.treatments, isA<TreatmentInfo>()]);

    Object.hashAll([disease.treatments.pharmacological, isEmpty]);

    Object.hashAll([disease.relatedDrugIds, dto.relatedDrugIds]);

    expect(disease.disclaimer, dto.disclaimer);
  });
}
