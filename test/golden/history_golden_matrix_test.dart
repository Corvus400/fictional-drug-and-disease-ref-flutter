import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'golden_test_config.dart';

void main() {
  test('HistoryGoldenMatrix covers required theme/device/orientation axes', () {
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
  });
}
