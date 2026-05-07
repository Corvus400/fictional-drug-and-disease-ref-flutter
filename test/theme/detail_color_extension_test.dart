import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DetailColorExtension', () {
    test('light colors match Detail Spec frame tokens', () {
      _expectLightTokens(DetailColorExtension.light);
    });

    test('dark colors match Detail Spec frame tokens', () {
      _expectDarkTokens(DetailColorExtension.dark);
    });

    test(
      'AppTheme provides DetailColorExtension for light and dark themes',
      () {
        final lightColors = AppTheme.light().extension<DetailColorExtension>();
        final darkColors = AppTheme.dark().extension<DetailColorExtension>();

        expect(lightColors, isNotNull);
        expect(darkColors, isNotNull);
        _expectLightTokens(lightColors!);
        _expectDarkTokens(darkColors!);
      },
    );
  });
}

void _expectLightTokens(DetailColorExtension colors) {
  expect(colors.primary, const Color(0xFF1F5BB5));
  expect(colors.onPrimary, const Color(0xFFFFFFFF));
  expect(colors.secondary, const Color(0xFF525E78));
  expect(colors.onSecondary, const Color(0xFFFFFFFF));
  expect(colors.tertiary, const Color(0xFF705574));
  expect(colors.onTertiary, const Color(0xFFFFFFFF));
  expect(colors.error, const Color(0xFFB3261E));
  expect(colors.onError, const Color(0xFFFFFFFF));
  expect(colors.errorContainer, const Color(0xFFF9DEDC));
  expect(colors.onErrorContainer, const Color(0xFF410E0B));
  expect(colors.warnContainer, const Color(0xFFFFE0E0));
  expect(colors.onWarnContainer, const Color(0xFF5B0A0A));
  expect(colors.surface, const Color(0xFFFBFBFE));
  expect(colors.onSurface, const Color(0xFF1A1B20));
  expect(colors.onSurfaceVariant, const Color(0xFF44464E));
  expect(colors.surfaceContainerLowest, const Color(0xFFFFFFFF));
  expect(colors.surfaceContainerLow, const Color(0xFFF4F4F8));
  expect(colors.surfaceContainer, const Color(0xFFEDEEF3));
  expect(colors.surfaceContainerHigh, const Color(0xFFE7E8EE));
  expect(colors.surfaceContainerHighest, const Color(0xFFE1E2E8));
  expect(colors.surfaceTint, const Color(0xFF1F5BB5));
  expect(colors.outline, const Color(0xFF75777F));
  expect(colors.outlineVariant, const Color(0xFFC5C6CD));
  expect(colors.primaryContainer, const Color(0xFFD8E2FF));
  expect(colors.onPrimaryContainer, const Color(0xFF001A41));
  expect(colors.tertiaryContainer, const Color(0xFFFBD8FF));
  expect(colors.onTertiaryContainer, const Color(0xFF280A2D));
  expect(colors.shadow, const Color(0x14171A2A));
  expect(colors.frameGradientStart, const Color(0xFF0F172A));
  expect(colors.frameGradientEnd, const Color(0xFF0B1220));
}

void _expectDarkTokens(DetailColorExtension colors) {
  expect(colors.primary, const Color(0xFFAEC6FF));
  expect(colors.onPrimary, const Color(0xFF002E69));
  expect(colors.secondary, const Color(0xFFBBC6E4));
  expect(colors.onSecondary, const Color(0xFF253048));
  expect(colors.tertiary, const Color(0xFFDEBCDF));
  expect(colors.onTertiary, const Color(0xFF3F2843));
  expect(colors.error, const Color(0xFFF2B8B5));
  expect(colors.onError, const Color(0xFF601410));
  expect(colors.errorContainer, const Color(0xFF8C1D18));
  expect(colors.onErrorContainer, const Color(0xFFF9DEDC));
  expect(colors.warnContainer, const Color(0xFF5B0A0A));
  expect(colors.onWarnContainer, const Color(0xFFFFE0E0));
  expect(colors.surface, const Color(0xFF121318));
  expect(colors.onSurface, const Color(0xFFE3E2E9));
  expect(colors.onSurfaceVariant, const Color(0xFFC5C6CD));
  expect(colors.surfaceContainerLowest, const Color(0xFF0D0E13));
  expect(colors.surfaceContainerLow, const Color(0xFF1A1B20));
  expect(colors.surfaceContainer, const Color(0xFF1E1F25));
  expect(colors.surfaceContainerHigh, const Color(0xFF292A30));
  expect(colors.surfaceContainerHighest, const Color(0xFF33343A));
  expect(colors.surfaceTint, const Color(0xFFAEC6FF));
  expect(colors.outline, const Color(0xFF8E9099));
  expect(colors.outlineVariant, const Color(0xFF44464E));
  expect(colors.primaryContainer, const Color(0xFF003494));
  expect(colors.onPrimaryContainer, const Color(0xFFD8E2FF));
  expect(colors.tertiaryContainer, const Color(0xFF573C5B));
  expect(colors.onTertiaryContainer, const Color(0xFFFBD8FF));
  expect(colors.shadow, const Color(0x80000000));
  expect(colors.frameGradientStart, const Color(0xFF1E293B));
  expect(colors.frameGradientEnd, const Color(0xFF0F172A));
}
