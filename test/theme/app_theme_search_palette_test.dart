import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppTheme provides AppPalette for light and dark themes', () {
    final lightPalette = AppTheme.light().extension<AppPalette>();
    final darkPalette = AppTheme.dark().extension<AppPalette>();

    expect(lightPalette, isNotNull);
    expect(darkPalette, isNotNull);
    expect(lightPalette!.brightness, Brightness.light);
    expect(darkPalette!.brightness, Brightness.dark);
  });
}
