import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'golden_test_config.dart';

void main() {
  test(
    'HistoryGoldenMatrix covers required theme/device/orientation/text axes',
    () {
      expect(
        HistoryGoldenMatrix.themes,
        const <String, Brightness>{
          'light': Brightness.light,
          'dark': Brightness.dark,
        },
      );
      expect(
        HistoryGoldenMatrix.devices,
        const <String, Size>{
          'iphone_portrait': Size(390, 844),
          'iphone_landscape': Size(844, 390),
          'ipad_portrait': Size(834, 1194),
          'ipad_landscape': Size(1194, 834),
        },
      );
      expect(
        HistoryGoldenMatrix.textScalers,
        const <String, TextScaler>{
          'normal': TextScaler.noScaling,
          'large': TextScaler.linear(1.3),
          'accessibility': TextScaler.linear(2),
        },
      );
      expect(
        HistoryGoldenMatrix.themes.length *
            HistoryGoldenMatrix.devices.length *
            HistoryGoldenMatrix.textScalers.length,
        24,
      );
    },
  );
}
