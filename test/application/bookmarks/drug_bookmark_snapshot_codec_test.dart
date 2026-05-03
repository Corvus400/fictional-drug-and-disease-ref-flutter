import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DrugBookmarkSnapshotCodec', () {
    const codec = DrugBookmarkSnapshotCodec();

    test('fromDrug extracts summary fields', () {
      final drug = _drugFixture().toDomain();

      final summary = codec.fromDrug(drug);

      expect(summary.id, drug.id);
      expect(summary.brandName, drug.brandName);
      expect(summary.genericName, drug.genericName);
      expect(summary.therapeuticCategoryName, drug.therapeuticCategoryName);
      expect(summary.regulatoryClass, drug.regulatoryClass);
      expect(summary.dosageForm, drug.dosageForm);
      expect(summary.brandNameKana, drug.brandNameKana);
      expect(summary.atcCode, drug.atcCode);
      expect(summary.revisedAt, drug.revisedAt);
      expect(summary.imageUrl, drug.imageUrl);
    });

    test('decode restores encoded summary snapshot', () {
      const summary = DrugSummary(
        id: 'drug_001',
        brandName: 'Brand',
        genericName: 'Generic',
        therapeuticCategoryName: 'Category',
        regulatoryClass: ['prescription_required'],
        dosageForm: 'tablet',
        brandNameKana: 'ブランド',
        atcCode: 'C08CA01',
        revisedAt: '2026-01-01',
        imageUrl: '/v1/images/drugs/drug_001',
      );

      final restored = codec.decode(codec.encode(summary));

      expect(restored.id, summary.id);
      expect(restored.regulatoryClass, summary.regulatoryClass);
      expect(restored.imageUrl, summary.imageUrl);
    });
  });
}

DrugDto _drugFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs__id_.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugDto.fromJson(json);
}
