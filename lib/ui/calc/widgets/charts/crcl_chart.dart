import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/calc_chart_primitives.dart';
import 'package:flutter/material.dart';

/// CrCl age-stratified normal-range chart.
class CrClChart extends StatelessWidget {
  /// Creates a CrCl chart.
  const CrClChart({required this.value, super.key});

  /// CrCl value.
  final double value;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 74,
      child: Column(
        spacing: 6,
        children: [
          CalcCrClRow(
            groupKey: 'male-18-39',
            label: '男性 18-39',
            normalLeft: 0.60,
            normalRight: 0.05,
            markerLeft: 0.55,
          ),
          CalcCrClRow(
            groupKey: 'male-40-59',
            label: '男性 40-59',
            normalLeft: 0.50,
            normalRight: 0.10,
            markerLeft: 0.55,
          ),
          CalcCrClRow(
            groupKey: 'male-60',
            label: '男性 60+',
            normalLeft: 0.35,
            normalRight: 0.25,
            markerLeft: 0.55,
          ),
          CalcCrClRow(
            groupKey: 'female-60',
            label: '女性 60+',
            normalLeft: 0.30,
            normalRight: 0.35,
            markerLeft: 0.55,
          ),
        ],
      ),
    );
  }
}
