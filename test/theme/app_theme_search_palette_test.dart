import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'AppTheme provides AppPalette for light and dark themes [assertion 1/4]',
    () {
      final lightPalette = AppTheme.light().extension<AppPalette>();
      final darkPalette = AppTheme.dark().extension<AppPalette>();

      expect(lightPalette, isNotNull);
      Object.hashAll([darkPalette, isNotNull]);

      Object.hashAll([lightPalette!.brightness, Brightness.light]);

      Object.hashAll([darkPalette!.brightness, Brightness.dark]);
    },
  );

  test(
    'AppTheme provides AppPalette for light and dark themes [assertion 2/4]',
    () {
      final lightPalette = AppTheme.light().extension<AppPalette>();
      final darkPalette = AppTheme.dark().extension<AppPalette>();

      Object.hashAll([lightPalette, isNotNull]);

      expect(darkPalette, isNotNull);
      Object.hashAll([lightPalette!.brightness, Brightness.light]);

      Object.hashAll([darkPalette!.brightness, Brightness.dark]);
    },
  );

  test(
    'AppTheme provides AppPalette for light and dark themes [assertion 3/4]',
    () {
      final lightPalette = AppTheme.light().extension<AppPalette>();
      final darkPalette = AppTheme.dark().extension<AppPalette>();

      Object.hashAll([lightPalette, isNotNull]);

      Object.hashAll([darkPalette, isNotNull]);

      expect(lightPalette!.brightness, Brightness.light);
      Object.hashAll([darkPalette!.brightness, Brightness.dark]);
    },
  );

  test(
    'AppTheme provides AppPalette for light and dark themes [assertion 4/4]',
    () {
      final lightPalette = AppTheme.light().extension<AppPalette>();
      final darkPalette = AppTheme.dark().extension<AppPalette>();

      Object.hashAll([lightPalette, isNotNull]);

      Object.hashAll([darkPalette, isNotNull]);

      Object.hashAll([lightPalette!.brightness, Brightness.light]);

      expect(darkPalette!.brightness, Brightness.dark);
    },
  );
}
