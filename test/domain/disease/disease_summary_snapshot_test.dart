import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary_from_disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary_from_json.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Disease summary snapshot functions', () {
    test('diseaseSummaryFromDisease extracts summary fields', () {
      final disease = _diseaseFixture().toDomain();

      final summary = diseaseSummaryFromDisease(disease);

      expect(summary.id, disease.id);
      expect(summary.name, disease.name);
      expect(summary.icd10Chapter, disease.icd10Chapter);
      expect(summary.medicalDepartment, disease.medicalDepartment);
      expect(summary.chronicity, disease.chronicity);
      expect(summary.infectious, disease.infectious);
      expect(summary.nameKana, disease.nameKana);
      expect(summary.revisedAt, disease.revisedAt);
    });

    test('diseaseSummaryFromJson restores summary snapshot', () {
      const summary = DiseaseSummary(
        id: 'disease_001',
        name: 'Disease',
        icd10Chapter: 'IX',
        medicalDepartment: ['cardiology'],
        chronicity: 'chronic',
        infectious: false,
        nameKana: 'ディジーズ',
        revisedAt: '2026-01-01',
      );

      final restored = diseaseSummaryFromJson(jsonEncode(summary.toJson()));

      expect(restored.id, summary.id);
      expect(restored.medicalDepartment, summary.medicalDepartment);
      expect(restored.infectious, summary.infectious);
    });
  });
}

DiseaseDto _diseaseFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_diseases__id_.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DiseaseDto.fromJson(json);
}
