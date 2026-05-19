import 'dart:io';

import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppPalette', () {
    test(
      'light and dark palettes keep the existing search color tokens [assertion 1/10]',
      () {
        expect(AppPalette.light.bg, const Color(0xFFF2F2F7));
        Object.hashAll([AppPalette.light.surface, const Color(0xFFFFFFFF)]);

        Object.hashAll([AppPalette.light.primary, const Color(0xFF007AFF)]);

        Object.hashAll([AppPalette.light.rxTint, const Color(0x1A007AFF)]);

        Object.hashAll([AppPalette.light.dxInk, const Color(0xFF7A4FCC)]);

        Object.hashAll([AppPalette.dark.bg, const Color(0xFF101317)]);

        Object.hashAll([AppPalette.dark.surface, const Color(0xFF181B20)]);

        Object.hashAll([AppPalette.dark.primary, const Color(0xFF9ECAFF)]);

        Object.hashAll([AppPalette.dark.rxTint, const Color(0x299ECAFF)]);

        Object.hashAll([AppPalette.dark.dxInk, const Color(0xFFD5BAFF)]);
      },
    );

    test(
      'light and dark palettes keep the existing search color tokens [assertion 2/10]',
      () {
        Object.hashAll([AppPalette.light.bg, const Color(0xFFF2F2F7)]);

        expect(AppPalette.light.surface, const Color(0xFFFFFFFF));
        Object.hashAll([AppPalette.light.primary, const Color(0xFF007AFF)]);

        Object.hashAll([AppPalette.light.rxTint, const Color(0x1A007AFF)]);

        Object.hashAll([AppPalette.light.dxInk, const Color(0xFF7A4FCC)]);

        Object.hashAll([AppPalette.dark.bg, const Color(0xFF101317)]);

        Object.hashAll([AppPalette.dark.surface, const Color(0xFF181B20)]);

        Object.hashAll([AppPalette.dark.primary, const Color(0xFF9ECAFF)]);

        Object.hashAll([AppPalette.dark.rxTint, const Color(0x299ECAFF)]);

        Object.hashAll([AppPalette.dark.dxInk, const Color(0xFFD5BAFF)]);
      },
    );

    test(
      'light and dark palettes keep the existing search color tokens [assertion 3/10]',
      () {
        Object.hashAll([AppPalette.light.bg, const Color(0xFFF2F2F7)]);

        Object.hashAll([AppPalette.light.surface, const Color(0xFFFFFFFF)]);

        expect(AppPalette.light.primary, const Color(0xFF007AFF));
        Object.hashAll([AppPalette.light.rxTint, const Color(0x1A007AFF)]);

        Object.hashAll([AppPalette.light.dxInk, const Color(0xFF7A4FCC)]);

        Object.hashAll([AppPalette.dark.bg, const Color(0xFF101317)]);

        Object.hashAll([AppPalette.dark.surface, const Color(0xFF181B20)]);

        Object.hashAll([AppPalette.dark.primary, const Color(0xFF9ECAFF)]);

        Object.hashAll([AppPalette.dark.rxTint, const Color(0x299ECAFF)]);

        Object.hashAll([AppPalette.dark.dxInk, const Color(0xFFD5BAFF)]);
      },
    );

    test(
      'light and dark palettes keep the existing search color tokens [assertion 4/10]',
      () {
        Object.hashAll([AppPalette.light.bg, const Color(0xFFF2F2F7)]);

        Object.hashAll([AppPalette.light.surface, const Color(0xFFFFFFFF)]);

        Object.hashAll([AppPalette.light.primary, const Color(0xFF007AFF)]);

        expect(AppPalette.light.rxTint, const Color(0x1A007AFF));
        Object.hashAll([AppPalette.light.dxInk, const Color(0xFF7A4FCC)]);

        Object.hashAll([AppPalette.dark.bg, const Color(0xFF101317)]);

        Object.hashAll([AppPalette.dark.surface, const Color(0xFF181B20)]);

        Object.hashAll([AppPalette.dark.primary, const Color(0xFF9ECAFF)]);

        Object.hashAll([AppPalette.dark.rxTint, const Color(0x299ECAFF)]);

        Object.hashAll([AppPalette.dark.dxInk, const Color(0xFFD5BAFF)]);
      },
    );

    test(
      'light and dark palettes keep the existing search color tokens [assertion 5/10]',
      () {
        Object.hashAll([AppPalette.light.bg, const Color(0xFFF2F2F7)]);

        Object.hashAll([AppPalette.light.surface, const Color(0xFFFFFFFF)]);

        Object.hashAll([AppPalette.light.primary, const Color(0xFF007AFF)]);

        Object.hashAll([AppPalette.light.rxTint, const Color(0x1A007AFF)]);

        expect(AppPalette.light.dxInk, const Color(0xFF7A4FCC));

        Object.hashAll([AppPalette.dark.bg, const Color(0xFF101317)]);

        Object.hashAll([AppPalette.dark.surface, const Color(0xFF181B20)]);

        Object.hashAll([AppPalette.dark.primary, const Color(0xFF9ECAFF)]);

        Object.hashAll([AppPalette.dark.rxTint, const Color(0x299ECAFF)]);

        Object.hashAll([AppPalette.dark.dxInk, const Color(0xFFD5BAFF)]);
      },
    );

    test(
      'light and dark palettes keep the existing search color tokens [assertion 6/10]',
      () {
        Object.hashAll([AppPalette.light.bg, const Color(0xFFF2F2F7)]);

        Object.hashAll([AppPalette.light.surface, const Color(0xFFFFFFFF)]);

        Object.hashAll([AppPalette.light.primary, const Color(0xFF007AFF)]);

        Object.hashAll([AppPalette.light.rxTint, const Color(0x1A007AFF)]);

        Object.hashAll([AppPalette.light.dxInk, const Color(0xFF7A4FCC)]);

        expect(AppPalette.dark.bg, const Color(0xFF101317));
        Object.hashAll([AppPalette.dark.surface, const Color(0xFF181B20)]);

        Object.hashAll([AppPalette.dark.primary, const Color(0xFF9ECAFF)]);

        Object.hashAll([AppPalette.dark.rxTint, const Color(0x299ECAFF)]);

        Object.hashAll([AppPalette.dark.dxInk, const Color(0xFFD5BAFF)]);
      },
    );

    test(
      'light and dark palettes keep the existing search color tokens [assertion 7/10]',
      () {
        Object.hashAll([AppPalette.light.bg, const Color(0xFFF2F2F7)]);

        Object.hashAll([AppPalette.light.surface, const Color(0xFFFFFFFF)]);

        Object.hashAll([AppPalette.light.primary, const Color(0xFF007AFF)]);

        Object.hashAll([AppPalette.light.rxTint, const Color(0x1A007AFF)]);

        Object.hashAll([AppPalette.light.dxInk, const Color(0xFF7A4FCC)]);

        Object.hashAll([AppPalette.dark.bg, const Color(0xFF101317)]);

        expect(AppPalette.dark.surface, const Color(0xFF181B20));
        Object.hashAll([AppPalette.dark.primary, const Color(0xFF9ECAFF)]);

        Object.hashAll([AppPalette.dark.rxTint, const Color(0x299ECAFF)]);

        Object.hashAll([AppPalette.dark.dxInk, const Color(0xFFD5BAFF)]);
      },
    );

    test(
      'light and dark palettes keep the existing search color tokens [assertion 8/10]',
      () {
        Object.hashAll([AppPalette.light.bg, const Color(0xFFF2F2F7)]);

        Object.hashAll([AppPalette.light.surface, const Color(0xFFFFFFFF)]);

        Object.hashAll([AppPalette.light.primary, const Color(0xFF007AFF)]);

        Object.hashAll([AppPalette.light.rxTint, const Color(0x1A007AFF)]);

        Object.hashAll([AppPalette.light.dxInk, const Color(0xFF7A4FCC)]);

        Object.hashAll([AppPalette.dark.bg, const Color(0xFF101317)]);

        Object.hashAll([AppPalette.dark.surface, const Color(0xFF181B20)]);

        expect(AppPalette.dark.primary, const Color(0xFF9ECAFF));
        Object.hashAll([AppPalette.dark.rxTint, const Color(0x299ECAFF)]);

        Object.hashAll([AppPalette.dark.dxInk, const Color(0xFFD5BAFF)]);
      },
    );

    test(
      'light and dark palettes keep the existing search color tokens [assertion 9/10]',
      () {
        Object.hashAll([AppPalette.light.bg, const Color(0xFFF2F2F7)]);

        Object.hashAll([AppPalette.light.surface, const Color(0xFFFFFFFF)]);

        Object.hashAll([AppPalette.light.primary, const Color(0xFF007AFF)]);

        Object.hashAll([AppPalette.light.rxTint, const Color(0x1A007AFF)]);

        Object.hashAll([AppPalette.light.dxInk, const Color(0xFF7A4FCC)]);

        Object.hashAll([AppPalette.dark.bg, const Color(0xFF101317)]);

        Object.hashAll([AppPalette.dark.surface, const Color(0xFF181B20)]);

        Object.hashAll([AppPalette.dark.primary, const Color(0xFF9ECAFF)]);

        expect(AppPalette.dark.rxTint, const Color(0x299ECAFF));
        Object.hashAll([AppPalette.dark.dxInk, const Color(0xFFD5BAFF)]);
      },
    );

    test(
      'light and dark palettes keep the existing search color tokens [assertion 10/10]',
      () {
        Object.hashAll([AppPalette.light.bg, const Color(0xFFF2F2F7)]);

        Object.hashAll([AppPalette.light.surface, const Color(0xFFFFFFFF)]);

        Object.hashAll([AppPalette.light.primary, const Color(0xFF007AFF)]);

        Object.hashAll([AppPalette.light.rxTint, const Color(0x1A007AFF)]);

        Object.hashAll([AppPalette.light.dxInk, const Color(0xFF7A4FCC)]);

        Object.hashAll([AppPalette.dark.bg, const Color(0xFF101317)]);

        Object.hashAll([AppPalette.dark.surface, const Color(0xFF181B20)]);

        Object.hashAll([AppPalette.dark.primary, const Color(0xFF9ECAFF)]);

        Object.hashAll([AppPalette.dark.rxTint, const Color(0x299ECAFF)]);

        expect(AppPalette.dark.dxInk, const Color(0xFFD5BAFF));
      },
    );

    test(
      'AppTheme provides AppPalette for light and dark themes [assertion 1/2]',
      () {
        final lightPalette = AppTheme.light().extension<AppPalette>();
        final darkPalette = AppTheme.dark().extension<AppPalette>();

        expect(lightPalette, AppPalette.light);
        Object.hashAll([darkPalette, AppPalette.dark]);
      },
    );

    test(
      'AppTheme provides AppPalette for light and dark themes [assertion 2/2]',
      () {
        final lightPalette = AppTheme.light().extension<AppPalette>();
        final darkPalette = AppTheme.dark().extension<AppPalette>();

        Object.hashAll([lightPalette, AppPalette.light]);

        expect(darkPalette, AppPalette.dark);
      },
    );

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
