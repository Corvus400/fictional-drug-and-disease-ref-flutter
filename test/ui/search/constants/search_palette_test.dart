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

    test('diseaseBadgeColors chronicity colors differ across values', () {
      const values = ['acute', 'subacute', 'chronic', 'relapsing'];

      final foregrounds = {
        for (final value in values)
          SearchPalette.light
              .diseaseBadgeColors(DiseaseBadgeCategory.chronicity, value)
              .foreground,
      };

      expect(foregrounds.length, greaterThanOrEqualTo(4));
      for (final value in values) {
        final colors = SearchPalette.light.diseaseBadgeColors(
          DiseaseBadgeCategory.chronicity,
          value,
        );
        expect(colors.background, colors.foreground.withValues(alpha: 0.12));
      }
    });

    test(
      'disease badge infectious true uses danger; false uses neutral gray',
      () {
        final trueColors = SearchPalette.light.diseaseBadgeColors(
          DiseaseBadgeCategory.infectious,
          'true',
        );
        final falseColors = SearchPalette.light.diseaseBadgeColors(
          DiseaseBadgeCategory.infectious,
          'false',
        );
        final darkTrueColors = SearchPalette.dark.diseaseBadgeColors(
          DiseaseBadgeCategory.infectious,
          'true',
        );

        expect(trueColors.foreground, SearchPalette.light.danger);
        expect(
          trueColors.background,
          SearchPalette.light.danger.withValues(alpha: 0.12),
        );
        expect(falseColors.foreground, const Color(0xFF4B5563));
        expect(darkTrueColors.foreground, SearchPalette.dark.danger);
      },
    );
  });
}
