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

/// Browsing-history design matrix SSOT.
class HistoryGoldenMatrix {
  const HistoryGoldenMatrix._();

  /// Theme axis required by the browsing-history design contract.
  static const Map<String, Brightness> themes = GoldenMatrix.themes;

  /// Device and orientation axis required by the browsing-history design.
  static const devices = <String, Size>{
    'iphone_portrait': Size(390, 844),
    'iphone_landscape': Size(844, 390),
    'ipad_portrait': Size(834, 1194),
    'ipad_landscape': Size(1194, 834),
  };

  /// Golden capture device pixel ratio.
  static const double devicePixelRatio = GoldenMatrix.devicePixelRatio;
}
