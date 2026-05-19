import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DetailColorExtension', () {
    test('light colors match Detail Spec frame tokens', () {
      expect(_tokens(DetailColorExtension.light), _lightTokens);
    });

    test('dark colors match Detail Spec frame tokens', () {
      expect(_tokens(DetailColorExtension.dark), _darkTokens);
    });

    test('AppTheme provides DetailColorExtension for light theme', () {
      final lightColors = AppTheme.light().extension<DetailColorExtension>();

      expect(lightColors == null ? null : _tokens(lightColors), _lightTokens);
    });

    test('AppTheme provides DetailColorExtension for dark theme', () {
      final darkColors = AppTheme.dark().extension<DetailColorExtension>();

      expect(darkColors == null ? null : _tokens(darkColors), _darkTokens);
    });
  });
}

Map<String, Color> _tokens(DetailColorExtension colors) {
  return {
    'primary': colors.primary,
    'onPrimary': colors.onPrimary,
    'secondary': colors.secondary,
    'onSecondary': colors.onSecondary,
    'tertiary': colors.tertiary,
    'onTertiary': colors.onTertiary,
    'error': colors.error,
    'onError': colors.onError,
    'errorContainer': colors.errorContainer,
    'onErrorContainer': colors.onErrorContainer,
    'warnContainer': colors.warnContainer,
    'onWarnContainer': colors.onWarnContainer,
    'surface': colors.surface,
    'onSurface': colors.onSurface,
    'onSurfaceVariant': colors.onSurfaceVariant,
    'surfaceContainerLowest': colors.surfaceContainerLowest,
    'surfaceContainerLow': colors.surfaceContainerLow,
    'surfaceContainer': colors.surfaceContainer,
    'surfaceContainerHigh': colors.surfaceContainerHigh,
    'surfaceContainerHighest': colors.surfaceContainerHighest,
    'surfaceTint': colors.surfaceTint,
    'outline': colors.outline,
    'outlineVariant': colors.outlineVariant,
    'primaryContainer': colors.primaryContainer,
    'onPrimaryContainer': colors.onPrimaryContainer,
    'tertiaryContainer': colors.tertiaryContainer,
    'onTertiaryContainer': colors.onTertiaryContainer,
    'shadow': colors.shadow,
    'frameGradientStart': colors.frameGradientStart,
    'frameGradientEnd': colors.frameGradientEnd,
  };
}

const _lightTokens = {
  'primary': Color(0xFF1F5BB5),
  'onPrimary': Color(0xFFFFFFFF),
  'secondary': Color(0xFF525E78),
  'onSecondary': Color(0xFFFFFFFF),
  'tertiary': Color(0xFF705574),
  'onTertiary': Color(0xFFFFFFFF),
  'error': Color(0xFFB3261E),
  'onError': Color(0xFFFFFFFF),
  'errorContainer': Color(0xFFF9DEDC),
  'onErrorContainer': Color(0xFF410E0B),
  'warnContainer': Color(0xFFFFE0E0),
  'onWarnContainer': Color(0xFF5B0A0A),
  'surface': Color(0xFFFBFBFE),
  'onSurface': Color(0xFF1A1B20),
  'onSurfaceVariant': Color(0xFF44464E),
  'surfaceContainerLowest': Color(0xFFFFFFFF),
  'surfaceContainerLow': Color(0xFFF4F4F8),
  'surfaceContainer': Color(0xFFEDEEF3),
  'surfaceContainerHigh': Color(0xFFE7E8EE),
  'surfaceContainerHighest': Color(0xFFE1E2E8),
  'surfaceTint': Color(0xFF1F5BB5),
  'outline': Color(0xFF75777F),
  'outlineVariant': Color(0xFFC5C6CD),
  'primaryContainer': Color(0xFFD8E2FF),
  'onPrimaryContainer': Color(0xFF001A41),
  'tertiaryContainer': Color(0xFFFBD8FF),
  'onTertiaryContainer': Color(0xFF280A2D),
  'shadow': Color(0x14171A2A),
  'frameGradientStart': Color(0xFF0F172A),
  'frameGradientEnd': Color(0xFF0B1220),
};

const _darkTokens = {
  'primary': Color(0xFFAEC6FF),
  'onPrimary': Color(0xFF002E69),
  'secondary': Color(0xFFBBC6E4),
  'onSecondary': Color(0xFF253048),
  'tertiary': Color(0xFFDEBCDF),
  'onTertiary': Color(0xFF3F2843),
  'error': Color(0xFFF2B8B5),
  'onError': Color(0xFF601410),
  'errorContainer': Color(0xFF8C1D18),
  'onErrorContainer': Color(0xFFF9DEDC),
  'warnContainer': Color(0xFF5B0A0A),
  'onWarnContainer': Color(0xFFFFE0E0),
  'surface': Color(0xFF121318),
  'onSurface': Color(0xFFE3E2E9),
  'onSurfaceVariant': Color(0xFFC5C6CD),
  'surfaceContainerLowest': Color(0xFF0D0E13),
  'surfaceContainerLow': Color(0xFF1A1B20),
  'surfaceContainer': Color(0xFF1E1F25),
  'surfaceContainerHigh': Color(0xFF292A30),
  'surfaceContainerHighest': Color(0xFF33343A),
  'surfaceTint': Color(0xFFAEC6FF),
  'outline': Color(0xFF8E9099),
  'outlineVariant': Color(0xFF44464E),
  'primaryContainer': Color(0xFF003494),
  'onPrimaryContainer': Color(0xFFD8E2FF),
  'tertiaryContainer': Color(0xFF573C5B),
  'onTertiaryContainer': Color(0xFFFBD8FF),
  'shadow': Color(0x80000000),
  'frameGradientStart': Color(0xFF1E293B),
  'frameGradientEnd': Color(0xFF0F172A),
};
