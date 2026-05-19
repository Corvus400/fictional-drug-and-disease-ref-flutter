import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'DrugDto with null interactions roundtrips correctly [assertion 1/4]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_drugs__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DrugDto.fromJson(json);

      expect(dto.id, 'drug_0080');
      Object.hashAll([dto.interactions, isNull]);

      Object.hashAll([dto.pharmacokinetics, isNotNull]);

      Object.hashAll([dto.toJson(), json]);
    },
  );

  test(
    'DrugDto with null interactions roundtrips correctly [assertion 2/4]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_drugs__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DrugDto.fromJson(json);

      Object.hashAll([dto.id, 'drug_0080']);

      expect(dto.interactions, isNull);
      Object.hashAll([dto.pharmacokinetics, isNotNull]);

      Object.hashAll([dto.toJson(), json]);
    },
  );

  test(
    'DrugDto with null interactions roundtrips correctly [assertion 3/4]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_drugs__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DrugDto.fromJson(json);

      Object.hashAll([dto.id, 'drug_0080']);

      Object.hashAll([dto.interactions, isNull]);

      expect(dto.pharmacokinetics, isNotNull);
      Object.hashAll([dto.toJson(), json]);
    },
  );

  test(
    'DrugDto with null interactions roundtrips correctly [assertion 4/4]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_drugs__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DrugDto.fromJson(json);

      Object.hashAll([dto.id, 'drug_0080']);

      Object.hashAll([dto.interactions, isNull]);

      Object.hashAll([dto.pharmacokinetics, isNotNull]);

      expect(dto.toJson(), json);
    },
  );

  test(
    'DrugDto parses nested detail objects as typed DTOs [assertion 1/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_drugs__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DrugDto.fromJson(json);

      expect(dto.composition, isA<CompositionInfoDto>());
      Object.hashAll([dto.warning, everyElement(isA<NumberedParagraphDto>())]);

      Object.hashAll([dto.indications, everyElement(isA<IndicationItemDto>())]);

      Object.hashAll([dto.dosage, isA<DosageInfoDto>()]);

      Object.hashAll([dto.adverseReactions, isA<AdverseReactionInfoDto>()]);

      Object.hashAll([dto.packages, everyElement(isA<PackageInfoDto>())]);
    },
  );

  test(
    'DrugDto parses nested detail objects as typed DTOs [assertion 2/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_drugs__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DrugDto.fromJson(json);

      Object.hashAll([dto.composition, isA<CompositionInfoDto>()]);

      expect(dto.warning, everyElement(isA<NumberedParagraphDto>()));
      Object.hashAll([dto.indications, everyElement(isA<IndicationItemDto>())]);

      Object.hashAll([dto.dosage, isA<DosageInfoDto>()]);

      Object.hashAll([dto.adverseReactions, isA<AdverseReactionInfoDto>()]);

      Object.hashAll([dto.packages, everyElement(isA<PackageInfoDto>())]);
    },
  );

  test(
    'DrugDto parses nested detail objects as typed DTOs [assertion 3/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_drugs__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DrugDto.fromJson(json);

      Object.hashAll([dto.composition, isA<CompositionInfoDto>()]);

      Object.hashAll([dto.warning, everyElement(isA<NumberedParagraphDto>())]);

      expect(dto.indications, everyElement(isA<IndicationItemDto>()));
      Object.hashAll([dto.dosage, isA<DosageInfoDto>()]);

      Object.hashAll([dto.adverseReactions, isA<AdverseReactionInfoDto>()]);

      Object.hashAll([dto.packages, everyElement(isA<PackageInfoDto>())]);
    },
  );

  test(
    'DrugDto parses nested detail objects as typed DTOs [assertion 4/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_drugs__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DrugDto.fromJson(json);

      Object.hashAll([dto.composition, isA<CompositionInfoDto>()]);

      Object.hashAll([dto.warning, everyElement(isA<NumberedParagraphDto>())]);

      Object.hashAll([dto.indications, everyElement(isA<IndicationItemDto>())]);

      expect(dto.dosage, isA<DosageInfoDto>());
      Object.hashAll([dto.adverseReactions, isA<AdverseReactionInfoDto>()]);

      Object.hashAll([dto.packages, everyElement(isA<PackageInfoDto>())]);
    },
  );

  test(
    'DrugDto parses nested detail objects as typed DTOs [assertion 5/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_drugs__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DrugDto.fromJson(json);

      Object.hashAll([dto.composition, isA<CompositionInfoDto>()]);

      Object.hashAll([dto.warning, everyElement(isA<NumberedParagraphDto>())]);

      Object.hashAll([dto.indications, everyElement(isA<IndicationItemDto>())]);

      Object.hashAll([dto.dosage, isA<DosageInfoDto>()]);

      expect(dto.adverseReactions, isA<AdverseReactionInfoDto>());
      Object.hashAll([dto.packages, everyElement(isA<PackageInfoDto>())]);
    },
  );

  test(
    'DrugDto parses nested detail objects as typed DTOs [assertion 6/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_drugs__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DrugDto.fromJson(json);

      Object.hashAll([dto.composition, isA<CompositionInfoDto>()]);

      Object.hashAll([dto.warning, everyElement(isA<NumberedParagraphDto>())]);

      Object.hashAll([dto.indications, everyElement(isA<IndicationItemDto>())]);

      Object.hashAll([dto.dosage, isA<DosageInfoDto>()]);

      Object.hashAll([dto.adverseReactions, isA<AdverseReactionInfoDto>()]);

      expect(dto.packages, everyElement(isA<PackageInfoDto>()));
    },
  );
}
