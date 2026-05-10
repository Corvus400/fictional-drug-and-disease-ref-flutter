import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/bmi_chart.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/crcl_chart.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/egfr_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calc chart atoms', () {
    testWidgets('BmiChart renders seven bands, ticks, and marker', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const SizedBox(
            width: 280,
            child: BmiChart(value: 22.5, label: '22.5'),
          ),
        ),
      );

      for (var index = 1; index <= 7; index += 1) {
        expect(
          find.byKey(ValueKey<String>('bmi-chart-segment-$index')),
          findsOneWidget,
        );
      }
      expect(find.text('10'), findsOneWidget);
      expect(find.text('30'), findsWidgets);
      expect(find.text('50'), findsOneWidget);
      expect(
        tester.getSize(find.byKey(const ValueKey<String>('bmi-chart-marker'))),
        const Size(2, 32),
      );
      expect(find.text('22.5'), findsOneWidget);
    });

    testWidgets('BmiChart clamps edge marker labels inside the chart bounds', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const KeyedSubtree(
            key: ValueKey<String>('bmi-edge-chart-boundary'),
            child: SizedBox(
              width: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BmiChart(value: 10, label: '10.0'),
                  SizedBox(height: 16),
                  BmiChart(value: 50, label: '50.0'),
                ],
              ),
            ),
          ),
        ),
      );

      final chartRect = tester.getRect(
        find.byKey(const ValueKey<String>('bmi-edge-chart-boundary')),
      );
      final leftLabelRect = tester.getRect(
        find.byKey(const ValueKey<String>('bmi-chart-marker-label-10.0')),
      );
      final rightLabelRect = tester.getRect(
        find.byKey(const ValueKey<String>('bmi-chart-marker-label-50.0')),
      );

      expect(leftLabelRect.left, greaterThanOrEqualTo(chartRect.left));
      expect(rightLabelRect.right, lessThanOrEqualTo(chartRect.right));
      expect(tester.getSize(find.text('10.0')).height, lessThanOrEqualTo(13));
      expect(tester.getSize(find.text('50.0')).height, lessThanOrEqualTo(13));
    });

    testWidgets('EgfrChart renders CKD stage bands and marker', (tester) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const SizedBox(
            width: 280,
            child: EgfrChart(value: 78.4, label: '78.4'),
          ),
        ),
      );

      for (final stage in ['g5', 'g4', 'g3b', 'g3a', 'g2', 'g1']) {
        expect(
          find.byKey(ValueKey<String>('egfr-chart-segment-$stage')),
          findsOneWidget,
        );
      }
      expect(find.text('0'), findsOneWidget);
      expect(find.text('120'), findsOneWidget);
      expect(
        tester.getSize(find.byKey(const ValueKey<String>('egfr-chart-marker'))),
        const Size(2, 32),
      );
      expect(find.text('78.4'), findsOneWidget);
    });

    testWidgets('EgfrChart clamps edge marker labels inside the chart bounds', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const KeyedSubtree(
            key: ValueKey<String>('egfr-edge-chart-boundary'),
            child: SizedBox(
              width: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EgfrChart(value: 0, label: '0.0'),
                  SizedBox(height: 16),
                  EgfrChart(value: 140, label: '140.0'),
                ],
              ),
            ),
          ),
        ),
      );

      final chartRect = tester.getRect(
        find.byKey(const ValueKey<String>('egfr-edge-chart-boundary')),
      );
      final leftLabelRect = tester.getRect(
        find.byKey(const ValueKey<String>('egfr-chart-marker-label-0.0')),
      );
      final rightLabelRect = tester.getRect(
        find.byKey(const ValueKey<String>('egfr-chart-marker-label-140.0')),
      );

      expect(leftLabelRect.left, greaterThanOrEqualTo(chartRect.left));
      expect(rightLabelRect.right, lessThanOrEqualTo(chartRect.right));
      expect(tester.getSize(find.text('0.0')).height, lessThanOrEqualTo(13));
      expect(tester.getSize(find.text('140.0')).height, lessThanOrEqualTo(13));
    });

    testWidgets('CrClChart renders age bands and patient markers', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const SizedBox(width: 280, child: CrClChart(value: 92.1)),
        ),
      );

      for (final group in [
        'male-18-39',
        'male-40-59',
        'male-60',
        'female-60',
      ]) {
        expect(
          find.byKey(ValueKey<String>('crcl-chart-row-$group')),
          findsOneWidget,
        );
        expect(
          find.byKey(ValueKey<String>('crcl-chart-normal-$group')),
          findsOneWidget,
        );
        expect(
          find.byKey(ValueKey<String>('crcl-chart-marker-$group')),
          findsOneWidget,
        );
      }
    });

    testWidgets(
      'CrClChart clamps low and high patient markers to track edges',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: const SizedBox(width: 280, child: CrClChart(value: 0)),
          ),
        );

        final lowTrackRect = tester.getRect(
          find.byKey(const ValueKey<String>('crcl-chart-track-male-18-39')),
        );
        final lowMarkerRect = tester.getRect(
          find.byKey(const ValueKey<String>('crcl-chart-marker-male-18-39')),
        );

        expect(lowMarkerRect.left, closeTo(lowTrackRect.left, 1));

        await tester.pumpWidget(
          _widgetTestApp(
            child: const SizedBox(width: 280, child: CrClChart(value: 200)),
          ),
        );

        final highTrackRect = tester.getRect(
          find.byKey(const ValueKey<String>('crcl-chart-track-male-18-39')),
        );
        final highMarkerRect = tester.getRect(
          find.byKey(const ValueKey<String>('crcl-chart-marker-male-18-39')),
        );

        expect(highMarkerRect.right, closeTo(highTrackRect.right, 1));
      },
    );
  });
}

Widget _widgetTestApp({required Widget child}) {
  return MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(
      body: Align(alignment: Alignment.topLeft, child: child),
    ),
  );
}
