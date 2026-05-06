import 'dart:math' as math;

import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchPalette', () {
    group('regulatoryBadgeColors', () {
      test('returns light hex for poison value in light brightness', () {
        final result = SearchPalette.light.regulatoryBadgeColors('poison');

        expect(result.foreground, const Color(0xFFD62A2A));
      });

      test('returns dark hex for poison value in dark brightness', () {
        final result = SearchPalette.dark.regulatoryBadgeColors('poison');

        expect(result.foreground, const Color(0xFFFFB4AB));
      });

      test(
        'keeps readable contrast for all drug regulatory values',
        () {
          const values = [
            'poison',
            'potent',
            'prescription_required',
            'psychotropic_1',
            'psychotropic_2',
            'psychotropic_3',
            'narcotic',
            'stimulant_precursor',
            'biological',
            'specified_biological',
            'ordinary',
          ];

          for (final palette in [SearchPalette.light, SearchPalette.dark]) {
            for (final value in values) {
              final colors = palette.regulatoryBadgeColors(value);

              expect(
                _contrastOnSurface(
                  colors.foreground,
                  colors.background,
                  palette.surface,
                ),
                greaterThanOrEqualTo(3),
                reason: 'value=$value brightness=${palette.brightness}',
              );
            }
          }
        },
      );
    });

    group('primary action colors', () {
      test('light bg and fg match Round6 spec', () {
        expect(
          SearchPalette.light.searchPrimaryActionBg,
          const Color(0xFF007AFF),
        );
        expect(
          SearchPalette.light.searchPrimaryActionFg,
          const Color(0xFFFFFFFF),
        );
      });

      test('dark bg and fg match Round6 spec', () {
        expect(
          SearchPalette.dark.searchPrimaryActionBg,
          const Color(0xFF00497F),
        );
        expect(
          SearchPalette.dark.searchPrimaryActionFg,
          const Color(0xFF003258),
        );
      });
    });

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
      const values = ['acute', 'chronic', 'episodic', 'remission'];

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
        expect(colors.background, colors.foreground.withValues(alpha: 0.02));
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
          SearchPalette.light.danger.withValues(alpha: 0.02),
        );
        expect(falseColors.foreground, const Color(0xFF0F766E));
        expect(darkTrueColors.foreground, SearchPalette.dark.danger);
      },
    );

    test('disease badge department colors differ across all 16 values', () {
      const values = [
        'internal_medicine',
        'cardiology',
        'gastroenterology',
        'endocrinology',
        'neurology',
        'psychiatry',
        'surgery',
        'orthopedics',
        'dermatology',
        'ophthalmology',
        'otolaryngology',
        'urology',
        'gynecology',
        'pediatrics',
        'emergency',
        'infectious_disease',
      ];

      final foregrounds = {
        for (final value in values)
          SearchPalette.light
              .diseaseBadgeColors(DiseaseBadgeCategory.department, value)
              .foreground,
      };

      expect(foregrounds.length, greaterThanOrEqualTo(12));
      expect(
        SearchPalette.light
            .diseaseBadgeColors(
              DiseaseBadgeCategory.department,
              'psychiatry',
            )
            .foreground,
        const Color(0xFF6D28D9),
      );
      expect(
        SearchPalette.light
            .diseaseBadgeColors(
              DiseaseBadgeCategory.department,
              'cardiology',
            )
            .foreground,
        isNot(
          SearchPalette.light
              .diseaseBadgeColors(
                DiseaseBadgeCategory.department,
                'emergency',
              )
              .foreground,
        ),
      );
    });
  });
}

double _contrast(Color a, Color b) {
  final l1 = _relativeLuminance(a);
  final l2 = _relativeLuminance(b);
  final lighter = l1 > l2 ? l1 : l2;
  final darker = l1 > l2 ? l2 : l1;
  return (lighter + 0.05) / (darker + 0.05);
}

double _contrastOnSurface(Color foreground, Color background, Color surface) {
  return _contrast(foreground, _composite(background, surface));
}

Color _composite(Color foreground, Color background) {
  final alpha = foreground.a;
  final r = foreground.r * alpha + background.r * (1 - alpha);
  final g = foreground.g * alpha + background.g * (1 - alpha);
  final b = foreground.b * alpha + background.b * (1 - alpha);
  return Color.from(
    alpha: 1,
    red: r,
    green: g,
    blue: b,
  );
}

double _relativeLuminance(Color color) {
  double channel(double value) {
    final normalized = value / 255;
    if (normalized <= 0.03928) {
      return normalized / 12.92;
    }
    return math.pow((normalized + 0.055) / 1.055, 2.4).toDouble();
  }

  return 0.2126 * channel(color.r * 255) +
      0.7152 * channel(color.g * 255) +
      0.0722 * channel(color.b * 255);
}
