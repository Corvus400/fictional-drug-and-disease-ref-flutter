import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_summary_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DrugSummaryDto.fromJson parses Swagger sample item[0]', () {
    final fixture = File(
      'test/fixtures/swagger/get_v1_drugs.json',
    ).readAsStringSync();
    final json = jsonDecode(fixture) as Map<String, dynamic>;
    final item = (json['items'] as List<dynamic>).first as Map<String, dynamic>;

    final dto = DrugSummaryDto.fromJson(item);

    expect(dto.id, 'drug_0080');
    expect(dto.brandName, 'トレデキム');
    expect(dto.regulatoryClass, ['poison', 'prescription_required']);
    expect(dto.dosageForm, 'liquid');
  });

  test('DrugSummaryDto roundtrip preserves all fields', () {
    final fixture = File(
      'test/fixtures/swagger/get_v1_drugs.json',
    ).readAsStringSync();
    final json = jsonDecode(fixture) as Map<String, dynamic>;
    final item = (json['items'] as List<dynamic>).first as Map<String, dynamic>;

    final roundtripped = DrugSummaryDto.fromJson(item).toJson();

    expect(roundtripped, item);
  });

  test('regulatory_class empty array survives roundtrip', () {
    final json = <String, Object?>{
      'id': 'drug_empty',
      'brand_name': 'ブランド',
      'generic_name': '一般名',
      'therapeutic_category_name': '分類',
      'regulatory_class': <String>[],
      'dosage_form': 'tablet',
      'brand_name_kana': 'ブランド',
      'atc_code': 'A00AA00',
      'revised_at': '2026-05-01',
      'image_url': '/v1/images/dosage-forms/tablet?size=Original',
    };

    final dto = DrugSummaryDto.fromJson(json);

    expect(dto.regulatoryClass, isEmpty);
    expect(dto.toJson()['regulatory_class'], <String>[]);
  });
}
