import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('KeywordMatch serialName exposes wire values', () {
    expect(KeywordMatch.prefix.serialName, 'prefix');
    expect(KeywordMatch.partial.serialName, 'partial');
  });

  test('DrugSearchParams stores query fields', () {
    const params = DrugSearchParams(
      page: 2,
      pageSize: 50,
      keyword: 'sample',
      keywordMatch: KeywordMatch.prefix,
      keywordTarget: DrugKeywordTarget.brand,
      sort: DrugSort.brandNameKana,
    );

    expect(params.page, 2);
    expect(params.keywordMatch?.serialName, 'prefix');
    expect(params.keywordTarget?.serialName, 'brand');
    expect(params.sort?.serialName, 'brand_name_kana');
  });

  test('DrugKeywordTarget all serializes to all', () {
    expect(DrugKeywordTarget.all.serialName, 'all');
  });
}
