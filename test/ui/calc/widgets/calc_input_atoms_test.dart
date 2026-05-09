import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_input_field.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';

void main() {
  group('Calc input atoms', () {
    testWidgets('CalcInputField renders default, placeholder, and error', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const Column(
            children: [
              CalcInputField(label: '身長', valueText: '170.0', unit: 'cm'),
              CalcInputField(label: '体重', unit: 'kg'),
              CalcInputField(
                label: '身長',
                valueText: '30.0',
                unit: 'cm',
                errorText: '範囲外: 50.0〜250.0 cm',
              ),
            ],
          ),
        ),
      );

      expect(find.text('170.0'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(CalcInputField).at(1),
          matching: find.text('--'),
        ),
        findsWidgets,
      );
      expect(find.text('範囲外: 50.0〜250.0 cm'), findsOneWidget);
      final editableText = tester.widget<EditableText>(
        find.descendant(
          of: find.byType(CalcInputField).first,
          matching: find.byType(EditableText),
        ),
      );
      expect(
        editableText.keyboardType,
        const TextInputType.numberWithOptions(decimal: true),
      );
      final palette = Theme.of(
        tester.element(find.byType(CalcInputField).last),
      ).extension<AppPalette>()!;
      final errorInputDecorator = tester.widget<InputDecorator>(
        find
            .descendant(
              of: find.byType(CalcInputField).last,
              matching: find.byType(InputDecorator),
            )
            .first,
      );
      final border =
          errorInputDecorator.decoration.enabledBorder! as OutlineInputBorder;
      expect(border.borderSide.color, palette.calcError);
    });

    testWidgets('CalcSegmentedControl calls onChanged when enabled', (
      tester,
    ) async {
      var selected = 'bmi';
      await tester.pumpWidget(
        _widgetTestApp(
          child: StatefulBuilder(
            builder: (context, setState) => CalcSegmentedControl<String>.tool(
              selectedValue: selected,
              items: const [
                CalcSegmentedControlItem(value: 'bmi', label: 'BMI'),
                CalcSegmentedControlItem(value: 'egfr', label: 'eGFR'),
                CalcSegmentedControlItem(value: 'crcl', label: 'CrCl'),
              ],
              onChanged: (value) => setState(() => selected = value),
            ),
          ),
        ),
      );

      await tester.tap(find.text('eGFR'));
      await tester.pumpAndSettle();

      expect(selected, 'egfr');
    });

    testWidgets('tool segmented dimensions match the design spec', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: SizedBox(
            width: 358,
            child: CalcSegmentedControl<String>.tool(
              selectedValue: 'bmi',
              items: const [
                CalcSegmentedControlItem(value: 'bmi', label: 'BMI'),
                CalcSegmentedControlItem(value: 'egfr', label: 'eGFR'),
                CalcSegmentedControlItem(value: 'crcl', label: 'CrCl'),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(
        tester.getSize(find.byType(CalcSegmentedControl<String>)),
        const Size(358, 42),
      );
      expect(
        tester.getSize(find.byKey(const ValueKey<String>('calc-segment-bmi'))),
        const Size(116, 36),
      );
      final label = tester.widget<Text>(find.text('BMI'));
      expect(label.style?.fontWeight, FontWeight.w700);
      expect(label.style?.letterSpacing, 0.26);
    });

    testWidgets('sex segmented dimensions and icons match the design spec', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: SizedBox(
            width: 358,
            child: CalcSegmentedControl<String>.sex(
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
          ),
        ),
      );

      expect(
        tester.getSize(find.byType(CalcSegmentedControl<String>)),
        const Size(358, 36),
      );
      expect(
        tester.getSize(find.byKey(const ValueKey<String>('calc-segment-male'))),
        const Size(177, 32),
      );
      final icon = tester.widget<Icon>(find.byIcon(Symbols.male));
      expect(icon.size, 16);
      final label = tester.widget<Text>(find.text('男性'));
      expect(label.style?.fontWeight, FontWeight.w600);
      expect(label.style?.letterSpacing, isNull);
    });

    testWidgets('CalcSegmentedControl renders optional item icons', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: CalcSegmentedControl<String>.sex(
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
        ),
      );

      expect(find.byIcon(Symbols.male), findsOneWidget);
      expect(find.byIcon(Symbols.female), findsOneWidget);
    });
  });
}

Widget _widgetTestApp({required Widget child}) {
  return MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(body: child),
  );
}
