import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme NavigationBarThemeData', () {
    test('uses design NavigationBar tokens in light theme', () {
      _expectNavigationBarTokens(AppTheme.light(), AppPalette.light);
    });

    test('uses design NavigationBar tokens in dark theme', () {
      _expectNavigationBarTokens(AppTheme.dark(), AppPalette.dark);
    });
  });
}

void _expectNavigationBarTokens(ThemeData theme, AppPalette palette) {
  final navigationTheme = theme.navigationBarTheme;

  expect(navigationTheme.height, 64);
  expect(navigationTheme.backgroundColor, palette.surface);
  expect(navigationTheme.indicatorColor, palette.primarySoft);
  expect(
    navigationTheme.labelBehavior,
    NavigationDestinationLabelBehavior.alwaysShow,
  );

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

  expect(selectedIcon.color, palette.primary);
  expect(unselectedIcon.color, palette.muted);
  expect(selectedIcon.size, 24);
  expect(unselectedIcon.size, 24);
  expect(selectedLabel.color, palette.primary);
  expect(unselectedLabel.color, palette.muted);
  expect(selectedLabel.fontSize, 10);
  expect(unselectedLabel.fontSize, 10);
  expect(selectedLabel.fontWeight, FontWeight.w600);
  expect(unselectedLabel.fontWeight, FontWeight.w600);
  expect(selectedLabel.height, 1.2);
  expect(unselectedLabel.height, 1.2);
}
