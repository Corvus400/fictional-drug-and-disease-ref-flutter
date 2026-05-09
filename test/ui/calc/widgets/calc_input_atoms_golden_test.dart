import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_input_field.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_input_atoms',
    description: 'Calc input atoms',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: (theme, size, scaler) => MaterialApp(
      theme: theme,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CalcInputField(
                  label: '身長',
                  valueText: '170.0',
                  unit: 'cm',
                ),
                const SizedBox(height: 12),
                const CalcInputField(
                  label: '身長',
                  valueText: '170.0',
                  unit: 'cm',
                  focused: true,
                ),
                const SizedBox(height: 12),
                const CalcInputField(
                  label: '体重',
                  unit: 'kg',
                ),
                const SizedBox(height: 12),
                const CalcInputField(
                  label: '身長',
                  valueText: '30.0',
                  unit: 'cm',
                  errorText: '範囲外: 50.0〜250.0 cm',
                ),
                const SizedBox(height: 16),
                CalcSegmentedControl<String>.tool(
                  selectedValue: 'bmi',
                  items: const [
                    CalcSegmentedControlItem(value: 'bmi', label: 'BMI'),
                    CalcSegmentedControlItem(value: 'egfr', label: 'eGFR'),
                    CalcSegmentedControlItem(value: 'crcl', label: 'CrCl'),
                  ],
                  onChanged: (_) {},
                ),
                const SizedBox(height: 16),
                const _SexSegmentedField(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _SexSegmentedField extends StatelessWidget {
  const _SexSegmentedField();

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '性別',
          style: typography.labelS.copyWith(color: palette.calcMuted),
        ),
        const SizedBox(height: 4),
        CalcSegmentedControl<String>.sex(
          selectedValue: 'male',
          items: const [
            CalcSegmentedControlItem(
              value: 'male',
              label: '男性',
              icon: Symbols.male,
            ),
            CalcSegmentedControlItem(
              value: 'female',
              label: '女性',
              icon: Symbols.female,
            ),
          ],
          onChanged: (_) {},
        ),
      ],
    );
  }
}
