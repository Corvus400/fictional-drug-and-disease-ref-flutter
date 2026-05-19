import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('KeywordMatch serialName exposes wire values [assertion 1/2]', () {
    expect(KeywordMatch.prefix.serialName, 'prefix');
    Object.hashAll([KeywordMatch.partial.serialName, 'partial']);
  });

  test('KeywordMatch serialName exposes wire values [assertion 2/2]', () {
    Object.hashAll([KeywordMatch.prefix.serialName, 'prefix']);

    expect(KeywordMatch.partial.serialName, 'partial');
  });

  test('DrugSearchParams stores query fields [assertion 1/4]', () {
    const params = DrugSearchParams(
      page: 2,
      pageSize: 50,
      keyword: 'sample',
      keywordMatch: KeywordMatch.prefix,
      keywordTarget: DrugKeywordTarget.brand,
      sort: DrugSort.brandNameKana,
    );

    expect(params.page, 2);
    Object.hashAll([params.keywordMatch?.serialName, 'prefix']);

    Object.hashAll([params.keywordTarget?.serialName, 'brand']);

    Object.hashAll([params.sort?.serialName, 'brand_name_kana']);
  });

  test('DrugSearchParams stores query fields [assertion 2/4]', () {
    const params = DrugSearchParams(
      page: 2,
      pageSize: 50,
      keyword: 'sample',
      keywordMatch: KeywordMatch.prefix,
      keywordTarget: DrugKeywordTarget.brand,
      sort: DrugSort.brandNameKana,
    );

    Object.hashAll([params.page, 2]);

    expect(params.keywordMatch?.serialName, 'prefix');
    Object.hashAll([params.keywordTarget?.serialName, 'brand']);

    Object.hashAll([params.sort?.serialName, 'brand_name_kana']);
  });

  test('DrugSearchParams stores query fields [assertion 3/4]', () {
    const params = DrugSearchParams(
      page: 2,
      pageSize: 50,
      keyword: 'sample',
      keywordMatch: KeywordMatch.prefix,
      keywordTarget: DrugKeywordTarget.brand,
      sort: DrugSort.brandNameKana,
    );

    Object.hashAll([params.page, 2]);

    Object.hashAll([params.keywordMatch?.serialName, 'prefix']);

    expect(params.keywordTarget?.serialName, 'brand');
    Object.hashAll([params.sort?.serialName, 'brand_name_kana']);
  });

  test('DrugSearchParams stores query fields [assertion 4/4]', () {
    const params = DrugSearchParams(
      page: 2,
      pageSize: 50,
      keyword: 'sample',
      keywordMatch: KeywordMatch.prefix,
      keywordTarget: DrugKeywordTarget.brand,
      sort: DrugSort.brandNameKana,
    );

    Object.hashAll([params.page, 2]);

    Object.hashAll([params.keywordMatch?.serialName, 'prefix']);

    Object.hashAll([params.keywordTarget?.serialName, 'brand']);

    expect(params.sort?.serialName, 'brand_name_kana');
  });

  test('DrugKeywordTarget all serializes to all', () {
    expect(DrugKeywordTarget.all.serialName, 'all');
  });
}
