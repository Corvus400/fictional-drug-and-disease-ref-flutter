import 'package:flutter/material.dart';

/// Round6 search color tokens.
final class SearchPalette extends ThemeExtension<SearchPalette> {
  /// Creates a palette.
  const SearchPalette({
    required this.brightness,
    required this.background,
    required this.surfaceSubtle,
    required this.hairline,
    required this.primarySoft,
    required this.primaryRing,
    required this.danger,
    required this.drugTint,
    required this.drugInk,
    required this.diseaseTint,
    required this.diseaseInk,
  });

  /// Light Round6 palette.
  static const light = SearchPalette(
    brightness: Brightness.light,
    background: Color(0xFFF2F2F7),
    surfaceSubtle: Color(0xFFEFEFF4),
    hairline: Color(0x213C3C43),
    primarySoft: Color(0x1A007AFF),
    primaryRing: Color(0x59007AFF),
    danger: Color(0xFFD62A2A),
    drugTint: Color(0x1A007AFF),
    drugInk: Color(0xFF0A6FE8),
    diseaseTint: Color(0x1A7A4FCC),
    diseaseInk: Color(0xFF7A4FCC),
  );

  /// Dark Round6 palette.
  static const dark = SearchPalette(
    brightness: Brightness.dark,
    background: Color(0xFF101317),
    surfaceSubtle: Color(0xFF272B32),
    hairline: Color(0x1AFFFFFF),
    primarySoft: Color(0x249ECAFF),
    primaryRing: Color(0x739ECAFF),
    danger: Color(0xFFFFB4AB),
    drugTint: Color(0x299ECAFF),
    drugInk: Color(0xFF9ECAFF),
    diseaseTint: Color(0x29D5BAFF),
    diseaseInk: Color(0xFFD5BAFF),
  );

  /// Theme brightness this palette represents.
  final Brightness brightness;

  /// Search page background.
  final Color background;

  /// Subtle surface used for input fields and empty containers.
  final Color surfaceSubtle;

  /// Hairline color.
  final Color hairline;

  /// Soft primary fill.
  final Color primarySoft;

  /// Primary focus ring.
  final Color primaryRing;

  /// Destructive/accent danger color.
  final Color danger;

  /// Drug target pill tint.
  final Color drugTint;

  /// Drug target pill ink.
  final Color drugInk;

  /// Disease target pill tint.
  final Color diseaseTint;

  /// Disease target pill ink.
  final Color diseaseInk;

  @override
  SearchPalette copyWith({
    Brightness? brightness,
    Color? background,
    Color? surfaceSubtle,
    Color? hairline,
    Color? primarySoft,
    Color? primaryRing,
    Color? danger,
    Color? drugTint,
    Color? drugInk,
    Color? diseaseTint,
    Color? diseaseInk,
  }) {
    return SearchPalette(
      brightness: brightness ?? this.brightness,
      background: background ?? this.background,
      surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
      hairline: hairline ?? this.hairline,
      primarySoft: primarySoft ?? this.primarySoft,
      primaryRing: primaryRing ?? this.primaryRing,
      danger: danger ?? this.danger,
      drugTint: drugTint ?? this.drugTint,
      drugInk: drugInk ?? this.drugInk,
      diseaseTint: diseaseTint ?? this.diseaseTint,
      diseaseInk: diseaseInk ?? this.diseaseInk,
    );
  }

  @override
  SearchPalette lerp(ThemeExtension<SearchPalette>? other, double t) {
    if (other is! SearchPalette) {
      return this;
    }
    return SearchPalette(
      brightness: t < 0.5 ? brightness : other.brightness,
      background: Color.lerp(background, other.background, t)!,
      surfaceSubtle: Color.lerp(surfaceSubtle, other.surfaceSubtle, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      primaryRing: Color.lerp(primaryRing, other.primaryRing, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      drugTint: Color.lerp(drugTint, other.drugTint, t)!,
      drugInk: Color.lerp(drugInk, other.drugInk, t)!,
      diseaseTint: Color.lerp(diseaseTint, other.diseaseTint, t)!,
      diseaseInk: Color.lerp(diseaseInk, other.diseaseInk, t)!,
    );
  }
}
