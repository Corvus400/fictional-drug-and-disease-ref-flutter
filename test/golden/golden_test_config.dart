import 'package:flutter/widgets.dart';

/// Golden test common matrix SSOT.
class GoldenMatrix {
  const GoldenMatrix._();

  /// Theme axis: light / dark.
  static const themes = <String, Brightness>{
    'light': Brightness.light,
    'dark': Brightness.dark,
  };

  /// Size axis: phone / tablet.
  static const sizes = <String, Size>{
    'phone': Size(390, 844),
    'tablet': Size(834, 1194),
  };

  /// Text scale axis: normal / large.
  static const textScalers = <String, TextScaler>{
    'normal': TextScaler.noScaling,
    'large': TextScaler.linear(1.3),
  };

  /// Golden capture device pixel ratio.
  static const devicePixelRatio = 2.0;
}
