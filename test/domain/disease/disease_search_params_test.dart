import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DiseaseKeywordTarget serialName exposes wire values', () {
    expect(DiseaseKeywordTarget.name.serialName, 'name');
    expect(DiseaseKeywordTarget.nameEnglish.serialName, 'name_english');
    expect(DiseaseKeywordTarget.synonyms.serialName, 'synonyms');
    expect(DiseaseKeywordTarget.all.serialName, 'all');
  });

  test('DiseaseSearchParams stores query fields', () {
    const params = DiseaseSearchParams(
      page: 2,
      pageSize: 50,
      keyword: 'sample',
      keywordMatch: KeywordMatch.partial,
      keywordTarget: DiseaseKeywordTarget.nameEnglish,
      sort: DiseaseSort.nameKana,
    );

    expect(params.page, 2);
    expect(params.keywordMatch?.serialName, 'partial');
    expect(params.keywordTarget?.serialName, 'name_english');
    expect(params.sort?.serialName, 'name_kana');
  });

  test('diseaseOnsetPatternQueryValue normalizes serial names', () {
    expect(diseaseOnsetPatternQueryValue('acute'), 'ACUTE');
    expect(diseaseOnsetPatternQueryValue('INTERMITTENT'), 'INTERMITTENT');
    expect(diseaseOnsetPatternQueryValue('unknown'), 'unknown');
  });

  test('diseaseExamCategoryQueryValue normalizes serial names', () {
    expect(diseaseExamCategoryQueryValue('blood_test'), 'BLOOD_TEST');
    expect(diseaseExamCategoryQueryValue('IMAGING'), 'IMAGING');
    expect(diseaseExamCategoryQueryValue('unknown'), 'unknown');
  });
}
