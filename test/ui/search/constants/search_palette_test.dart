import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchPalette', () {
    test('separates drugTint and primarySoft tokens', () {
      expect(
        SearchPalette.light.drugTint,
        isNot(SearchPalette.light.primarySoft),
      );
      expect(
        SearchPalette.dark.drugTint,
        isNot(SearchPalette.dark.primarySoft),
      );
    });

    test('searchFieldBg follows Round5 search field tokens', () {
      expect(
        (SearchPalette.light as dynamic).searchFieldBg,
        const Color(0xFFEBEBEF),
      );
      expect(
        (SearchPalette.dark as dynamic).searchFieldBg,
        (SearchPalette.dark as dynamic).surface3,
      );
    });
  });
}
