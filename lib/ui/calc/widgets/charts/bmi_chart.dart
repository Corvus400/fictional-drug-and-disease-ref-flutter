import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/calc_chart_primitives.dart';
import 'package:flutter/material.dart';

/// BMI number-line chart.
class BmiChart extends StatelessWidget {
  /// Creates a BMI chart.
  const BmiChart({required this.value, required this.label, super.key});

  /// BMI value.
  final double value;

  /// Marker label.
  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final categoryPalette = palette.calcBmiCategoryPalette;

    return CalcBandChart(
      chartKeyPrefix: 'bmi',
      markerPosition: ((value - 10) / 40).clamp(0, 1),
      markerLabel: label,
      ticks: const [
        CalcAxisTick(label: '10', position: 0),
        CalcAxisTick(label: '30', position: 0.5),
        CalcAxisTick(label: '50', position: 1),
      ],
      segments: [
        CalcBandSegment(
          key: '1',
          label: '<18.5',
          flex: 1,
          background: categoryPalette[CalcBmiCategoryToken.underweight]!.bg,
          foreground: categoryPalette[CalcBmiCategoryToken.underweight]!.fg,
        ),
        CalcBandSegment(
          key: '2',
          label: '18.5',
          flex: 1,
          background: categoryPalette[CalcBmiCategoryToken.normal]!.bg,
          foreground: categoryPalette[CalcBmiCategoryToken.normal]!.fg,
        ),
        CalcBandSegment(
          key: '3',
          label: '25',
          flex: 1,
          background: categoryPalette[CalcBmiCategoryToken.overweight]!.bg,
          foreground: categoryPalette[CalcBmiCategoryToken.overweight]!.fg,
        ),
        CalcBandSegment(
          key: '4',
          label: '30',
          flex: 1,
          background: categoryPalette[CalcBmiCategoryToken.obese1]!.bg,
          foreground: categoryPalette[CalcBmiCategoryToken.obese1]!.fg,
        ),
        CalcBandSegment(
          key: '5',
          label: '35',
          flex: 1,
          background: categoryPalette[CalcBmiCategoryToken.obese2]!.bg,
          foreground: categoryPalette[CalcBmiCategoryToken.obese2]!.fg,
        ),
        CalcBandSegment(
          key: '6',
          label: '40',
          flex: 1,
          background: categoryPalette[CalcBmiCategoryToken.obese3]!.bg,
          foreground: categoryPalette[CalcBmiCategoryToken.obese3]!.fg,
        ),
        CalcBandSegment(
          key: '7',
          label: '>=45',
          flex: 1,
          background: categoryPalette[CalcBmiCategoryToken.obese4]!.bg,
          foreground: categoryPalette[CalcBmiCategoryToken.obese4]!.fg,
        ),
      ],
    );
  }
}
