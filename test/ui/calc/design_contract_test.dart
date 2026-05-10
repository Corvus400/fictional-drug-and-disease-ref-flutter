import 'dart:io';

import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calc design contract', () {
    test('AppPalette calc shell tokens match the design SSOT', () {
      _expectCalcShellTokens(
        AppPalette.light,
        const _CalcShellTokenSpec(
          bg: Color(0xFFF2F2F7),
          surface: Color(0xFFFFFFFF),
          surface2: Color(0xFFF7F7FA),
          surface3: Color(0xFFEFEFF4),
          surface4: Color(0xFFE5E5EA),
          ink: Color(0xFF1A1C1E),
          ink2: Color(0xFF3F4347),
          muted: Color(0xFF6C7177),
          muted2: Color(0xFF8E9298),
          hairline: Color(0x213C3C43),
          hairline2: Color(0x143C3C43),
          primary: Color(0xFF007AFF),
          onPrimary: Color(0xFFFFFFFF),
          primarySoft: Color(0x1A007AFF),
          primaryRing: Color(0x59007AFF),
          primaryContainer: Color(0xFFD8E4FF),
          onPrimaryContainer: Color(0xFF001A41),
          secondary: Color(0xFF525E78),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFD7E3F8),
          onSecondaryContainer: Color(0xFF101C2F),
          tertiary: Color(0xFF705574),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFFBD8FF),
          onTertiaryContainer: Color(0xFF280A2D),
          error: Color(0xFFB3261E),
          onError: Color(0xFFFFFFFF),
          errorContainer: Color(0xFFFFEDED),
          onErrorContainer: Color(0xFF5C1612),
          warn: Color(0xFFB45309),
          warnContainer: Color(0xFFFFEACC),
          onWarnContainer: Color(0xFF4A2A00),
          success: Color(0xFF1F7A3A),
          successContainer: Color(0xFFDDF5E2),
          onSuccessContainer: Color(0xFF0A3517),
          searchFieldBg: Color(0xFFEBEBEF),
          ribbonBg: Color(0xFF1A1C1E),
          ribbonFg: Color(0xFFFFFFFF),
          ribbonAccent: Color(0xFFFFB4AB),
        ),
      );

      _expectCalcShellTokens(
        AppPalette.dark,
        const _CalcShellTokenSpec(
          bg: Color(0xFF101317),
          surface: Color(0xFF181B20),
          surface2: Color(0xFF1F2329),
          surface3: Color(0xFF272B32),
          surface4: Color(0xFF31353D),
          ink: Color(0xFFE5E7EC),
          ink2: Color(0xFFC2C6CD),
          muted: Color(0xFF9CA1AA),
          muted2: Color(0xFF7A7F88),
          hairline: Color(0x1AFFFFFF),
          hairline2: Color(0x0FFFFFFF),
          primary: Color(0xFF9ECAFF),
          onPrimary: Color(0xFF003258),
          primarySoft: Color(0x249ECAFF),
          primaryRing: Color(0x739ECAFF),
          primaryContainer: Color(0xFF003494),
          onPrimaryContainer: Color(0xFFD8E4FF),
          secondary: Color(0xFFBBC6E4),
          onSecondary: Color(0xFF253048),
          secondaryContainer: Color(0xFF39435B),
          onSecondaryContainer: Color(0xFFD7E3F8),
          tertiary: Color(0xFFDEBCDF),
          onTertiary: Color(0xFF3F2843),
          tertiaryContainer: Color(0xFF573C5B),
          onTertiaryContainer: Color(0xFFFBD8FF),
          error: Color(0xFFFFB4AB),
          onError: Color(0xFF601410),
          errorContainer: Color(0xFF5C1612),
          onErrorContainer: Color(0xFFFFE3DC),
          warn: Color(0xFFFFD080),
          warnContainer: Color(0xFF412E10),
          onWarnContainer: Color(0xFFFFE5BD),
          success: Color(0xFF7BD8A0),
          successContainer: Color(0xFF0E3920),
          onSuccessContainer: Color(0xFFC9F5D5),
          searchFieldBg: Color(0xFF272B32),
          ribbonBg: Color(0xFF0D0E13),
          ribbonFg: Color(0xFFFFFFFF),
          ribbonAccent: Color(0xFFFFB4AB),
        ),
      );
    });

    test('AppPalette calc category palettes match the design SSOT', () {
      _expectCategoryPalette(
        AppPalette.light.calcBmiCategoryPalette,
        const <CalcBmiCategoryToken, _CategorySpec>{
          CalcBmiCategoryToken.underweight: _CategorySpec(
            bg: Color(0xFF3F8AE0),
            fg: Color(0xFF06294F),
            shape: Icons.circle,
          ),
          CalcBmiCategoryToken.normal: _CategorySpec(
            bg: Color(0xFF1F7A3A),
            fg: Color(0xFF0A3517),
            shape: Icons.change_history,
          ),
          CalcBmiCategoryToken.overweight: _CategorySpec(
            bg: Color(0xFFB47A00),
            fg: Color(0xFF3A2700),
            shape: Icons.square,
          ),
          CalcBmiCategoryToken.obese1: _CategorySpec(
            bg: Color(0xFFC25600),
            fg: Color(0xFF3D1A00),
            shape: Icons.diamond,
          ),
          CalcBmiCategoryToken.obese2: _CategorySpec(
            bg: Color(0xFFA8341B),
            fg: Color(0xFF3A0F03),
            shape: Icons.pentagon,
          ),
          CalcBmiCategoryToken.obese3: _CategorySpec(
            bg: Color(0xFF8C1D18),
            fg: Color(0xFFFBE9E7),
            shape: Icons.hexagon,
          ),
          CalcBmiCategoryToken.obese4: _CategorySpec(
            bg: Color(0xFF5A1212),
            fg: Color(0xFFFFE3DC),
            shape: Icons.close,
          ),
        },
      );

      _expectCategoryPalette(
        AppPalette.dark.calcBmiCategoryPalette,
        const <CalcBmiCategoryToken, _CategorySpec>{
          CalcBmiCategoryToken.underweight: _CategorySpec(
            bg: Color(0xFF7AB5FF),
            fg: Color(0xFF001A41),
            shape: Icons.circle,
          ),
          CalcBmiCategoryToken.normal: _CategorySpec(
            bg: Color(0xFF7BD8A0),
            fg: Color(0xFF0A3517),
            shape: Icons.change_history,
          ),
          CalcBmiCategoryToken.overweight: _CategorySpec(
            bg: Color(0xFFF5C56A),
            fg: Color(0xFF3A2700),
            shape: Icons.square,
          ),
          CalcBmiCategoryToken.obese1: _CategorySpec(
            bg: Color(0xFFFF9A4A),
            fg: Color(0xFF3D1A00),
            shape: Icons.diamond,
          ),
          CalcBmiCategoryToken.obese2: _CategorySpec(
            bg: Color(0xFFF08C72),
            fg: Color(0xFF3A0F03),
            shape: Icons.pentagon,
          ),
          CalcBmiCategoryToken.obese3: _CategorySpec(
            bg: Color(0xFFF2B8B5),
            fg: Color(0xFF601410),
            shape: Icons.hexagon,
          ),
          CalcBmiCategoryToken.obese4: _CategorySpec(
            bg: Color(0xFFFFB4AB),
            fg: Color(0xFF5A1212),
            shape: Icons.close,
          ),
        },
      );

      _expectCategoryPalette(
        AppPalette.light.calcCkdStagePalette,
        const <CalcCkdStageToken, _CategorySpec>{
          CalcCkdStageToken.g1: _CategorySpec(
            bg: Color(0xFF1F7A3A),
            fg: Color(0xFF0A3517),
            shape: Icons.circle,
          ),
          CalcCkdStageToken.g2: _CategorySpec(
            bg: Color(0xFF5C8A1F),
            fg: Color(0xFF1F2F08),
            shape: Icons.change_history,
          ),
          CalcCkdStageToken.g3a: _CategorySpec(
            bg: Color(0xFFB47A00),
            fg: Color(0xFF3A2700),
            shape: Icons.square,
          ),
          CalcCkdStageToken.g3b: _CategorySpec(
            bg: Color(0xFFC25600),
            fg: Color(0xFF3D1A00),
            shape: Icons.diamond,
          ),
          CalcCkdStageToken.g4: _CategorySpec(
            bg: Color(0xFFA8341B),
            fg: Color(0xFFFBE9E7),
            shape: Icons.hexagon,
          ),
          CalcCkdStageToken.g5: _CategorySpec(
            bg: Color(0xFF5A1212),
            fg: Color(0xFFFFE3DC),
            shape: Icons.close,
          ),
        },
      );

      _expectCategoryPalette(
        AppPalette.dark.calcCkdStagePalette,
        const <CalcCkdStageToken, _CategorySpec>{
          CalcCkdStageToken.g1: _CategorySpec(
            bg: Color(0xFF7BD8A0),
            fg: Color(0xFF0A3517),
            shape: Icons.circle,
          ),
          CalcCkdStageToken.g2: _CategorySpec(
            bg: Color(0xFFBFD96E),
            fg: Color(0xFF1F2F08),
            shape: Icons.change_history,
          ),
          CalcCkdStageToken.g3a: _CategorySpec(
            bg: Color(0xFFF5C56A),
            fg: Color(0xFF3A2700),
            shape: Icons.square,
          ),
          CalcCkdStageToken.g3b: _CategorySpec(
            bg: Color(0xFFFF9A4A),
            fg: Color(0xFF3D1A00),
            shape: Icons.diamond,
          ),
          CalcCkdStageToken.g4: _CategorySpec(
            bg: Color(0xFFF08C72),
            fg: Color(0xFF3A0F03),
            shape: Icons.hexagon,
          ),
          CalcCkdStageToken.g5: _CategorySpec(
            bg: Color(0xFFFFB4AB),
            fg: Color(0xFF5A1212),
            shape: Icons.close,
          ),
        },
      );
    });

    test('AppSpacing matches the design SSOT', () {
      expect(AppSpacing.tokens.s1, 4);
      expect(AppSpacing.tokens.s2, 8);
      expect(AppSpacing.tokens.s3, 12);
      expect(AppSpacing.tokens.s4, 16);
      expect(AppSpacing.tokens.s5, 20);
      expect(AppSpacing.tokens.s6, 24);
      expect(AppSpacing.tokens.s7, 28);
      expect(AppSpacing.tokens.s8, 32);
      expect(AppSpacing.tokens.s10, 40);
    });

    test('AppRadii matches the design SSOT', () {
      expect(AppRadii.tokens.badge, 4);
      expect(AppRadii.tokens.chip, 5);
      expect(AppRadii.tokens.tile, 8);
      expect(AppRadii.tokens.card, 10);
      expect(AppRadii.tokens.sheetCard, 12);
      expect(AppRadii.tokens.fab, 18);
      expect(AppRadii.tokens.sheetTop, 20);
      expect(AppRadii.tokens.pill, 22);
    });

    test('AppTypography matches the design SSOT', () {
      _expectTextStyle(
        AppTypography.tokens.displayL,
        fontFamily: 'NotoSansJP',
        fontSize: 34,
        fontWeight: FontWeight.w700,
        height: 1.18,
      );
      _expectTextStyle(
        AppTypography.tokens.displayM,
        fontFamily: 'NotoSansJP',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.20,
      );
      _expectTextStyle(
        AppTypography.tokens.titleL,
        fontFamily: 'NotoSansJP',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.25,
      );
      _expectTextStyle(
        AppTypography.tokens.titleM,
        fontFamily: 'NotoSansJP',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.30,
      );
      _expectTextStyle(
        AppTypography.tokens.bodyM,
        fontFamily: 'NotoSansJP',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.55,
      );
      _expectTextStyle(
        AppTypography.tokens.bodyS,
        fontFamily: 'NotoSansJP',
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.50,
      );
      _expectTextStyle(
        AppTypography.tokens.labelM,
        fontFamily: 'NotoSansJP',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.40,
      );
      _expectTextStyle(
        AppTypography.tokens.labelS,
        fontFamily: 'NotoSansJP',
        fontSize: 11,
        fontWeight: FontWeight.w700,
        height: 1.35,
      );
      _expectTextStyle(
        AppTypography.tokens.monoS,
        fontFamily: 'JetBrainsMono',
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 1.40,
      );
    });

    test('AppTheme registers calc design token extensions', () {
      final light = AppTheme.light();
      final dark = AppTheme.dark();

      expect(light.extension<AppSpacing>(), AppSpacing.tokens);
      expect(dark.extension<AppSpacing>(), AppSpacing.tokens);
      expect(light.extension<AppRadii>(), AppRadii.tokens);
      expect(dark.extension<AppRadii>(), AppRadii.tokens);
      expect(light.extension<AppTypography>(), AppTypography.tokens);
      expect(dark.extension<AppTypography>(), AppTypography.tokens);
    });

    test('Calc production UI does not depend on Material Symbols package', () {
      final calcFiles = Directory('lib/ui/calc')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'));

      final offenders = <String>[];
      for (final file in calcFiles) {
        final source = file.readAsStringSync();
        if (source.contains('package:material_symbols_icons') ||
            source.contains('Symbols.')) {
          offenders.add(file.path);
        }
      }

      expect(offenders, isEmpty);
    });
  });
}

void _expectTextStyle(
  TextStyle actual, {
  required String fontFamily,
  required double fontSize,
  required FontWeight fontWeight,
  required double height,
}) {
  expect(actual.fontFamily, fontFamily);
  expect(actual.fontSize, fontSize);
  expect(actual.fontWeight, fontWeight);
  expect(actual.height, height);
}

void _expectCalcShellTokens(AppPalette palette, _CalcShellTokenSpec spec) {
  expect(palette.calcBg, spec.bg);
  expect(palette.calcSurface, spec.surface);
  expect(palette.calcSurface2, spec.surface2);
  expect(palette.calcSurface3, spec.surface3);
  expect(palette.calcSurface4, spec.surface4);
  expect(palette.calcInk, spec.ink);
  expect(palette.calcInk2, spec.ink2);
  expect(palette.calcMuted, spec.muted);
  expect(palette.calcMuted2, spec.muted2);
  expect(palette.calcHairline, spec.hairline);
  expect(palette.calcHairline2, spec.hairline2);
  expect(palette.calcPrimary, spec.primary);
  expect(palette.calcOnPrimary, spec.onPrimary);
  expect(palette.calcPrimarySoft, spec.primarySoft);
  expect(palette.calcPrimaryRing, spec.primaryRing);
  expect(palette.calcPrimaryContainer, spec.primaryContainer);
  expect(palette.calcOnPrimaryContainer, spec.onPrimaryContainer);
  expect(palette.calcSecondary, spec.secondary);
  expect(palette.calcOnSecondary, spec.onSecondary);
  expect(palette.calcSecondaryContainer, spec.secondaryContainer);
  expect(palette.calcOnSecondaryContainer, spec.onSecondaryContainer);
  expect(palette.calcTertiary, spec.tertiary);
  expect(palette.calcOnTertiary, spec.onTertiary);
  expect(palette.calcTertiaryContainer, spec.tertiaryContainer);
  expect(palette.calcOnTertiaryContainer, spec.onTertiaryContainer);
  expect(palette.calcError, spec.error);
  expect(palette.calcOnError, spec.onError);
  expect(palette.calcErrorContainer, spec.errorContainer);
  expect(palette.calcOnErrorContainer, spec.onErrorContainer);
  expect(palette.calcWarn, spec.warn);
  expect(palette.calcWarnContainer, spec.warnContainer);
  expect(palette.calcOnWarnContainer, spec.onWarnContainer);
  expect(palette.calcSuccess, spec.success);
  expect(palette.calcSuccessContainer, spec.successContainer);
  expect(palette.calcOnSuccessContainer, spec.onSuccessContainer);
  expect(palette.calcSearchFieldBg, spec.searchFieldBg);
  expect(palette.calcRibbonBg, spec.ribbonBg);
  expect(palette.calcRibbonFg, spec.ribbonFg);
  expect(palette.calcRibbonAccent, spec.ribbonAccent);
}

final class _CalcShellTokenSpec {
  const _CalcShellTokenSpec({
    required this.bg,
    required this.surface,
    required this.surface2,
    required this.surface3,
    required this.surface4,
    required this.ink,
    required this.ink2,
    required this.muted,
    required this.muted2,
    required this.hairline,
    required this.hairline2,
    required this.primary,
    required this.onPrimary,
    required this.primarySoft,
    required this.primaryRing,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.warn,
    required this.warnContainer,
    required this.onWarnContainer,
    required this.success,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.searchFieldBg,
    required this.ribbonBg,
    required this.ribbonFg,
    required this.ribbonAccent,
  });

  final Color bg;
  final Color surface;
  final Color surface2;
  final Color surface3;
  final Color surface4;
  final Color ink;
  final Color ink2;
  final Color muted;
  final Color muted2;
  final Color hairline;
  final Color hairline2;
  final Color primary;
  final Color onPrimary;
  final Color primarySoft;
  final Color primaryRing;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color warn;
  final Color warnContainer;
  final Color onWarnContainer;
  final Color success;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color searchFieldBg;
  final Color ribbonBg;
  final Color ribbonFg;
  final Color ribbonAccent;
}

void _expectCategoryPalette<K>(
  Map<K, ({Color bg, Color fg, IconData shape})> actual,
  Map<K, _CategorySpec> expected,
) {
  expect(actual.keys.toSet(), expected.keys.toSet());
  for (final entry in expected.entries) {
    final actualEntry = actual[entry.key];
    expect(actualEntry?.bg, entry.value.bg, reason: '$K ${entry.key} bg');
    expect(actualEntry?.fg, entry.value.fg, reason: '$K ${entry.key} fg');
    expect(
      actualEntry?.shape,
      entry.value.shape,
      reason: '$K ${entry.key} shape',
    );
  }
}

final class _CategorySpec {
  const _CategorySpec({
    required this.bg,
    required this.fg,
    required this.shape,
  });

  final Color bg;
  final Color fg;
  final IconData shape;
}
