import 'package:flutter/widgets.dart';

/// Golden test common matrix SSOT.
class GoldenMatrix {
  const GoldenMatrix._();

  /// Theme axis: light / dark.
  static const themes = <String, Brightness>{
    'light': Brightness.light,
    'dark': Brightness.dark,
  };

  /// Device/orientation axis required by Issue #32.
  static const devices = <String, Size>{
    'ipad_portrait': Size(834, 1194),
    'ipad_landscape': Size(1194, 834),
    'iphone_portrait': Size(390, 844),
    'iphone_landscape': Size(844, 390),
  };

  /// Golden VRT text scale is fixed so every PNG has one visual concern.
  static const TextScaler textScaler = TextScaler.noScaling;

  /// Golden capture device pixel ratio.
  static const devicePixelRatio = 2.0;
}
