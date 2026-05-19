import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/bmi_chart.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/crcl_chart.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/egfr_chart.dart';
import 'package:flutter/material.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  _chartGolden(
    fileNamePrefix: 'calc_chart_bmi',
    description: 'BmiChart matches wide spec reference',
    logicalSize: const Size(396, 68),
    contentWidth: 324,
    horizontalPadding: 36,
    child: const BmiChart(value: 22.5, label: '22.5'),
  );
  _chartGolden(
    fileNamePrefix: 'calc_chart_bmi_edges',
    description: 'BmiChart edge labels stay inside the chart crop',
    logicalSize: const Size(396, 136),
    contentWidth: 324,
    horizontalPadding: 36,
    topPadding: 32,
    child: const Column(
      children: [
        BmiChart(value: 10, label: '10.0'),
        SizedBox(height: 16),
        BmiChart(value: 50, label: '50.0'),
      ],
    ),
  );
  _chartGolden(
    fileNamePrefix: 'calc_chart_egfr',
    description: 'EgfrChart matches wide spec reference',
    logicalSize: const Size(396, 68),
    contentWidth: 324,
    horizontalPadding: 36,
    child: const EgfrChart(value: 78.4, label: '78.4'),
  );
  _chartGolden(
    fileNamePrefix: 'calc_chart_egfr_edges',
    description: 'EgfrChart edge labels stay inside the chart crop',
    logicalSize: const Size(396, 136),
    contentWidth: 324,
    horizontalPadding: 36,
    topPadding: 32,
    child: const Column(
      children: [
        EgfrChart(value: 0, label: '0.0'),
        SizedBox(height: 16),
        EgfrChart(value: 140, label: '140.0'),
      ],
    ),
  );
  _chartGolden(
    fileNamePrefix: 'calc_chart_crcl',
    description: 'CrClChart matches wide spec reference',
    logicalSize: const Size(324, 75),
    child: const CrClChart(value: 92.1),
    topPadding: 0,
  );
  _chartGolden(
    fileNamePrefix: 'calc_chart_crcl_edges',
    description: 'CrClChart edge markers stay inside the track crop',
    logicalSize: const Size(356, 164),
    contentWidth: 324,
    horizontalPadding: 16,
    child: const Column(
      children: [
        CrClChart(value: 0),
        SizedBox(height: 16),
        CrClChart(value: 200),
      ],
    ),
    topPadding: 0,
  );
}

void _chartGolden({
  required String fileNamePrefix,
  required String description,
  required Size logicalSize,
  required Widget child,
  double? contentWidth,
  double horizontalPadding = 0,
  double topPadding = 24,
}) {
  runGoldenMatrix(
    fileNamePrefix: fileNamePrefix,
    description: description,
    builder: (theme, size, scaler) {
      return _scaledChartApp(
        theme: theme,
        logicalSize: logicalSize,
        viewportWidth: size.width,
        contentWidth: contentWidth,
        horizontalPadding: horizontalPadding,
        topPadding: topPadding,
        child: child,
      );
    },
  );
}

Widget _scaledChartApp({
  required ThemeData theme,
  required Size logicalSize,
  required double viewportWidth,
  required Widget child,
  double? contentWidth,
  double horizontalPadding = 0,
  double topPadding = 24,
}) {
  const scale = 4.0;
  final effectiveLogicalWidth = logicalSize.width > viewportWidth
      ? viewportWidth
      : logicalSize.width;
  final effectiveHorizontalPadding = switch (contentWidth) {
    null => 0.0,
    final width => ((effectiveLogicalWidth - width) / 2).clamp(
      0.0,
      horizontalPadding,
    ),
  };
  final physicalSize = Size(
    effectiveLogicalWidth * scale,
    logicalSize.height * scale,
  );

  return MaterialApp(
    theme: theme,
    home: Material(
      child: RepaintBoundary(
        key: const ValueKey<String>('chart-reference-boundary'),
        child: ColoredBox(
          color: Colors.white,
          child: SizedBox(
            width: physicalSize.width,
            height: physicalSize.height,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: UnconstrainedBox(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: effectiveLogicalWidth,
                  height: logicalSize.height,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: effectiveHorizontalPadding,
                      top: topPadding,
                      right: effectiveHorizontalPadding,
                    ),
                    child: SizedBox(width: contentWidth, child: child),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
