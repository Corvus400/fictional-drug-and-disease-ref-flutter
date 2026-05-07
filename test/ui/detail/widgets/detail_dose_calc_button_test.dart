import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_dose_calc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailDoseCalcButton matches calc button sizing and colors', (
    tester,
  ) async {
    var tapCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: DetailDoseCalcButton(
            label: '用量計算',
            onPressed: () => tapCount += 1,
          ),
        ),
      ),
    );

    final colors = AppTheme.light().extension<DetailColorExtension>()!;
    final button = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-dose-calc-button')),
    );
    final decoration = button.decoration! as BoxDecoration;
    final icon = tester.widget<Icon>(find.byIcon(Icons.calculate_outlined));
    final text = tester.widget<Text>(find.text('用量計算'));

    expect(button.constraints?.minHeight, 44);
    expect(button.constraints?.maxHeight, 44);
    expect(button.padding, const EdgeInsets.symmetric(horizontal: 16));
    expect(decoration.color, colors.primary);
    expect(decoration.borderRadius, BorderRadius.circular(22));
    expect(icon.size, 18);
    expect(icon.color, colors.onPrimary);
    expect(text.style?.fontSize, 14);
    expect(text.style?.fontWeight, FontWeight.w600);
    expect(text.style?.color, colors.onPrimary);

    await tester.tap(
      find.byKey(const ValueKey<String>('detail-dose-calc-button')),
    );
    expect(tapCount, 1);
  });

  testWidgets('DetailDoseCalcButton disables callback while busy', (
    tester,
  ) async {
    var tapCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: DetailDoseCalcButton(
            label: '用量計算',
            onPressed: () => tapCount += 1,
            enabled: false,
          ),
        ),
      ),
    );

    await tester.tap(
      find.byKey(const ValueKey<String>('detail-dose-calc-button')),
    );
    expect(tapCount, 0);
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_dose_calc_button',
    description: 'DetailDoseCalcButton follows Detail Spec calc CSS',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: (theme, size, textScaler) {
      return MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final colors = Theme.of(
                context,
              ).extension<DetailColorExtension>()!;
              return ColoredBox(
                color: colors.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DetailDoseCalcButton(
                    label: '用量計算',
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
