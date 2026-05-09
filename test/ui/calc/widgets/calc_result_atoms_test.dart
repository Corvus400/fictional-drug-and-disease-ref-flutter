import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_category_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_tool_meta_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calc result atoms', () {
    testWidgets('CalcResultCard renders empty, valid, and hint states', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const Column(
            children: [
              CalcResultCard(
                title: '結果',
                formula: 'BMI = w / h²',
                valueText: '--',
                unit: 'kg/m²',
                placeholder: true,
              ),
              CalcResultCard(
                title: '結果',
                formula: 'BMI = w / h²',
                valueText: '--',
                unit: 'kg/m²',
                placeholder: true,
                hintText: 'すべての項目を入力してください',
              ),
              CalcResultCard(
                title: '結果',
                formula: 'BMI = w / h²',
                valueText: '22.5',
                unit: 'kg/m²',
              ),
            ],
          ),
        ),
      );

      expect(find.text('結果'), findsNWidgets(3));
      expect(find.text('BMI = w / h²'), findsNWidgets(3));
      expect(find.text('--'), findsNWidgets(2));
      expect(find.text('22.5'), findsOneWidget);
      expect(find.text('すべての項目を入力してください'), findsOneWidget);

      final firstCard = tester.widget<DecoratedBox>(
        find
            .descendant(
              of: find.byType(CalcResultCard).first,
              matching: find.byType(DecoratedBox),
            )
            .first,
      );
      final decoration = firstCard.decoration as BoxDecoration;
      final palette = Theme.of(
        tester.element(find.byType(CalcResultCard).first),
      ).extension<AppPalette>()!;
      expect(decoration.color, palette.calcSurface);
      expect(decoration.border?.top.color, palette.calcHairline);
    });

    testWidgets('CalcResultCard empty shell dimensions match the spec', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 168,
              child: CalcResultCard(
                title: '結果',
                formula: 'BMI = w / h²',
                valueText: '--',
                unit: 'kg/m²',
                placeholder: true,
              ),
            ),
          ),
        ),
      );

      expect(
        tester.getSize(find.byType(CalcResultCard)),
        const Size(168, 95),
      );
    });

    testWidgets('CalcCategoryBadge maps BMI and CKD labels to palettes', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const Wrap(
            children: [
              CalcCategoryBadge.bmi(
                category: BmiCategory.normal,
                label: '普通体重',
              ),
              CalcCategoryBadge.ckd(
                stage: CkdStage.g2,
                label: 'G2 軽度低下',
              ),
            ],
          ),
        ),
      );

      expect(find.text('普通体重'), findsOneWidget);
      expect(find.text('G2 軽度低下'), findsOneWidget);
      final palette = Theme.of(
        tester.element(find.byType(CalcCategoryBadge).first),
      ).extension<AppPalette>()!;
      final bmiBadge = tester.widget<DecoratedBox>(
        find
            .descendant(
              of: find.byType(CalcCategoryBadge).first,
              matching: find.byType(DecoratedBox),
            )
            .first,
      );
      final bmiDecoration = bmiBadge.decoration as BoxDecoration;
      expect(
        bmiDecoration.color,
        palette.calcBmiCategoryPalette[CalcBmiCategoryToken.normal]!.bg,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
        findsNWidgets(2),
      );
      final badgeSize = tester.getSize(find.byType(CalcCategoryBadge).first);
      expect(badgeSize.width, closeTo(82.9, 0.1));
      expect(badgeSize.height, 26);
    });

    testWidgets('CalcToolMetaStrip renders uppercase meta and formula', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const CalcToolMetaStrip(
            label: 'BMI',
            formula: 'BMI = w / h²',
          ),
        ),
      );

      expect(find.text('BMI'), findsOneWidget);
      expect(find.text('BMI = w / h²'), findsOneWidget);
      final label = tester.widget<Text>(find.text('BMI'));
      expect(label.style?.fontWeight, FontWeight.w600);
      expect(label.style?.letterSpacing, 0.44);
    });
  });
}

Widget _widgetTestApp({required Widget child}) {
  return MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(body: child),
  );
}
