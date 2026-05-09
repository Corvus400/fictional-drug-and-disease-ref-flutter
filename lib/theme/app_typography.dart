import 'package:flutter/material.dart';

/// Calc and Round6 typography ramp tokens.
final class AppTypography extends ThemeExtension<AppTypography> {
  /// Creates typography tokens.
  const AppTypography({
    required this.displayL,
    required this.displayM,
    required this.titleL,
    required this.titleM,
    required this.bodyM,
    required this.bodyS,
    required this.labelM,
    required this.labelS,
    required this.monoS,
  });

  static const _notoSansJp = 'NotoSansJP';
  static const _jetBrainsMono = 'JetBrainsMono';

  /// Default design typography tokens.
  static const tokens = AppTypography(
    displayL: TextStyle(
      fontFamily: _notoSansJp,
      fontSize: 34,
      fontWeight: FontWeight.w700,
      fontVariations: [FontVariation('wght', 700)],
      height: 1.18,
    ),
    displayM: TextStyle(
      fontFamily: _notoSansJp,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      fontVariations: [FontVariation('wght', 700)],
      height: 1.20,
    ),
    titleL: TextStyle(
      fontFamily: _notoSansJp,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontVariations: [FontVariation('wght', 700)],
      height: 1.25,
    ),
    titleM: TextStyle(
      fontFamily: _notoSansJp,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontVariations: [FontVariation('wght', 700)],
      height: 1.30,
    ),
    bodyM: TextStyle(
      fontFamily: _notoSansJp,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontVariations: [FontVariation('wght', 400)],
      height: 1.55,
    ),
    bodyS: TextStyle(
      fontFamily: _notoSansJp,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      fontVariations: [FontVariation('wght', 400)],
      height: 1.50,
    ),
    labelM: TextStyle(
      fontFamily: _notoSansJp,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontVariations: [FontVariation('wght', 500)],
      height: 1.40,
    ),
    labelS: TextStyle(
      fontFamily: _notoSansJp,
      fontSize: 11,
      fontWeight: FontWeight.w700,
      fontVariations: [FontVariation('wght', 700)],
      height: 1.35,
    ),
    monoS: TextStyle(
      fontFamily: _jetBrainsMono,
      fontSize: 11,
      fontWeight: FontWeight.w400,
      fontVariations: [FontVariation('wght', 400)],
      height: 1.40,
    ),
  );

  /// Display large text style.
  final TextStyle displayL;

  /// Display medium text style.
  final TextStyle displayM;

  /// Title large text style.
  final TextStyle titleL;

  /// Title medium text style.
  final TextStyle titleM;

  /// Body medium text style.
  final TextStyle bodyM;

  /// Body small text style.
  final TextStyle bodyS;

  /// Label medium text style.
  final TextStyle labelM;

  /// Label small text style.
  final TextStyle labelS;

  /// Monospace small text style.
  final TextStyle monoS;

  @override
  AppTypography copyWith({
    TextStyle? displayL,
    TextStyle? displayM,
    TextStyle? titleL,
    TextStyle? titleM,
    TextStyle? bodyM,
    TextStyle? bodyS,
    TextStyle? labelM,
    TextStyle? labelS,
    TextStyle? monoS,
  }) {
    return AppTypography(
      displayL: displayL ?? this.displayL,
      displayM: displayM ?? this.displayM,
      titleL: titleL ?? this.titleL,
      titleM: titleM ?? this.titleM,
      bodyM: bodyM ?? this.bodyM,
      bodyS: bodyS ?? this.bodyS,
      labelM: labelM ?? this.labelM,
      labelS: labelS ?? this.labelS,
      monoS: monoS ?? this.monoS,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) {
      return this;
    }
    return AppTypography(
      displayL: TextStyle.lerp(displayL, other.displayL, t)!,
      displayM: TextStyle.lerp(displayM, other.displayM, t)!,
      titleL: TextStyle.lerp(titleL, other.titleL, t)!,
      titleM: TextStyle.lerp(titleM, other.titleM, t)!,
      bodyM: TextStyle.lerp(bodyM, other.bodyM, t)!,
      bodyS: TextStyle.lerp(bodyS, other.bodyS, t)!,
      labelM: TextStyle.lerp(labelM, other.labelM, t)!,
      labelS: TextStyle.lerp(labelS, other.labelS, t)!,
      monoS: TextStyle.lerp(monoS, other.monoS, t)!,
    );
  }
}
