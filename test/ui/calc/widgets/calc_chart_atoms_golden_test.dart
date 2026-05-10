import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/bmi_chart.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/crcl_chart.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/egfr_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BmiChart matches wide spec reference', (tester) async {
    await _pumpScaledChart(
      tester,
      logicalSize: const Size(396, 68),
      contentWidth: 324,
      horizontalPadding: 36,
      child: const BmiChart(value: 22.5, label: '22.5'),
    );

    await expectLater(
      find.byKey(const ValueKey<String>('chart-reference-boundary')),
      matchesGoldenFile('goldens/macos/calc_chart_bmi_light.png'),
    );
  }, tags: const ['golden']);

  testWidgets('BmiChart edge labels stay inside the chart crop', (
    tester,
  ) async {
    await _pumpScaledChart(
      tester,
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

    await expectLater(
      find.byKey(const ValueKey<String>('chart-reference-boundary')),
      matchesGoldenFile('goldens/macos/calc_chart_bmi_edges_light.png'),
    );
  }, tags: const ['golden']);

  testWidgets('EgfrChart matches wide spec reference', (tester) async {
    await _pumpScaledChart(
      tester,
      logicalSize: const Size(396, 68),
      contentWidth: 324,
      horizontalPadding: 36,
      child: const EgfrChart(value: 78.4, label: '78.4'),
    );

    await expectLater(
      find.byKey(const ValueKey<String>('chart-reference-boundary')),
      matchesGoldenFile('goldens/macos/calc_chart_egfr_light.png'),
    );
  }, tags: const ['golden']);

  testWidgets('EgfrChart edge labels stay inside the chart crop', (
    tester,
  ) async {
    await _pumpScaledChart(
      tester,
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

    await expectLater(
      find.byKey(const ValueKey<String>('chart-reference-boundary')),
      matchesGoldenFile('goldens/macos/calc_chart_egfr_edges_light.png'),
    );
  }, tags: const ['golden']);

  testWidgets('CrClChart matches wide spec reference', (tester) async {
    await _pumpScaledChart(
      tester,
      logicalSize: const Size(324, 75),
      child: const CrClChart(value: 92.1),
      topPadding: 0,
    );

    await expectLater(
      find.byKey(const ValueKey<String>('chart-reference-boundary')),
      matchesGoldenFile('goldens/macos/calc_chart_crcl_light.png'),
    );
  }, tags: const ['golden']);

  testWidgets('CrClChart edge markers stay inside the track crop', (
    tester,
  ) async {
    await _pumpScaledChart(
      tester,
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

    await expectLater(
      find.byKey(const ValueKey<String>('chart-reference-boundary')),
      matchesGoldenFile('goldens/macos/calc_chart_crcl_edges_light.png'),
    );
  }, tags: const ['golden']);
}

Future<void> _pumpScaledChart(
  WidgetTester tester, {
  required Size logicalSize,
  required Widget child,
  double? contentWidth,
  double horizontalPadding = 0,
  double topPadding = 24,
}) async {
  const scale = 4.0;
  final physicalSize = Size(
    logicalSize.width * scale,
    logicalSize.height * scale,
  );

  await tester.binding.setSurfaceSize(physicalSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
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
                    width: logicalSize.width,
                    height: logicalSize.height,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: contentWidth == null ? 0 : horizontalPadding,
                        top: topPadding,
                        right: contentWidth == null ? 0 : horizontalPadding,
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
    ),
  );
}
