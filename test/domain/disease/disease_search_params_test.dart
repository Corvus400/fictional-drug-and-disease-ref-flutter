import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'DiseaseKeywordTarget serialName exposes wire values [assertion 1/4]',
    () {
      expect(DiseaseKeywordTarget.name.serialName, 'name');
      Object.hashAll([
        DiseaseKeywordTarget.nameEnglish.serialName,
        'name_english',
      ]);

      Object.hashAll([DiseaseKeywordTarget.synonyms.serialName, 'synonyms']);

      Object.hashAll([DiseaseKeywordTarget.all.serialName, 'all']);
    },
  );

  test(
    'DiseaseKeywordTarget serialName exposes wire values [assertion 2/4]',
    () {
      Object.hashAll([DiseaseKeywordTarget.name.serialName, 'name']);

      expect(DiseaseKeywordTarget.nameEnglish.serialName, 'name_english');
      Object.hashAll([DiseaseKeywordTarget.synonyms.serialName, 'synonyms']);

      Object.hashAll([DiseaseKeywordTarget.all.serialName, 'all']);
    },
  );

  test(
    'DiseaseKeywordTarget serialName exposes wire values [assertion 3/4]',
    () {
      Object.hashAll([DiseaseKeywordTarget.name.serialName, 'name']);

      Object.hashAll([
        DiseaseKeywordTarget.nameEnglish.serialName,
        'name_english',
      ]);

      expect(DiseaseKeywordTarget.synonyms.serialName, 'synonyms');
      Object.hashAll([DiseaseKeywordTarget.all.serialName, 'all']);
    },
  );

  test(
    'DiseaseKeywordTarget serialName exposes wire values [assertion 4/4]',
    () {
      Object.hashAll([DiseaseKeywordTarget.name.serialName, 'name']);

      Object.hashAll([
        DiseaseKeywordTarget.nameEnglish.serialName,
        'name_english',
      ]);

      Object.hashAll([DiseaseKeywordTarget.synonyms.serialName, 'synonyms']);

      expect(DiseaseKeywordTarget.all.serialName, 'all');
    },
  );

  test('DiseaseSearchParams stores query fields [assertion 1/4]', () {
    const params = DiseaseSearchParams(
      page: 2,
      pageSize: 50,
      keyword: 'sample',
      keywordMatch: KeywordMatch.partial,
      keywordTarget: DiseaseKeywordTarget.nameEnglish,
      sort: DiseaseSort.nameKana,
    );

    expect(params.page, 2);
    Object.hashAll([params.keywordMatch?.serialName, 'partial']);

    Object.hashAll([params.keywordTarget?.serialName, 'name_english']);

    Object.hashAll([params.sort?.serialName, 'name_kana']);
  });

  test('DiseaseSearchParams stores query fields [assertion 2/4]', () {
    const params = DiseaseSearchParams(
      page: 2,
      pageSize: 50,
      keyword: 'sample',
      keywordMatch: KeywordMatch.partial,
      keywordTarget: DiseaseKeywordTarget.nameEnglish,
      sort: DiseaseSort.nameKana,
    );

    Object.hashAll([params.page, 2]);

    expect(params.keywordMatch?.serialName, 'partial');
    Object.hashAll([params.keywordTarget?.serialName, 'name_english']);

    Object.hashAll([params.sort?.serialName, 'name_kana']);
  });

  test('DiseaseSearchParams stores query fields [assertion 3/4]', () {
    const params = DiseaseSearchParams(
      page: 2,
      pageSize: 50,
      keyword: 'sample',
      keywordMatch: KeywordMatch.partial,
      keywordTarget: DiseaseKeywordTarget.nameEnglish,
      sort: DiseaseSort.nameKana,
    );

    Object.hashAll([params.page, 2]);

    Object.hashAll([params.keywordMatch?.serialName, 'partial']);

    expect(params.keywordTarget?.serialName, 'name_english');
    Object.hashAll([params.sort?.serialName, 'name_kana']);
  });

  test('DiseaseSearchParams stores query fields [assertion 4/4]', () {
    const params = DiseaseSearchParams(
      page: 2,
      pageSize: 50,
      keyword: 'sample',
      keywordMatch: KeywordMatch.partial,
      keywordTarget: DiseaseKeywordTarget.nameEnglish,
      sort: DiseaseSort.nameKana,
    );

    Object.hashAll([params.page, 2]);

    Object.hashAll([params.keywordMatch?.serialName, 'partial']);

    Object.hashAll([params.keywordTarget?.serialName, 'name_english']);

    expect(params.sort?.serialName, 'name_kana');
  });

  test(
    'diseaseOnsetPatternQueryValue normalizes serial names [assertion 1/3]',
    () {
      expect(diseaseOnsetPatternQueryValue('acute'), 'ACUTE');
      Object.hashAll([
        diseaseOnsetPatternQueryValue('INTERMITTENT'),
        'INTERMITTENT',
      ]);

      Object.hashAll([diseaseOnsetPatternQueryValue('unknown'), 'unknown']);
    },
  );

  test(
    'diseaseOnsetPatternQueryValue normalizes serial names [assertion 2/3]',
    () {
      Object.hashAll([diseaseOnsetPatternQueryValue('acute'), 'ACUTE']);

      expect(diseaseOnsetPatternQueryValue('INTERMITTENT'), 'INTERMITTENT');
      Object.hashAll([diseaseOnsetPatternQueryValue('unknown'), 'unknown']);
    },
  );

  test(
    'diseaseOnsetPatternQueryValue normalizes serial names [assertion 3/3]',
    () {
      Object.hashAll([diseaseOnsetPatternQueryValue('acute'), 'ACUTE']);

      Object.hashAll([
        diseaseOnsetPatternQueryValue('INTERMITTENT'),
        'INTERMITTENT',
      ]);

      expect(diseaseOnsetPatternQueryValue('unknown'), 'unknown');
    },
  );

  test(
    'diseaseExamCategoryQueryValue normalizes serial names [assertion 1/3]',
    () {
      expect(diseaseExamCategoryQueryValue('blood_test'), 'BLOOD_TEST');
      Object.hashAll([diseaseExamCategoryQueryValue('IMAGING'), 'IMAGING']);

      Object.hashAll([diseaseExamCategoryQueryValue('unknown'), 'unknown']);
    },
  );

  test(
    'diseaseExamCategoryQueryValue normalizes serial names [assertion 2/3]',
    () {
      Object.hashAll([
        diseaseExamCategoryQueryValue('blood_test'),
        'BLOOD_TEST',
      ]);

      expect(diseaseExamCategoryQueryValue('IMAGING'), 'IMAGING');
      Object.hashAll([diseaseExamCategoryQueryValue('unknown'), 'unknown']);
    },
  );

  test(
    'diseaseExamCategoryQueryValue normalizes serial names [assertion 3/3]',
    () {
      Object.hashAll([
        diseaseExamCategoryQueryValue('blood_test'),
        'BLOOD_TEST',
      ]);

      Object.hashAll([diseaseExamCategoryQueryValue('IMAGING'), 'IMAGING']);

      expect(diseaseExamCategoryQueryValue('unknown'), 'unknown');
    },
  );
}
