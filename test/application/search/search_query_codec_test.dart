import 'dart:convert';

import 'package:fictional_drug_and_disease_ref/application/search/search_query_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchQueryCodec', () {
    const codec = SearchQueryCodec();

    test('encodes and decodes drug search params with enum serial names', () {
      const params = DrugSearchParams(
        page: 2,
        pageSize: 20,
        keyword: 'アムロ',
        keywordMatch: KeywordMatch.prefix,
        keywordTarget: DrugKeywordTarget.both,
        regulatoryClass: ['poisonous', 'prescription_required'],
        dosageForm: ['tablet'],
        sort: DrugSort.atcCode,
      );

      final jsonText = codec.encode(params);
      final json = jsonDecode(jsonText) as Map<String, dynamic>;
      final decoded = codec.decodeDrug(jsonText);

      expect(json['keyword_match'], 'prefix');
      expect(json['keyword_target'], 'both');
      expect(json['sort'], 'atc_code');
      expect(decoded.keyword, 'アムロ');
      expect(decoded.keywordMatch, KeywordMatch.prefix);
      expect(decoded.keywordTarget, DrugKeywordTarget.both);
      expect(decoded.regulatoryClass, ['poisonous', 'prescription_required']);
      expect(decoded.dosageForm, ['tablet']);
      expect(decoded.sort, DrugSort.atcCode);
    });

    test('encodes and decodes disease search params with booleans', () {
      const params = DiseaseSearchParams(
        page: 1,
        pageSize: 20,
        keyword: '高血圧',
        keywordMatch: KeywordMatch.partial,
        keywordTarget: DiseaseKeywordTarget.name,
        icd10Chapter: ['I00-I99'],
        infectious: false,
        hasPharmacologicalTreatment: true,
        sort: DiseaseSort.icd10Chapter,
      );

      final decoded = codec.decodeDisease(codec.encode(params));

      expect(decoded.keyword, '高血圧');
      expect(decoded.keywordMatch, KeywordMatch.partial);
      expect(decoded.keywordTarget, DiseaseKeywordTarget.name);
      expect(decoded.icd10Chapter, ['I00-I99']);
      expect(decoded.infectious, isFalse);
      expect(decoded.hasPharmacologicalTreatment, isTrue);
      expect(decoded.sort, DiseaseSort.icd10Chapter);
    });

    test('filterCountFor ignores keyword sort page and pageSize', () {
      const params = DrugSearchParams(
        page: 3,
        pageSize: 20,
        keyword: 'アムロ',
        sort: DrugSort.revisedAtDesc,
        regulatoryClass: ['poisonous'],
        dosageForm: ['tablet'],
        adverseReactionKeyword: '浮腫',
      );

      expect(codec.filterCountFor(params), 3);
    });
  });
}
