import 'package:flutter/material.dart';

/// Calc and Round6 spacing scale tokens.
final class AppSpacing extends ThemeExtension<AppSpacing> {
  /// Creates spacing tokens.
  const AppSpacing({
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
    required this.s5,
    required this.s6,
    required this.s7,
    required this.s8,
    required this.s10,
  });

  /// Default design spacing tokens.
  static const tokens = AppSpacing(
    s1: 4,
    s2: 8,
    s3: 12,
    s4: 16,
    s5: 20,
    s6: 24,
    s7: 28,
    s8: 32,
    s10: 40,
  );

  /// 4 px.
  final double s1;

  /// 8 px.
  final double s2;

  /// 12 px.
  final double s3;

  /// 16 px.
  final double s4;

  /// 20 px.
  final double s5;

  /// 24 px.
  final double s6;

  /// 28 px.
  final double s7;

  /// 32 px.
  final double s8;

  /// 40 px.
  final double s10;

  @override
  AppSpacing copyWith({
    double? s1,
    double? s2,
    double? s3,
    double? s4,
    double? s5,
    double? s6,
    double? s7,
    double? s8,
    double? s10,
  }) {
    return AppSpacing(
      s1: s1 ?? this.s1,
      s2: s2 ?? this.s2,
      s3: s3 ?? this.s3,
      s4: s4 ?? this.s4,
      s5: s5 ?? this.s5,
      s6: s6 ?? this.s6,
      s7: s7 ?? this.s7,
      s8: s8 ?? this.s8,
      s10: s10 ?? this.s10,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) {
      return this;
    }
    return AppSpacing(
      s1: _lerpDouble(s1, other.s1, t),
      s2: _lerpDouble(s2, other.s2, t),
      s3: _lerpDouble(s3, other.s3, t),
      s4: _lerpDouble(s4, other.s4, t),
      s5: _lerpDouble(s5, other.s5, t),
      s6: _lerpDouble(s6, other.s6, t),
      s7: _lerpDouble(s7, other.s7, t),
      s8: _lerpDouble(s8, other.s8, t),
      s10: _lerpDouble(s10, other.s10, t),
    );
  }
}

double _lerpDouble(double a, double b, double t) => a + (b - a) * t;
