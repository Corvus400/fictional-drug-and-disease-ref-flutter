/// Keyword match mode shared by search endpoints.
enum KeywordMatch {
  /// Prefix match.
  prefix('prefix'),

  /// Partial match.
  partial('partial')
  ;

  const KeywordMatch(this.serialName);

  /// Wire value.
  final String serialName;
}

/// Drug keyword search target.
enum DrugKeywordTarget {
  /// Generic name.
  generic('generic'),

  /// Brand name.
  brand('brand'),

  /// Generic and brand names.
  both('both')
  ;

  const DrugKeywordTarget(this.serialName);

  /// Wire value.
  final String serialName;
}

/// Drug sort key.
enum DrugSort {
  /// Revised date descending.
  revisedAtDesc('-revised_at'),

  /// Brand name kana.
  brandNameKana('brand_name_kana'),

  /// ATC code.
  atcCode('atc_code'),

  /// Therapeutic category name.
  therapeuticCategoryName('therapeutic_category_name')
  ;

  const DrugSort(this.serialName);

  /// Wire value.
  final String serialName;
}

/// Search parameters for `/v1/drugs`.
final class DrugSearchParams {
  /// Creates drug search parameters.
  const DrugSearchParams({
    this.page,
    this.pageSize,
    this.categoryAtc,
    this.therapeuticCategory,
    this.regulatoryClass,
    this.dosageForm,
    this.route,
    this.keyword,
    this.keywordMatch,
    this.keywordTarget,
    this.adverseReactionKeyword,
    this.precautionCategory,
    this.sort,
  });

  /// Page number.
  final int? page;

  /// Page size.
  final int? pageSize;

  /// ATC first-level category.
  final String? categoryAtc;

  /// Therapeutic category enum constant name.
  final String? therapeuticCategory;

  /// Regulatory class serial names.
  final List<String>? regulatoryClass;

  /// Dosage form serial names.
  final List<String>? dosageForm;

  /// Route serial names.
  final List<String>? route;

  /// Keyword.
  final String? keyword;

  /// Keyword match mode.
  final KeywordMatch? keywordMatch;

  /// Keyword target.
  final DrugKeywordTarget? keywordTarget;

  /// Adverse reaction keyword.
  final String? adverseReactionKeyword;

  /// Precaution category enum constant names.
  final List<String>? precautionCategory;

  /// Sort key.
  final DrugSort? sort;
}
