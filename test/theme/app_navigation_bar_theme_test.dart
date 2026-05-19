import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme NavigationBarThemeData', () {
    test('uses design NavigationBar tokens in light theme', () {
      expect(
        _navigationBarTokens(AppTheme.light()),
        _expectedNavigationBarTokens(AppPalette.light),
      );
    });

    test('uses design NavigationBar tokens in dark theme', () {
      expect(
        _navigationBarTokens(AppTheme.dark()),
        _expectedNavigationBarTokens(AppPalette.dark),
      );
    });
  });
}

Map<String, Object?> _navigationBarTokens(ThemeData theme) {
  final navigationTheme = theme.navigationBarTheme;
  final selectedStates = <WidgetState>{WidgetState.selected};
  final unselectedStates = <WidgetState>{};
  final selectedIcon = navigationTheme.iconTheme!.resolve(selectedStates)!;
  final unselectedIcon = navigationTheme.iconTheme!.resolve(unselectedStates)!;
  final selectedLabel = navigationTheme.labelTextStyle!.resolve(
    selectedStates,
  )!;
  final unselectedLabel = navigationTheme.labelTextStyle!.resolve(
    unselectedStates,
  )!;

  return {
    'height': navigationTheme.height,
    'backgroundColor': navigationTheme.backgroundColor,
    'indicatorColor': navigationTheme.indicatorColor,
    'labelBehavior': navigationTheme.labelBehavior,
    'selectedIconColor': selectedIcon.color,
    'unselectedIconColor': unselectedIcon.color,
    'selectedIconSize': selectedIcon.size,
    'unselectedIconSize': unselectedIcon.size,
    'selectedLabelColor': selectedLabel.color,
    'unselectedLabelColor': unselectedLabel.color,
    'selectedLabelFontSize': selectedLabel.fontSize,
    'unselectedLabelFontSize': unselectedLabel.fontSize,
    'selectedLabelFontWeight': selectedLabel.fontWeight,
    'unselectedLabelFontWeight': unselectedLabel.fontWeight,
    'selectedLabelHeight': selectedLabel.height,
    'unselectedLabelHeight': unselectedLabel.height,
  };
}

Map<String, Object?> _expectedNavigationBarTokens(AppPalette palette) {
  return {
    'height': 64,
    'backgroundColor': palette.surface,
    'indicatorColor': palette.primarySoft,
    'labelBehavior': NavigationDestinationLabelBehavior.alwaysShow,
    'selectedIconColor': palette.primary,
    'unselectedIconColor': palette.muted,
    'selectedIconSize': 24,
    'unselectedIconSize': 24,
    'selectedLabelColor': palette.primary,
    'unselectedLabelColor': palette.muted,
    'selectedLabelFontSize': 10,
    'unselectedLabelFontSize': 10,
    'selectedLabelFontWeight': FontWeight.w600,
    'unselectedLabelFontWeight': FontWeight.w600,
    'selectedLabelHeight': 1.2,
    'unselectedLabelHeight': 1.2,
  };
}
