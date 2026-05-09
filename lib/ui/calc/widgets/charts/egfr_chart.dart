import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/calc_chart_primitives.dart';
import 'package:flutter/material.dart';

/// eGFR CKD-stage band chart.
class EgfrChart extends StatelessWidget {
  /// Creates an eGFR chart.
  const EgfrChart({required this.value, required this.label, super.key});

  /// eGFR value.
  final double value;

  /// Marker label.
  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final stagePalette = palette.calcCkdStagePalette;

    return CalcBandChart(
      chartKeyPrefix: 'egfr',
      markerPosition: (value / 120).clamp(0, 1),
      markerLabel: label,
      ticks: const [
        CalcAxisTick(label: '0', position: 0),
        CalcAxisTick(label: '15', position: 0.125),
        CalcAxisTick(label: '30', position: 0.25),
        CalcAxisTick(label: '45', position: 0.375),
        CalcAxisTick(label: '60', position: 0.5),
        CalcAxisTick(label: '90', position: 0.75),
        CalcAxisTick(label: '120', position: 1),
      ],
      segments: [
        CalcBandSegment(
          key: 'g5',
          label: '<15',
          flex: 1,
          background: stagePalette[CalcCkdStageToken.g5]!.bg,
          foreground: stagePalette[CalcCkdStageToken.g5]!.fg,
        ),
        CalcBandSegment(
          key: 'g4',
          label: '15',
          flex: 1,
          background: stagePalette[CalcCkdStageToken.g4]!.bg,
          foreground: stagePalette[CalcCkdStageToken.g4]!.fg,
        ),
        CalcBandSegment(
          key: 'g3b',
          label: '30',
          flex: 1,
          background: stagePalette[CalcCkdStageToken.g3b]!.bg,
          foreground: stagePalette[CalcCkdStageToken.g3b]!.fg,
        ),
        CalcBandSegment(
          key: 'g3a',
          label: '45',
          flex: 1,
          background: stagePalette[CalcCkdStageToken.g3a]!.bg,
          foreground: stagePalette[CalcCkdStageToken.g3a]!.fg,
        ),
        CalcBandSegment(
          key: 'g2',
          label: '60',
          flex: 2,
          background: stagePalette[CalcCkdStageToken.g2]!.bg,
          foreground: stagePalette[CalcCkdStageToken.g2]!.fg,
        ),
        CalcBandSegment(
          key: 'g1',
          label: '>=90',
          flex: 2,
          background: stagePalette[CalcCkdStageToken.g1]!.bg,
          foreground: stagePalette[CalcCkdStageToken.g1]!.fg,
        ),
      ],
    );
  }
}
