import 'dart:io';

import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppPalette', () {
    test('light and dark palettes keep the existing search color tokens', () {
      expect(AppPalette.light.bg, const Color(0xFFF2F2F7));
      expect(AppPalette.light.surface, const Color(0xFFFFFFFF));
      expect(AppPalette.light.primary, const Color(0xFF007AFF));
      expect(AppPalette.light.rxTint, const Color(0x1A007AFF));
      expect(AppPalette.light.dxInk, const Color(0xFF7A4FCC));

      expect(AppPalette.dark.bg, const Color(0xFF101317));
      expect(AppPalette.dark.surface, const Color(0xFF181B20));
      expect(AppPalette.dark.primary, const Color(0xFF9ECAFF));
      expect(AppPalette.dark.rxTint, const Color(0x299ECAFF));
      expect(AppPalette.dark.dxInk, const Color(0xFFD5BAFF));
    });

    test('AppTheme provides AppPalette for light and dark themes', () {
      final lightPalette = AppTheme.light().extension<AppPalette>();
      final darkPalette = AppTheme.dark().extension<AppPalette>();

      expect(lightPalette, AppPalette.light);
      expect(darkPalette, AppPalette.dark);
    });

    test('old search palette file is removed after relocation', () {
      final oldPath = [
        'lib',
        'ui',
        'search',
        'constants',
        'search_${'palette'}.dart',
      ].join('/');

      expect(
        File(oldPath).existsSync(),
        isFalse,
      );
    });

    test('codebase no longer references the old palette symbol', () {
      const oldSymbol = 'Search${'Palette'}';
      final offenders = <String>[];

      for (final root in ['lib', 'test']) {
        for (final entity in Directory(root).listSync(recursive: true)) {
          if (entity is! File || !entity.path.endsWith('.dart')) {
            continue;
          }
          if (entity.path == 'test/theme/app_palette_test.dart') {
            continue;
          }
          if (entity.readAsStringSync().contains(oldSymbol)) {
            offenders.add(entity.path);
          }
        }
      }

      expect(offenders, isEmpty);
    });
  });
}
