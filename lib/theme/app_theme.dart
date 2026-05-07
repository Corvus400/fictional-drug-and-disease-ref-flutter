import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:flutter/material.dart';

/// Application theme definitions.
class AppTheme {
  const AppTheme._();

  static const _seedColor = Color(0xFF007AFF);
  static const _cardRadius = 10.0;
  static const _navigationIndicatorAlpha = 0.12;

  /// Light theme.
  static ThemeData light() => _build(Brightness.light);

  /// Dark theme.
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardRadius),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primary.withValues(
          alpha: _navigationIndicatorAlpha,
        ),
      ),
      extensions: [
        if (brightness == Brightness.light)
          AppPalette.light
        else
          AppPalette.dark,
      ],
    );
  }
}
