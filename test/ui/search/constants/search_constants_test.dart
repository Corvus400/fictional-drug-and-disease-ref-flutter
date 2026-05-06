import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchConstants Round6 SSOT additions', () {
    test('searchDrugCardImageAspectRatio is 2/3', () {
      expect(SearchConstants.searchDrugCardImageAspectRatio, 2 / 3);
    });

    test('searchListBottomPadding clears bottom nav', () {
      expect(SearchConstants.searchListBottomPadding, 100.0);
    });

    test('searchEmptyCta radius and height match Round6 spec', () {
      expect(SearchConstants.searchEmptyCtaRadius, 10.0);
      expect(SearchConstants.searchEmptyCtaHeight, 44.0);
    });

    test('searchErrorCta radius and height match Round6 spec', () {
      expect(SearchConstants.searchErrorCtaRadius, 12.0);
      expect(SearchConstants.searchErrorCtaHeight, 48.0);
    });
  });
}
