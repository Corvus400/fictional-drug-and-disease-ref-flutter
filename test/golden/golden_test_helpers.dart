import 'dart:async';
import 'dart:io' show Platform;

import 'package:alchemist/alchemist.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

import 'golden_test_config.dart';

/// Builds a complete golden scene for one matrix cell.
typedef GoldenSceneBuilder =
    Widget Function(ThemeData theme, Size size, TextScaler textScaler);

/// Alchemist interaction callback used before the golden assertion.
typedef GoldenInteraction = Interaction;

/// Returns whether platform golden tests should be registered on this host.
@visibleForTesting
bool shouldRegisterGoldenTestsForHost(String operatingSystem) {
  return operatingSystem == 'macos';
}

/// Expands the common golden matrix into theme-separated PNGs.
///
/// Issue #32 requires each device/orientation and theme to be emitted as a
/// separate file: `<fileNamePrefix>_<device>_<theme>.png`.
@isTest
void runGoldenMatrix({
  required String fileNamePrefix,
  required GoldenSceneBuilder builder,
  String? description,
  Iterable<String>? themes,
  Iterable<String>? devices,
  Map<String, Size>? customDevices,
  GoldenInteraction? whilePerforming,
}) {
  final deviceMap = {...GoldenMatrix.devices, ...?customDevices};
  final selectedThemes = (themes ?? GoldenMatrix.themes.keys).toList();
  final selectedDevices = (devices ?? GoldenMatrix.devices.keys).toList();

  for (final deviceName in selectedDevices) {
    final size = deviceMap[deviceName]!;
    for (final themeName in selectedThemes) {
      final testDescription = description != null
          ? '$description / $deviceName / $themeName'
          : '$fileNamePrefix / $deviceName / $themeName';
      if (!shouldRegisterGoldenTestsForHost(Platform.operatingSystem)) {
        _registerSkippedGoldenTest(testDescription);
        continue;
      }

      final brightness = GoldenMatrix.themes[themeName]!;
      final themeData = brightness == Brightness.light
          ? AppTheme.light()
          : AppTheme.dark();

      unawaited(
        goldenTest(
          testDescription,
          fileName: '${fileNamePrefix}_${deviceName}_$themeName',
          // ignore: avoid_redundant_argument_values, keep the golden tag explicit.
          tags: const ['golden'],
          builder: () => GoldenTestGroup(
            children: [
              GoldenTestScenario(
                name: deviceName,
                constraints: BoxConstraints.tightFor(
                  width: size.width,
                  height: size.height,
                ),
                child: MediaQuery(
                  data: MediaQueryData(
                    size: size,
                    devicePixelRatio: GoldenMatrix.devicePixelRatio,
                    textScaler: GoldenMatrix.textScaler,
                  ),
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: builder(themeData, size, GoldenMatrix.textScaler),
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
}

void _registerSkippedGoldenTest(String description) {
  testWidgets(
    description,
    (_) async {},
    tags: const ['golden'],
    skip: true,
  );
}
