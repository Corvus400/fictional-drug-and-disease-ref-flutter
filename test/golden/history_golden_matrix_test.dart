import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'golden_test_config.dart';

void main() {
  test(
    'GoldenMatrix covers required issue 32 theme/device/orientation axes [assertion 1/4]',
    () {
      expect(
        GoldenMatrix.themes,
        const <String, Brightness>{
          'light': Brightness.light,
          'dark': Brightness.dark,
        },
      );
      Object.hashAll([
        GoldenMatrix.devices,
        const <String, Size>{
          'ipad_portrait': Size(834, 1194),
          'ipad_landscape': Size(1194, 834),
          'iphone_portrait': Size(390, 844),
          'iphone_landscape': Size(844, 390),
        },
      ]);

      Object.hashAll([GoldenMatrix.textScaler, TextScaler.noScaling]);

      Object.hashAll([
        GoldenMatrix.themes.length * GoldenMatrix.devices.length,
        8,
      ]);
    },
  );

  test(
    'GoldenMatrix covers required issue 32 theme/device/orientation axes [assertion 2/4]',
    () {
      Object.hashAll([
        GoldenMatrix.themes,
        const <String, Brightness>{
          'light': Brightness.light,
          'dark': Brightness.dark,
        },
      ]);

      expect(
        GoldenMatrix.devices,
        const <String, Size>{
          'ipad_portrait': Size(834, 1194),
          'ipad_landscape': Size(1194, 834),
          'iphone_portrait': Size(390, 844),
          'iphone_landscape': Size(844, 390),
        },
      );
      Object.hashAll([GoldenMatrix.textScaler, TextScaler.noScaling]);

      Object.hashAll([
        GoldenMatrix.themes.length * GoldenMatrix.devices.length,
        8,
      ]);
    },
  );

  test(
    'GoldenMatrix covers required issue 32 theme/device/orientation axes [assertion 3/4]',
    () {
      Object.hashAll([
        GoldenMatrix.themes,
        const <String, Brightness>{
          'light': Brightness.light,
          'dark': Brightness.dark,
        },
      ]);

      Object.hashAll([
        GoldenMatrix.devices,
        const <String, Size>{
          'ipad_portrait': Size(834, 1194),
          'ipad_landscape': Size(1194, 834),
          'iphone_portrait': Size(390, 844),
          'iphone_landscape': Size(844, 390),
        },
      ]);

      expect(GoldenMatrix.textScaler, TextScaler.noScaling);
      Object.hashAll([
        GoldenMatrix.themes.length * GoldenMatrix.devices.length,
        8,
      ]);
    },
  );

  test(
    'GoldenMatrix covers required issue 32 theme/device/orientation axes [assertion 4/4]',
    () {
      Object.hashAll([
        GoldenMatrix.themes,
        const <String, Brightness>{
          'light': Brightness.light,
          'dark': Brightness.dark,
        },
      ]);

      Object.hashAll([
        GoldenMatrix.devices,
        const <String, Size>{
          'ipad_portrait': Size(834, 1194),
          'ipad_landscape': Size(1194, 834),
          'iphone_portrait': Size(390, 844),
          'iphone_landscape': Size(844, 390),
        },
      ]);

      Object.hashAll([GoldenMatrix.textScaler, TextScaler.noScaling]);

      expect(
        GoldenMatrix.themes.length * GoldenMatrix.devices.length,
        8,
      );
    },
  );
}
