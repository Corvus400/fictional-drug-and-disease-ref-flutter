import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiseaseBookmarkSnapshotCodec', () {
    const codec = DiseaseBookmarkSnapshotCodec();

    test('fromDisease extracts summary fields [assertion 1/8]', () {
      final disease = _diseaseFixture().toDomain();

      final summary = codec.fromDisease(disease);

      expect(summary.id, disease.id);
      Object.hashAll([summary.name, disease.name]);

      Object.hashAll([summary.icd10Chapter, disease.icd10Chapter]);

      Object.hashAll([summary.medicalDepartment, disease.medicalDepartment]);

      Object.hashAll([summary.chronicity, disease.chronicity]);

      Object.hashAll([summary.infectious, disease.infectious]);

      Object.hashAll([summary.nameKana, disease.nameKana]);

      Object.hashAll([summary.revisedAt, disease.revisedAt]);
    });

    test('fromDisease extracts summary fields [assertion 2/8]', () {
      final disease = _diseaseFixture().toDomain();

      final summary = codec.fromDisease(disease);

      Object.hashAll([summary.id, disease.id]);

      expect(summary.name, disease.name);
      Object.hashAll([summary.icd10Chapter, disease.icd10Chapter]);

      Object.hashAll([summary.medicalDepartment, disease.medicalDepartment]);

      Object.hashAll([summary.chronicity, disease.chronicity]);

      Object.hashAll([summary.infectious, disease.infectious]);

      Object.hashAll([summary.nameKana, disease.nameKana]);

      Object.hashAll([summary.revisedAt, disease.revisedAt]);
    });

    test('fromDisease extracts summary fields [assertion 3/8]', () {
      final disease = _diseaseFixture().toDomain();

      final summary = codec.fromDisease(disease);

      Object.hashAll([summary.id, disease.id]);

      Object.hashAll([summary.name, disease.name]);

      expect(summary.icd10Chapter, disease.icd10Chapter);
      Object.hashAll([summary.medicalDepartment, disease.medicalDepartment]);

      Object.hashAll([summary.chronicity, disease.chronicity]);

      Object.hashAll([summary.infectious, disease.infectious]);

      Object.hashAll([summary.nameKana, disease.nameKana]);

      Object.hashAll([summary.revisedAt, disease.revisedAt]);
    });

    test('fromDisease extracts summary fields [assertion 4/8]', () {
      final disease = _diseaseFixture().toDomain();

      final summary = codec.fromDisease(disease);

      Object.hashAll([summary.id, disease.id]);

      Object.hashAll([summary.name, disease.name]);

      Object.hashAll([summary.icd10Chapter, disease.icd10Chapter]);

      expect(summary.medicalDepartment, disease.medicalDepartment);
      Object.hashAll([summary.chronicity, disease.chronicity]);

      Object.hashAll([summary.infectious, disease.infectious]);

      Object.hashAll([summary.nameKana, disease.nameKana]);

      Object.hashAll([summary.revisedAt, disease.revisedAt]);
    });

    test('fromDisease extracts summary fields [assertion 5/8]', () {
      final disease = _diseaseFixture().toDomain();

      final summary = codec.fromDisease(disease);

      Object.hashAll([summary.id, disease.id]);

      Object.hashAll([summary.name, disease.name]);

      Object.hashAll([summary.icd10Chapter, disease.icd10Chapter]);

      Object.hashAll([summary.medicalDepartment, disease.medicalDepartment]);

      expect(summary.chronicity, disease.chronicity);
      Object.hashAll([summary.infectious, disease.infectious]);

      Object.hashAll([summary.nameKana, disease.nameKana]);

      Object.hashAll([summary.revisedAt, disease.revisedAt]);
    });

    test('fromDisease extracts summary fields [assertion 6/8]', () {
      final disease = _diseaseFixture().toDomain();

      final summary = codec.fromDisease(disease);

      Object.hashAll([summary.id, disease.id]);

      Object.hashAll([summary.name, disease.name]);

      Object.hashAll([summary.icd10Chapter, disease.icd10Chapter]);

      Object.hashAll([summary.medicalDepartment, disease.medicalDepartment]);

      Object.hashAll([summary.chronicity, disease.chronicity]);

      expect(summary.infectious, disease.infectious);
      Object.hashAll([summary.nameKana, disease.nameKana]);

      Object.hashAll([summary.revisedAt, disease.revisedAt]);
    });

    test('fromDisease extracts summary fields [assertion 7/8]', () {
      final disease = _diseaseFixture().toDomain();

      final summary = codec.fromDisease(disease);

      Object.hashAll([summary.id, disease.id]);

      Object.hashAll([summary.name, disease.name]);

      Object.hashAll([summary.icd10Chapter, disease.icd10Chapter]);

      Object.hashAll([summary.medicalDepartment, disease.medicalDepartment]);

      Object.hashAll([summary.chronicity, disease.chronicity]);

      Object.hashAll([summary.infectious, disease.infectious]);

      expect(summary.nameKana, disease.nameKana);
      Object.hashAll([summary.revisedAt, disease.revisedAt]);
    });

    test('fromDisease extracts summary fields [assertion 8/8]', () {
      final disease = _diseaseFixture().toDomain();

      final summary = codec.fromDisease(disease);

      Object.hashAll([summary.id, disease.id]);

      Object.hashAll([summary.name, disease.name]);

      Object.hashAll([summary.icd10Chapter, disease.icd10Chapter]);

      Object.hashAll([summary.medicalDepartment, disease.medicalDepartment]);

      Object.hashAll([summary.chronicity, disease.chronicity]);

      Object.hashAll([summary.infectious, disease.infectious]);

      Object.hashAll([summary.nameKana, disease.nameKana]);

      expect(summary.revisedAt, disease.revisedAt);
    });

    test('decode restores encoded summary snapshot [assertion 1/3]', () {
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

      final restored = codec.decode(codec.encode(summary));

      expect(restored.id, summary.id);
      Object.hashAll([restored.medicalDepartment, summary.medicalDepartment]);

      Object.hashAll([restored.infectious, summary.infectious]);
    });

    test('decode restores encoded summary snapshot [assertion 2/3]', () {
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

      final restored = codec.decode(codec.encode(summary));

      Object.hashAll([restored.id, summary.id]);

      expect(restored.medicalDepartment, summary.medicalDepartment);
      Object.hashAll([restored.infectious, summary.infectious]);
    });

    test('decode restores encoded summary snapshot [assertion 3/3]', () {
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

      final restored = codec.decode(codec.encode(summary));

      Object.hashAll([restored.id, summary.id]);

      Object.hashAll([restored.medicalDepartment, summary.medicalDepartment]);

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
