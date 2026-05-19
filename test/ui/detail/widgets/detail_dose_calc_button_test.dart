import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_dose_calc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets(
    'DetailDoseCalcButton matches calc button sizing and colors [assertion 1/11]',
    (
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
      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([decoration.color, colors.primary]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(22)]);

      Object.hashAll([icon.size, 18]);

      Object.hashAll([icon.color, colors.onPrimary]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onPrimary]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-dose-calc-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailDoseCalcButton matches calc button sizing and colors [assertion 2/11]',
    (
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

      Object.hashAll([button.constraints?.minHeight, 44]);

      expect(button.constraints?.maxHeight, 44);
      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([decoration.color, colors.primary]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(22)]);

      Object.hashAll([icon.size, 18]);

      Object.hashAll([icon.color, colors.onPrimary]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onPrimary]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-dose-calc-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailDoseCalcButton matches calc button sizing and colors [assertion 3/11]',
    (
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

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      expect(button.padding, const EdgeInsets.symmetric(horizontal: 16));
      Object.hashAll([decoration.color, colors.primary]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(22)]);

      Object.hashAll([icon.size, 18]);

      Object.hashAll([icon.color, colors.onPrimary]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onPrimary]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-dose-calc-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailDoseCalcButton matches calc button sizing and colors [assertion 4/11]',
    (
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

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      expect(decoration.color, colors.primary);
      Object.hashAll([decoration.borderRadius, BorderRadius.circular(22)]);

      Object.hashAll([icon.size, 18]);

      Object.hashAll([icon.color, colors.onPrimary]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onPrimary]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-dose-calc-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailDoseCalcButton matches calc button sizing and colors [assertion 5/11]',
    (
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

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([decoration.color, colors.primary]);

      expect(decoration.borderRadius, BorderRadius.circular(22));
      Object.hashAll([icon.size, 18]);

      Object.hashAll([icon.color, colors.onPrimary]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onPrimary]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-dose-calc-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailDoseCalcButton matches calc button sizing and colors [assertion 6/11]',
    (
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

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([decoration.color, colors.primary]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(22)]);

      expect(icon.size, 18);
      Object.hashAll([icon.color, colors.onPrimary]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onPrimary]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-dose-calc-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailDoseCalcButton matches calc button sizing and colors [assertion 7/11]',
    (
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

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([decoration.color, colors.primary]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(22)]);

      Object.hashAll([icon.size, 18]);

      expect(icon.color, colors.onPrimary);
      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onPrimary]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-dose-calc-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailDoseCalcButton matches calc button sizing and colors [assertion 8/11]',
    (
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

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([decoration.color, colors.primary]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(22)]);

      Object.hashAll([icon.size, 18]);

      Object.hashAll([icon.color, colors.onPrimary]);

      expect(text.style?.fontSize, 14);
      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onPrimary]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-dose-calc-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailDoseCalcButton matches calc button sizing and colors [assertion 9/11]',
    (
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

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([decoration.color, colors.primary]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(22)]);

      Object.hashAll([icon.size, 18]);

      Object.hashAll([icon.color, colors.onPrimary]);

      Object.hashAll([text.style?.fontSize, 14]);

      expect(text.style?.fontWeight, FontWeight.w600);
      Object.hashAll([text.style?.color, colors.onPrimary]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-dose-calc-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailDoseCalcButton matches calc button sizing and colors [assertion 10/11]',
    (
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

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([decoration.color, colors.primary]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(22)]);

      Object.hashAll([icon.size, 18]);

      Object.hashAll([icon.color, colors.onPrimary]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      expect(text.style?.color, colors.onPrimary);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-dose-calc-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailDoseCalcButton matches calc button sizing and colors [assertion 11/11]',
    (
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

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([decoration.color, colors.primary]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(22)]);

      Object.hashAll([icon.size, 18]);

      Object.hashAll([icon.color, colors.onPrimary]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onPrimary]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-dose-calc-button')),
      );
      expect(tapCount, 1);
    },
  );

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
