import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DrugDto with null interactions roundtrips correctly', () {
    final fixture = File(
      'test/fixtures/swagger/get_v1_drugs__id_.json',
    ).readAsStringSync();
    final json = jsonDecode(fixture) as Map<String, dynamic>;

    final dto = DrugDto.fromJson(json);

    expect(dto.id, 'drug_0080');
    expect(dto.interactions, isNull);
    expect(dto.pharmacokinetics, isNotNull);
    expect(dto.toJson(), json);
  });

  test('DrugDto parses nested detail objects as typed DTOs', () {
    final fixture = File(
      'test/fixtures/swagger/get_v1_drugs__id_.json',
    ).readAsStringSync();
    final json = jsonDecode(fixture) as Map<String, dynamic>;

    final dto = DrugDto.fromJson(json);

    expect(dto.composition, isA<CompositionInfoDto>());
    expect(dto.warning, everyElement(isA<NumberedParagraphDto>()));
    expect(dto.indications, everyElement(isA<IndicationItemDto>()));
    expect(dto.dosage, isA<DosageInfoDto>());
    expect(dto.adverseReactions, isA<AdverseReactionInfoDto>());
    expect(dto.packages, everyElement(isA<PackageInfoDto>()));
  });
}
