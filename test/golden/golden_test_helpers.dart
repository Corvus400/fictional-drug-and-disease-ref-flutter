import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'golden_test_config.dart';

/// Builds a complete golden scene for one matrix cell.
typedef GoldenSceneBuilder =
    Widget Function(ThemeData theme, Size size, TextScaler textScaler);

/// Alchemist interaction callback used before the golden assertion.
typedef GoldenInteraction = Interaction;

/// Expands the common golden matrix into theme-separated PNGs.
///
/// The theme axis is emitted as separate files:
/// `<fileNamePrefix>_<theme>.png`.
///
/// The size and text scale axes are rendered as multiple scenarios inside the
/// same PNG: phone_normal, phone_large, tablet_normal, tablet_large.
@isTest
void runGoldenMatrix({
  required String fileNamePrefix,
  required GoldenSceneBuilder builder,
  String? description,
  Iterable<String>? themes,
  Iterable<String>? sizes,
  Iterable<String>? textScalers,
  Map<String, Size>? customSizes,
  Map<String, TextScaler>? customTextScalers,
  GoldenInteraction? whilePerforming,
}) {
  final sizeMap = {...GoldenMatrix.sizes, ...?customSizes};
  final textScalerMap = {
    ...GoldenMatrix.textScalers,
    ...?customTextScalers,
  };
  final selectedThemes = (themes ?? GoldenMatrix.themes.keys).toList();
  final selectedSizes = (sizes ?? GoldenMatrix.sizes.keys).toList();
  final selectedScalers = (textScalers ?? GoldenMatrix.textScalers.keys)
      .toList();

  for (final themeName in selectedThemes) {
    final brightness = GoldenMatrix.themes[themeName]!;
    final themeData = brightness == Brightness.light
        ? AppTheme.light()
        : AppTheme.dark();

    unawaited(
      goldenTest(
        description != null
            ? '$description / $themeName'
            : '$fileNamePrefix / $themeName',
        fileName: '${fileNamePrefix}_$themeName',
        // ignore: avoid_redundant_argument_values, keep the golden tag explicit.
        tags: const ['golden'],
        builder: () => GoldenTestGroup(
          children: [
            for (final sizeName in selectedSizes)
              for (final scalerName in selectedScalers)
                GoldenTestScenario(
                  name: '${sizeName}_$scalerName',
                  constraints: BoxConstraints.tightFor(
                    width: sizeMap[sizeName]!.width,
                    height: sizeMap[sizeName]!.height,
                  ),
                  child: MediaQuery(
                    data: MediaQueryData(
                      size: sizeMap[sizeName]!,
                      devicePixelRatio: GoldenMatrix.devicePixelRatio,
                      textScaler: textScalerMap[scalerName]!,
                    ),
                    child: SizedBox(
                      width: sizeMap[sizeName]!.width,
                      height: sizeMap[sizeName]!.height,
                      child: builder(
                        themeData,
                        sizeMap[sizeName]!,
                        textScalerMap[scalerName]!,
                      ),
                    ),
                  ),
                ),
          ],
        ),
        whilePerforming: whilePerforming,
      ),
    );
  }
}
