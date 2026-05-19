import 'dart:convert';

import 'package:fictional_drug_and_disease_ref/application/search/search_query_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchQueryCodec', () {
    const codec = SearchQueryCodec();

    test(
      'encodes and decodes drug search params with enum serial names [assertion 1/9]',
      () {
        const params = DrugSearchParams(
          page: 2,
          pageSize: 20,
          keyword: 'アムロ',
          keywordMatch: KeywordMatch.prefix,
          keywordTarget: DrugKeywordTarget.all,
          regulatoryClass: ['poisonous', 'prescription_required'],
          dosageForm: ['tablet'],
          sort: DrugSort.atcCode,
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDrug(jsonText);

        expect(json['keyword_match'], 'prefix');
        Object.hashAll([json['keyword_target'], 'all']);

        Object.hashAll([json['sort'], 'atc_code']);

        Object.hashAll([decoded.keyword, 'アムロ']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.prefix]);

        Object.hashAll([decoded.keywordTarget, DrugKeywordTarget.all]);

        Object.hashAll([
          decoded.regulatoryClass,
          ['poisonous', 'prescription_required'],
        ]);

        Object.hashAll([
          decoded.dosageForm,
          ['tablet'],
        ]);

        Object.hashAll([decoded.sort, DrugSort.atcCode]);
      },
    );

    test(
      'encodes and decodes drug search params with enum serial names [assertion 2/9]',
      () {
        const params = DrugSearchParams(
          page: 2,
          pageSize: 20,
          keyword: 'アムロ',
          keywordMatch: KeywordMatch.prefix,
          keywordTarget: DrugKeywordTarget.all,
          regulatoryClass: ['poisonous', 'prescription_required'],
          dosageForm: ['tablet'],
          sort: DrugSort.atcCode,
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDrug(jsonText);

        Object.hashAll([json['keyword_match'], 'prefix']);

        expect(json['keyword_target'], 'all');
        Object.hashAll([json['sort'], 'atc_code']);

        Object.hashAll([decoded.keyword, 'アムロ']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.prefix]);

        Object.hashAll([decoded.keywordTarget, DrugKeywordTarget.all]);

        Object.hashAll([
          decoded.regulatoryClass,
          ['poisonous', 'prescription_required'],
        ]);

        Object.hashAll([
          decoded.dosageForm,
          ['tablet'],
        ]);

        Object.hashAll([decoded.sort, DrugSort.atcCode]);
      },
    );

    test(
      'encodes and decodes drug search params with enum serial names [assertion 3/9]',
      () {
        const params = DrugSearchParams(
          page: 2,
          pageSize: 20,
          keyword: 'アムロ',
          keywordMatch: KeywordMatch.prefix,
          keywordTarget: DrugKeywordTarget.all,
          regulatoryClass: ['poisonous', 'prescription_required'],
          dosageForm: ['tablet'],
          sort: DrugSort.atcCode,
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDrug(jsonText);

        Object.hashAll([json['keyword_match'], 'prefix']);

        Object.hashAll([json['keyword_target'], 'all']);

        expect(json['sort'], 'atc_code');
        Object.hashAll([decoded.keyword, 'アムロ']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.prefix]);

        Object.hashAll([decoded.keywordTarget, DrugKeywordTarget.all]);

        Object.hashAll([
          decoded.regulatoryClass,
          ['poisonous', 'prescription_required'],
        ]);

        Object.hashAll([
          decoded.dosageForm,
          ['tablet'],
        ]);

        Object.hashAll([decoded.sort, DrugSort.atcCode]);
      },
    );

    test(
      'encodes and decodes drug search params with enum serial names [assertion 4/9]',
      () {
        const params = DrugSearchParams(
          page: 2,
          pageSize: 20,
          keyword: 'アムロ',
          keywordMatch: KeywordMatch.prefix,
          keywordTarget: DrugKeywordTarget.all,
          regulatoryClass: ['poisonous', 'prescription_required'],
          dosageForm: ['tablet'],
          sort: DrugSort.atcCode,
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDrug(jsonText);

        Object.hashAll([json['keyword_match'], 'prefix']);

        Object.hashAll([json['keyword_target'], 'all']);

        Object.hashAll([json['sort'], 'atc_code']);

        expect(decoded.keyword, 'アムロ');
        Object.hashAll([decoded.keywordMatch, KeywordMatch.prefix]);

        Object.hashAll([decoded.keywordTarget, DrugKeywordTarget.all]);

        Object.hashAll([
          decoded.regulatoryClass,
          ['poisonous', 'prescription_required'],
        ]);

        Object.hashAll([
          decoded.dosageForm,
          ['tablet'],
        ]);

        Object.hashAll([decoded.sort, DrugSort.atcCode]);
      },
    );

    test(
      'encodes and decodes drug search params with enum serial names [assertion 5/9]',
      () {
        const params = DrugSearchParams(
          page: 2,
          pageSize: 20,
          keyword: 'アムロ',
          keywordMatch: KeywordMatch.prefix,
          keywordTarget: DrugKeywordTarget.all,
          regulatoryClass: ['poisonous', 'prescription_required'],
          dosageForm: ['tablet'],
          sort: DrugSort.atcCode,
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDrug(jsonText);

        Object.hashAll([json['keyword_match'], 'prefix']);

        Object.hashAll([json['keyword_target'], 'all']);

        Object.hashAll([json['sort'], 'atc_code']);

        Object.hashAll([decoded.keyword, 'アムロ']);

        expect(decoded.keywordMatch, KeywordMatch.prefix);
        Object.hashAll([decoded.keywordTarget, DrugKeywordTarget.all]);

        Object.hashAll([
          decoded.regulatoryClass,
          ['poisonous', 'prescription_required'],
        ]);

        Object.hashAll([
          decoded.dosageForm,
          ['tablet'],
        ]);

        Object.hashAll([decoded.sort, DrugSort.atcCode]);
      },
    );

    test(
      'encodes and decodes drug search params with enum serial names [assertion 6/9]',
      () {
        const params = DrugSearchParams(
          page: 2,
          pageSize: 20,
          keyword: 'アムロ',
          keywordMatch: KeywordMatch.prefix,
          keywordTarget: DrugKeywordTarget.all,
          regulatoryClass: ['poisonous', 'prescription_required'],
          dosageForm: ['tablet'],
          sort: DrugSort.atcCode,
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDrug(jsonText);

        Object.hashAll([json['keyword_match'], 'prefix']);

        Object.hashAll([json['keyword_target'], 'all']);

        Object.hashAll([json['sort'], 'atc_code']);

        Object.hashAll([decoded.keyword, 'アムロ']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.prefix]);

        expect(decoded.keywordTarget, DrugKeywordTarget.all);
        Object.hashAll([
          decoded.regulatoryClass,
          ['poisonous', 'prescription_required'],
        ]);

        Object.hashAll([
          decoded.dosageForm,
          ['tablet'],
        ]);

        Object.hashAll([decoded.sort, DrugSort.atcCode]);
      },
    );

    test(
      'encodes and decodes drug search params with enum serial names [assertion 7/9]',
      () {
        const params = DrugSearchParams(
          page: 2,
          pageSize: 20,
          keyword: 'アムロ',
          keywordMatch: KeywordMatch.prefix,
          keywordTarget: DrugKeywordTarget.all,
          regulatoryClass: ['poisonous', 'prescription_required'],
          dosageForm: ['tablet'],
          sort: DrugSort.atcCode,
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDrug(jsonText);

        Object.hashAll([json['keyword_match'], 'prefix']);

        Object.hashAll([json['keyword_target'], 'all']);

        Object.hashAll([json['sort'], 'atc_code']);

        Object.hashAll([decoded.keyword, 'アムロ']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.prefix]);

        Object.hashAll([decoded.keywordTarget, DrugKeywordTarget.all]);

        expect(decoded.regulatoryClass, ['poisonous', 'prescription_required']);
        Object.hashAll([
          decoded.dosageForm,
          ['tablet'],
        ]);

        Object.hashAll([decoded.sort, DrugSort.atcCode]);
      },
    );

    test(
      'encodes and decodes drug search params with enum serial names [assertion 8/9]',
      () {
        const params = DrugSearchParams(
          page: 2,
          pageSize: 20,
          keyword: 'アムロ',
          keywordMatch: KeywordMatch.prefix,
          keywordTarget: DrugKeywordTarget.all,
          regulatoryClass: ['poisonous', 'prescription_required'],
          dosageForm: ['tablet'],
          sort: DrugSort.atcCode,
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDrug(jsonText);

        Object.hashAll([json['keyword_match'], 'prefix']);

        Object.hashAll([json['keyword_target'], 'all']);

        Object.hashAll([json['sort'], 'atc_code']);

        Object.hashAll([decoded.keyword, 'アムロ']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.prefix]);

        Object.hashAll([decoded.keywordTarget, DrugKeywordTarget.all]);

        Object.hashAll([
          decoded.regulatoryClass,
          ['poisonous', 'prescription_required'],
        ]);

        expect(decoded.dosageForm, ['tablet']);
        Object.hashAll([decoded.sort, DrugSort.atcCode]);
      },
    );

    test(
      'encodes and decodes drug search params with enum serial names [assertion 9/9]',
      () {
        const params = DrugSearchParams(
          page: 2,
          pageSize: 20,
          keyword: 'アムロ',
          keywordMatch: KeywordMatch.prefix,
          keywordTarget: DrugKeywordTarget.all,
          regulatoryClass: ['poisonous', 'prescription_required'],
          dosageForm: ['tablet'],
          sort: DrugSort.atcCode,
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDrug(jsonText);

        Object.hashAll([json['keyword_match'], 'prefix']);

        Object.hashAll([json['keyword_target'], 'all']);

        Object.hashAll([json['sort'], 'atc_code']);

        Object.hashAll([decoded.keyword, 'アムロ']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.prefix]);

        Object.hashAll([decoded.keywordTarget, DrugKeywordTarget.all]);

        Object.hashAll([
          decoded.regulatoryClass,
          ['poisonous', 'prescription_required'],
        ]);

        Object.hashAll([
          decoded.dosageForm,
          ['tablet'],
        ]);

        expect(decoded.sort, DrugSort.atcCode);
      },
    );

    test('decodes legacy therapeutic category ids to enum constant names', () {
      final decoded = codec.decodeDrug(
        '{"therapeutic_category":"cardiovascular"}',
      );

      expect(decoded.therapeuticCategory, 'CARDIOVASCULAR_SYSTEM');
    });

    test(
      'encodes and decodes disease search params with booleans [assertion 1/7]',
      () {
        const params = DiseaseSearchParams(
          page: 1,
          pageSize: 20,
          keyword: '高血圧',
          keywordMatch: KeywordMatch.partial,
          keywordTarget: DiseaseKeywordTarget.all,
          icd10Chapter: ['I00-I99'],
          infectious: false,
          hasPharmacologicalTreatment: true,
          sort: DiseaseSort.icd10Chapter,
        );

        final decoded = codec.decodeDisease(codec.encode(params));

        expect(decoded.keyword, '高血圧');
        Object.hashAll([decoded.keywordMatch, KeywordMatch.partial]);

        Object.hashAll([decoded.keywordTarget, DiseaseKeywordTarget.all]);

        Object.hashAll([
          decoded.icd10Chapter,
          ['I00-I99'],
        ]);

        Object.hashAll([decoded.infectious, isFalse]);

        Object.hashAll([decoded.hasPharmacologicalTreatment, isTrue]);

        Object.hashAll([decoded.sort, DiseaseSort.icd10Chapter]);
      },
    );

    test(
      'encodes and decodes disease search params with booleans [assertion 2/7]',
      () {
        const params = DiseaseSearchParams(
          page: 1,
          pageSize: 20,
          keyword: '高血圧',
          keywordMatch: KeywordMatch.partial,
          keywordTarget: DiseaseKeywordTarget.all,
          icd10Chapter: ['I00-I99'],
          infectious: false,
          hasPharmacologicalTreatment: true,
          sort: DiseaseSort.icd10Chapter,
        );

        final decoded = codec.decodeDisease(codec.encode(params));

        Object.hashAll([decoded.keyword, '高血圧']);

        expect(decoded.keywordMatch, KeywordMatch.partial);
        Object.hashAll([decoded.keywordTarget, DiseaseKeywordTarget.all]);

        Object.hashAll([
          decoded.icd10Chapter,
          ['I00-I99'],
        ]);

        Object.hashAll([decoded.infectious, isFalse]);

        Object.hashAll([decoded.hasPharmacologicalTreatment, isTrue]);

        Object.hashAll([decoded.sort, DiseaseSort.icd10Chapter]);
      },
    );

    test(
      'encodes and decodes disease search params with booleans [assertion 3/7]',
      () {
        const params = DiseaseSearchParams(
          page: 1,
          pageSize: 20,
          keyword: '高血圧',
          keywordMatch: KeywordMatch.partial,
          keywordTarget: DiseaseKeywordTarget.all,
          icd10Chapter: ['I00-I99'],
          infectious: false,
          hasPharmacologicalTreatment: true,
          sort: DiseaseSort.icd10Chapter,
        );

        final decoded = codec.decodeDisease(codec.encode(params));

        Object.hashAll([decoded.keyword, '高血圧']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.partial]);

        expect(decoded.keywordTarget, DiseaseKeywordTarget.all);
        Object.hashAll([
          decoded.icd10Chapter,
          ['I00-I99'],
        ]);

        Object.hashAll([decoded.infectious, isFalse]);

        Object.hashAll([decoded.hasPharmacologicalTreatment, isTrue]);

        Object.hashAll([decoded.sort, DiseaseSort.icd10Chapter]);
      },
    );

    test(
      'encodes and decodes disease search params with booleans [assertion 4/7]',
      () {
        const params = DiseaseSearchParams(
          page: 1,
          pageSize: 20,
          keyword: '高血圧',
          keywordMatch: KeywordMatch.partial,
          keywordTarget: DiseaseKeywordTarget.all,
          icd10Chapter: ['I00-I99'],
          infectious: false,
          hasPharmacologicalTreatment: true,
          sort: DiseaseSort.icd10Chapter,
        );

        final decoded = codec.decodeDisease(codec.encode(params));

        Object.hashAll([decoded.keyword, '高血圧']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.partial]);

        Object.hashAll([decoded.keywordTarget, DiseaseKeywordTarget.all]);

        expect(decoded.icd10Chapter, ['I00-I99']);
        Object.hashAll([decoded.infectious, isFalse]);

        Object.hashAll([decoded.hasPharmacologicalTreatment, isTrue]);

        Object.hashAll([decoded.sort, DiseaseSort.icd10Chapter]);
      },
    );

    test(
      'encodes and decodes disease search params with booleans [assertion 5/7]',
      () {
        const params = DiseaseSearchParams(
          page: 1,
          pageSize: 20,
          keyword: '高血圧',
          keywordMatch: KeywordMatch.partial,
          keywordTarget: DiseaseKeywordTarget.all,
          icd10Chapter: ['I00-I99'],
          infectious: false,
          hasPharmacologicalTreatment: true,
          sort: DiseaseSort.icd10Chapter,
        );

        final decoded = codec.decodeDisease(codec.encode(params));

        Object.hashAll([decoded.keyword, '高血圧']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.partial]);

        Object.hashAll([decoded.keywordTarget, DiseaseKeywordTarget.all]);

        Object.hashAll([
          decoded.icd10Chapter,
          ['I00-I99'],
        ]);

        expect(decoded.infectious, isFalse);
        Object.hashAll([decoded.hasPharmacologicalTreatment, isTrue]);

        Object.hashAll([decoded.sort, DiseaseSort.icd10Chapter]);
      },
    );

    test(
      'encodes and decodes disease search params with booleans [assertion 6/7]',
      () {
        const params = DiseaseSearchParams(
          page: 1,
          pageSize: 20,
          keyword: '高血圧',
          keywordMatch: KeywordMatch.partial,
          keywordTarget: DiseaseKeywordTarget.all,
          icd10Chapter: ['I00-I99'],
          infectious: false,
          hasPharmacologicalTreatment: true,
          sort: DiseaseSort.icd10Chapter,
        );

        final decoded = codec.decodeDisease(codec.encode(params));

        Object.hashAll([decoded.keyword, '高血圧']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.partial]);

        Object.hashAll([decoded.keywordTarget, DiseaseKeywordTarget.all]);

        Object.hashAll([
          decoded.icd10Chapter,
          ['I00-I99'],
        ]);

        Object.hashAll([decoded.infectious, isFalse]);

        expect(decoded.hasPharmacologicalTreatment, isTrue);
        Object.hashAll([decoded.sort, DiseaseSort.icd10Chapter]);
      },
    );

    test(
      'encodes and decodes disease search params with booleans [assertion 7/7]',
      () {
        const params = DiseaseSearchParams(
          page: 1,
          pageSize: 20,
          keyword: '高血圧',
          keywordMatch: KeywordMatch.partial,
          keywordTarget: DiseaseKeywordTarget.all,
          icd10Chapter: ['I00-I99'],
          infectious: false,
          hasPharmacologicalTreatment: true,
          sort: DiseaseSort.icd10Chapter,
        );

        final decoded = codec.decodeDisease(codec.encode(params));

        Object.hashAll([decoded.keyword, '高血圧']);

        Object.hashAll([decoded.keywordMatch, KeywordMatch.partial]);

        Object.hashAll([decoded.keywordTarget, DiseaseKeywordTarget.all]);

        Object.hashAll([
          decoded.icd10Chapter,
          ['I00-I99'],
        ]);

        Object.hashAll([decoded.infectious, isFalse]);

        Object.hashAll([decoded.hasPharmacologicalTreatment, isTrue]);

        expect(decoded.sort, DiseaseSort.icd10Chapter);
      },
    );

    test(
      'encodes and decodes disease enum filters as API enum constants [assertion 1/6]',
      () {
        const params = DiseaseSearchParams(
          onsetPattern: ['intermittent'],
          examCategory: ['blood_test'],
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDisease(jsonText);
        final legacyDecoded = codec.decodeDisease(
          '{"onset_pattern":["relapsing"],"exam_category":["imaging"]}',
        );

        expect(json['onset_pattern'], ['INTERMITTENT']);
        Object.hashAll([
          json['exam_category'],
          ['BLOOD_TEST'],
        ]);

        Object.hashAll([
          decoded.onsetPattern,
          ['INTERMITTENT'],
        ]);

        Object.hashAll([
          decoded.examCategory,
          ['BLOOD_TEST'],
        ]);

        Object.hashAll([
          legacyDecoded.onsetPattern,
          ['RELAPSING'],
        ]);

        Object.hashAll([
          legacyDecoded.examCategory,
          ['IMAGING'],
        ]);
      },
    );

    test(
      'encodes and decodes disease enum filters as API enum constants [assertion 2/6]',
      () {
        const params = DiseaseSearchParams(
          onsetPattern: ['intermittent'],
          examCategory: ['blood_test'],
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDisease(jsonText);
        final legacyDecoded = codec.decodeDisease(
          '{"onset_pattern":["relapsing"],"exam_category":["imaging"]}',
        );

        Object.hashAll([
          json['onset_pattern'],
          ['INTERMITTENT'],
        ]);

        expect(json['exam_category'], ['BLOOD_TEST']);
        Object.hashAll([
          decoded.onsetPattern,
          ['INTERMITTENT'],
        ]);

        Object.hashAll([
          decoded.examCategory,
          ['BLOOD_TEST'],
        ]);

        Object.hashAll([
          legacyDecoded.onsetPattern,
          ['RELAPSING'],
        ]);

        Object.hashAll([
          legacyDecoded.examCategory,
          ['IMAGING'],
        ]);
      },
    );

    test(
      'encodes and decodes disease enum filters as API enum constants [assertion 3/6]',
      () {
        const params = DiseaseSearchParams(
          onsetPattern: ['intermittent'],
          examCategory: ['blood_test'],
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDisease(jsonText);
        final legacyDecoded = codec.decodeDisease(
          '{"onset_pattern":["relapsing"],"exam_category":["imaging"]}',
        );

        Object.hashAll([
          json['onset_pattern'],
          ['INTERMITTENT'],
        ]);

        Object.hashAll([
          json['exam_category'],
          ['BLOOD_TEST'],
        ]);

        expect(decoded.onsetPattern, ['INTERMITTENT']);
        Object.hashAll([
          decoded.examCategory,
          ['BLOOD_TEST'],
        ]);

        Object.hashAll([
          legacyDecoded.onsetPattern,
          ['RELAPSING'],
        ]);

        Object.hashAll([
          legacyDecoded.examCategory,
          ['IMAGING'],
        ]);
      },
    );

    test(
      'encodes and decodes disease enum filters as API enum constants [assertion 4/6]',
      () {
        const params = DiseaseSearchParams(
          onsetPattern: ['intermittent'],
          examCategory: ['blood_test'],
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDisease(jsonText);
        final legacyDecoded = codec.decodeDisease(
          '{"onset_pattern":["relapsing"],"exam_category":["imaging"]}',
        );

        Object.hashAll([
          json['onset_pattern'],
          ['INTERMITTENT'],
        ]);

        Object.hashAll([
          json['exam_category'],
          ['BLOOD_TEST'],
        ]);

        Object.hashAll([
          decoded.onsetPattern,
          ['INTERMITTENT'],
        ]);

        expect(decoded.examCategory, ['BLOOD_TEST']);
        Object.hashAll([
          legacyDecoded.onsetPattern,
          ['RELAPSING'],
        ]);

        Object.hashAll([
          legacyDecoded.examCategory,
          ['IMAGING'],
        ]);
      },
    );

    test(
      'encodes and decodes disease enum filters as API enum constants [assertion 5/6]',
      () {
        const params = DiseaseSearchParams(
          onsetPattern: ['intermittent'],
          examCategory: ['blood_test'],
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDisease(jsonText);
        final legacyDecoded = codec.decodeDisease(
          '{"onset_pattern":["relapsing"],"exam_category":["imaging"]}',
        );

        Object.hashAll([
          json['onset_pattern'],
          ['INTERMITTENT'],
        ]);

        Object.hashAll([
          json['exam_category'],
          ['BLOOD_TEST'],
        ]);

        Object.hashAll([
          decoded.onsetPattern,
          ['INTERMITTENT'],
        ]);

        Object.hashAll([
          decoded.examCategory,
          ['BLOOD_TEST'],
        ]);

        expect(legacyDecoded.onsetPattern, ['RELAPSING']);
        Object.hashAll([
          legacyDecoded.examCategory,
          ['IMAGING'],
        ]);
      },
    );

    test(
      'encodes and decodes disease enum filters as API enum constants [assertion 6/6]',
      () {
        const params = DiseaseSearchParams(
          onsetPattern: ['intermittent'],
          examCategory: ['blood_test'],
        );

        final jsonText = codec.encode(params);
        final json = jsonDecode(jsonText) as Map<String, dynamic>;
        final decoded = codec.decodeDisease(jsonText);
        final legacyDecoded = codec.decodeDisease(
          '{"onset_pattern":["relapsing"],"exam_category":["imaging"]}',
        );

        Object.hashAll([
          json['onset_pattern'],
          ['INTERMITTENT'],
        ]);

        Object.hashAll([
          json['exam_category'],
          ['BLOOD_TEST'],
        ]);

        Object.hashAll([
          decoded.onsetPattern,
          ['INTERMITTENT'],
        ]);

        Object.hashAll([
          decoded.examCategory,
          ['BLOOD_TEST'],
        ]);

        Object.hashAll([
          legacyDecoded.onsetPattern,
          ['RELAPSING'],
        ]);

        expect(legacyDecoded.examCategory, ['IMAGING']);
      },
    );

    test('filterCountFor ignores keyword sort page and pageSize', () {
      const params = DrugSearchParams(
        page: 3,
        pageSize: 20,
        keyword: 'アムロ',
        keywordMatch: KeywordMatch.partial,
        keywordTarget: DrugKeywordTarget.all,
        sort: DrugSort.revisedAtDesc,
        regulatoryClass: ['poisonous'],
        dosageForm: ['tablet'],
        adverseReactionKeyword: '浮腫',
      );

      expect(codec.filterCountFor(params), 3);
    });
  });
}
