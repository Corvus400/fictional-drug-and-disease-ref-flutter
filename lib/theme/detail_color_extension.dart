import 'package:flutter/material.dart';

/// Detail screen color tokens from Detail Spec.html.
final class DetailColorExtension extends ThemeExtension<DetailColorExtension> {
  /// Creates a detail color token set.
  const DetailColorExtension({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.warnContainer,
    required this.onWarnContainer,
    required this.surface,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.surfaceTint,
    required this.outline,
    required this.outlineVariant,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.shadow,
    required this.frameGradientStart,
    required this.frameGradientEnd,
  });

  /// Detail Spec light frame tokens.
  static const light = DetailColorExtension(
    primary: Color(0xFF1F5BB5),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF525E78),
    onSecondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFF705574),
    onTertiary: Color(0xFFFFFFFF),
    error: Color(0xFFB3261E),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFF9DEDC),
    onErrorContainer: Color(0xFF410E0B),
    warnContainer: Color(0xFFFFE0E0),
    onWarnContainer: Color(0xFF5B0A0A),
    surface: Color(0xFFFBFBFE),
    onSurface: Color(0xFF1A1B20),
    onSurfaceVariant: Color(0xFF44464E),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF4F4F8),
    surfaceContainer: Color(0xFFEDEEF3),
    surfaceContainerHigh: Color(0xFFE7E8EE),
    surfaceContainerHighest: Color(0xFFE1E2E8),
    surfaceTint: Color(0xFF1F5BB5),
    outline: Color(0xFF75777F),
    outlineVariant: Color(0xFFC5C6CD),
    primaryContainer: Color(0xFFD8E2FF),
    onPrimaryContainer: Color(0xFF001A41),
    tertiaryContainer: Color(0xFFFBD8FF),
    onTertiaryContainer: Color(0xFF280A2D),
    shadow: Color(0x14171A2A),
    frameGradientStart: Color(0xFF0F172A),
    frameGradientEnd: Color(0xFF0B1220),
  );

  /// Detail Spec dark frame tokens.
  static const dark = DetailColorExtension(
    primary: Color(0xFFAEC6FF),
    onPrimary: Color(0xFF002E69),
    secondary: Color(0xFFBBC6E4),
    onSecondary: Color(0xFF253048),
    tertiary: Color(0xFFDEBCDF),
    onTertiary: Color(0xFF3F2843),
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFF9DEDC),
    warnContainer: Color(0xFF5B0A0A),
    onWarnContainer: Color(0xFFFFE0E0),
    surface: Color(0xFF121318),
    onSurface: Color(0xFFE3E2E9),
    onSurfaceVariant: Color(0xFFC5C6CD),
    surfaceContainerLowest: Color(0xFF0D0E13),
    surfaceContainerLow: Color(0xFF1A1B20),
    surfaceContainer: Color(0xFF1E1F25),
    surfaceContainerHigh: Color(0xFF292A30),
    surfaceContainerHighest: Color(0xFF33343A),
    surfaceTint: Color(0xFFAEC6FF),
    outline: Color(0xFF8E9099),
    outlineVariant: Color(0xFF44464E),
    primaryContainer: Color(0xFF003494),
    onPrimaryContainer: Color(0xFFD8E2FF),
    tertiaryContainer: Color(0xFF573C5B),
    onTertiaryContainer: Color(0xFFFBD8FF),
    shadow: Color(0x80000000),
    frameGradientStart: Color(0xFF1E293B),
    frameGradientEnd: Color(0xFF0F172A),
  );

  /// Primary action color.
  final Color primary;

  /// Text/icon color on primary.
  final Color onPrimary;

  /// Secondary action color.
  final Color secondary;

  /// Text/icon color on secondary.
  final Color onSecondary;

  /// Tertiary accent color.
  final Color tertiary;

  /// Text/icon color on tertiary.
  final Color onTertiary;

  /// Error color.
  final Color error;

  /// Text/icon color on error.
  final Color onError;

  /// Error container fill.
  final Color errorContainer;

  /// Text/icon color on error container.
  final Color onErrorContainer;

  /// Warning container fill.
  final Color warnContainer;

  /// Text/icon color on warning container.
  final Color onWarnContainer;

  /// Base detail surface.
  final Color surface;

  /// Primary surface text.
  final Color onSurface;

  /// Secondary surface text.
  final Color onSurfaceVariant;

  /// Lowest container surface.
  final Color surfaceContainerLowest;

  /// Low container surface.
  final Color surfaceContainerLow;

  /// Default container surface.
  final Color surfaceContainer;

  /// High container surface.
  final Color surfaceContainerHigh;

  /// Highest container surface.
  final Color surfaceContainerHighest;

  /// Surface tint color.
  final Color surfaceTint;

  /// Strong outline color.
  final Color outline;

  /// Subtle outline color.
  final Color outlineVariant;

  /// Primary container fill.
  final Color primaryContainer;

  /// Text/icon color on primary container.
  final Color onPrimaryContainer;

  /// Tertiary container fill.
  final Color tertiaryContainer;

  /// Text/icon color on tertiary container.
  final Color onTertiaryContainer;

  /// Detail card shadow color.
  final Color shadow;

  /// Detail frame gradient start.
  final Color frameGradientStart;

  /// Detail frame gradient end.
  final Color frameGradientEnd;

  @override
  DetailColorExtension copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? tertiary,
    Color? onTertiary,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? warnContainer,
    Color? onWarnContainer,
    Color? surface,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? surfaceTint,
    Color? outline,
    Color? outlineVariant,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? shadow,
    Color? frameGradientStart,
    Color? frameGradientEnd,
  }) {
    return DetailColorExtension(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      warnContainer: warnContainer ?? this.warnContainer,
      onWarnContainer: onWarnContainer ?? this.onWarnContainer,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      surfaceContainerLowest:
          surfaceContainerLowest ?? this.surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest:
          surfaceContainerHighest ?? this.surfaceContainerHighest,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      shadow: shadow ?? this.shadow,
      frameGradientStart: frameGradientStart ?? this.frameGradientStart,
      frameGradientEnd: frameGradientEnd ?? this.frameGradientEnd,
    );
  }

  @override
  DetailColorExtension lerp(
    ThemeExtension<DetailColorExtension>? other,
    double t,
  ) {
    if (other is! DetailColorExtension) {
      return this;
    }
    return DetailColorExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      onErrorContainer: Color.lerp(
        onErrorContainer,
        other.onErrorContainer,
        t,
      )!,
      warnContainer: Color.lerp(warnContainer, other.warnContainer, t)!,
      onWarnContainer: Color.lerp(onWarnContainer, other.onWarnContainer, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceVariant: Color.lerp(
        onSurfaceVariant,
        other.onSurfaceVariant,
        t,
      )!,
      surfaceContainerLowest: Color.lerp(
        surfaceContainerLowest,
        other.surfaceContainerLowest,
        t,
      )!,
      surfaceContainerLow: Color.lerp(
        surfaceContainerLow,
        other.surfaceContainerLow,
        t,
      )!,
      surfaceContainer: Color.lerp(
        surfaceContainer,
        other.surfaceContainer,
        t,
      )!,
      surfaceContainerHigh: Color.lerp(
        surfaceContainerHigh,
        other.surfaceContainerHigh,
        t,
      )!,
      surfaceContainerHighest: Color.lerp(
        surfaceContainerHighest,
        other.surfaceContainerHighest,
        t,
      )!,
      surfaceTint: Color.lerp(surfaceTint, other.surfaceTint, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      primaryContainer: Color.lerp(
        primaryContainer,
        other.primaryContainer,
        t,
      )!,
      onPrimaryContainer: Color.lerp(
        onPrimaryContainer,
        other.onPrimaryContainer,
        t,
      )!,
      tertiaryContainer: Color.lerp(
        tertiaryContainer,
        other.tertiaryContainer,
        t,
      )!,
      onTertiaryContainer: Color.lerp(
        onTertiaryContainer,
        other.onTertiaryContainer,
        t,
      )!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      frameGradientStart: Color.lerp(
        frameGradientStart,
        other.frameGradientStart,
        t,
      )!,
      frameGradientEnd: Color.lerp(
        frameGradientEnd,
        other.frameGradientEnd,
        t,
      )!,
    );
  }
}
