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
    testWidgets(
      'CalcResultCard renders empty, valid, and hint states [assertion 1/7]',
      (
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
        Object.hashAll([find.text('BMI = w / h²'), findsNWidgets(3)]);

        Object.hashAll([find.text('--'), findsNWidgets(2)]);

        Object.hashAll([find.text('22.5'), findsOneWidget]);

        Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

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
        Object.hashAll([decoration.color, palette.calcSurface]);

        Object.hashAll([decoration.border?.top.color, palette.calcHairline]);
      },
    );

    testWidgets(
      'CalcResultCard fits long formula and unit in narrow landscape pane',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: const Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 220,
                child: CalcResultCard(
                  title: '結果',
                  formula: 'eGFR = 194 × Cr^-1.094 × Age^-0.287',
                  valueText: '121.7',
                  unit: 'mL/min/1.73m²',
                ),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'CalcResultCard renders empty, valid, and hint states [assertion 2/7]',
      (
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

        Object.hashAll([find.text('結果'), findsNWidgets(3)]);

        expect(find.text('BMI = w / h²'), findsNWidgets(3));
        Object.hashAll([find.text('--'), findsNWidgets(2)]);

        Object.hashAll([find.text('22.5'), findsOneWidget]);

        Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

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
        Object.hashAll([decoration.color, palette.calcSurface]);

        Object.hashAll([decoration.border?.top.color, palette.calcHairline]);
      },
    );

    testWidgets(
      'CalcResultCard renders empty, valid, and hint states [assertion 3/7]',
      (
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

        Object.hashAll([find.text('結果'), findsNWidgets(3)]);

        Object.hashAll([find.text('BMI = w / h²'), findsNWidgets(3)]);

        expect(find.text('--'), findsNWidgets(2));
        Object.hashAll([find.text('22.5'), findsOneWidget]);

        Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

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
        Object.hashAll([decoration.color, palette.calcSurface]);

        Object.hashAll([decoration.border?.top.color, palette.calcHairline]);
      },
    );

    testWidgets(
      'CalcResultCard renders empty, valid, and hint states [assertion 4/7]',
      (
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

        Object.hashAll([find.text('結果'), findsNWidgets(3)]);

        Object.hashAll([find.text('BMI = w / h²'), findsNWidgets(3)]);

        Object.hashAll([find.text('--'), findsNWidgets(2)]);

        expect(find.text('22.5'), findsOneWidget);
        Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

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
        Object.hashAll([decoration.color, palette.calcSurface]);

        Object.hashAll([decoration.border?.top.color, palette.calcHairline]);
      },
    );

    testWidgets(
      'CalcResultCard renders empty, valid, and hint states [assertion 5/7]',
      (
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

        Object.hashAll([find.text('結果'), findsNWidgets(3)]);

        Object.hashAll([find.text('BMI = w / h²'), findsNWidgets(3)]);

        Object.hashAll([find.text('--'), findsNWidgets(2)]);

        Object.hashAll([find.text('22.5'), findsOneWidget]);

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
        Object.hashAll([decoration.color, palette.calcSurface]);

        Object.hashAll([decoration.border?.top.color, palette.calcHairline]);
      },
    );

    testWidgets(
      'CalcResultCard renders empty, valid, and hint states [assertion 6/7]',
      (
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

        Object.hashAll([find.text('結果'), findsNWidgets(3)]);

        Object.hashAll([find.text('BMI = w / h²'), findsNWidgets(3)]);

        Object.hashAll([find.text('--'), findsNWidgets(2)]);

        Object.hashAll([find.text('22.5'), findsOneWidget]);

        Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

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
        Object.hashAll([decoration.border?.top.color, palette.calcHairline]);
      },
    );

    testWidgets(
      'CalcResultCard renders empty, valid, and hint states [assertion 7/7]',
      (
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

        Object.hashAll([find.text('結果'), findsNWidgets(3)]);

        Object.hashAll([find.text('BMI = w / h²'), findsNWidgets(3)]);

        Object.hashAll([find.text('--'), findsNWidgets(2)]);

        Object.hashAll([find.text('22.5'), findsOneWidget]);

        Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

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
        Object.hashAll([decoration.color, palette.calcSurface]);

        expect(decoration.border?.top.color, palette.calcHairline);
      },
    );

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

    testWidgets(
      'CalcCategoryBadge maps BMI and CKD labels to palettes [assertion 1/6]',
      (
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
        Object.hashAll([find.text('G2 軽度低下'), findsOneWidget]);

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
        Object.hashAll([
          bmiDecoration.color,
          palette.calcBmiCategoryPalette[CalcBmiCategoryToken.normal]!.bg,
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        final badgeSize = tester.getSize(find.byType(CalcCategoryBadge).first);
        Object.hashAll([badgeSize.width, closeTo(82.9, 0.1)]);

        Object.hashAll([badgeSize.height, 26]);
      },
    );

    testWidgets(
      'CalcCategoryBadge maps BMI and CKD labels to palettes [assertion 2/6]',
      (
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

        Object.hashAll([find.text('普通体重'), findsOneWidget]);

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
        Object.hashAll([
          bmiDecoration.color,
          palette.calcBmiCategoryPalette[CalcBmiCategoryToken.normal]!.bg,
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        final badgeSize = tester.getSize(find.byType(CalcCategoryBadge).first);
        Object.hashAll([badgeSize.width, closeTo(82.9, 0.1)]);

        Object.hashAll([badgeSize.height, 26]);
      },
    );

    testWidgets(
      'CalcCategoryBadge maps BMI and CKD labels to palettes [assertion 3/6]',
      (
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

        Object.hashAll([find.text('普通体重'), findsOneWidget]);

        Object.hashAll([find.text('G2 軽度低下'), findsOneWidget]);

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
        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        final badgeSize = tester.getSize(find.byType(CalcCategoryBadge).first);
        Object.hashAll([badgeSize.width, closeTo(82.9, 0.1)]);

        Object.hashAll([badgeSize.height, 26]);
      },
    );

    testWidgets(
      'CalcCategoryBadge maps BMI and CKD labels to palettes [assertion 4/6]',
      (
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

        Object.hashAll([find.text('普通体重'), findsOneWidget]);

        Object.hashAll([find.text('G2 軽度低下'), findsOneWidget]);

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
        Object.hashAll([
          bmiDecoration.color,
          palette.calcBmiCategoryPalette[CalcBmiCategoryToken.normal]!.bg,
        ]);

        expect(
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        );
        final badgeSize = tester.getSize(find.byType(CalcCategoryBadge).first);
        Object.hashAll([badgeSize.width, closeTo(82.9, 0.1)]);

        Object.hashAll([badgeSize.height, 26]);
      },
    );

    testWidgets(
      'CalcCategoryBadge maps BMI and CKD labels to palettes [assertion 5/6]',
      (
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

        Object.hashAll([find.text('普通体重'), findsOneWidget]);

        Object.hashAll([find.text('G2 軽度低下'), findsOneWidget]);

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
        Object.hashAll([
          bmiDecoration.color,
          palette.calcBmiCategoryPalette[CalcBmiCategoryToken.normal]!.bg,
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        final badgeSize = tester.getSize(find.byType(CalcCategoryBadge).first);
        expect(badgeSize.width, closeTo(82.9, 0.1));
        Object.hashAll([badgeSize.height, 26]);
      },
    );

    testWidgets(
      'CalcCategoryBadge maps BMI and CKD labels to palettes [assertion 6/6]',
      (
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

        Object.hashAll([find.text('普通体重'), findsOneWidget]);

        Object.hashAll([find.text('G2 軽度低下'), findsOneWidget]);

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
        Object.hashAll([
          bmiDecoration.color,
          palette.calcBmiCategoryPalette[CalcBmiCategoryToken.normal]!.bg,
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        final badgeSize = tester.getSize(find.byType(CalcCategoryBadge).first);
        Object.hashAll([badgeSize.width, closeTo(82.9, 0.1)]);

        expect(badgeSize.height, 26);
      },
    );

    testWidgets(
      'CalcCategoryBadge renders every BMI and CKD label pattern [assertion 1/9]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CalcCategoryBadge.bmi(
                  category: BmiCategory.underweight,
                  label: '低体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.normal,
                  label: '普通体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.overweight,
                  label: '過体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese1,
                  label: '肥満1度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese2,
                  label: '肥満2度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese3,
                  label: '肥満3度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese4,
                  label: '肥満4度',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g1, label: 'G1 正常'),
                CalcCategoryBadge.ckd(stage: CkdStage.g2, label: 'G2 軽度低下'),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3a,
                  label: 'G3a 軽度〜中等度低下',
                ),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3b,
                  label: 'G3b 中等度〜高度低下',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g4, label: 'G4 高度低下'),
                CalcCategoryBadge.ckd(stage: CkdStage.g5, label: 'G5 末期腎不全'),
              ],
            ),
          ),
        );

        for (final label in [
          '低体重',
          '普通体重',
          '過体重',
          '肥満1度',
          '肥満2度',
          '肥満3度',
          '肥満4度',
          'G1 正常',
          'G2 軽度低下',
          'G3a 軽度〜中等度低下',
          'G3b 中等度〜高度低下',
          'G4 高度低下',
          'G5 末期腎不全',
        ]) {
          expect(find.text(label), findsOneWidget);
        }
        Object.hashAll([find.byType(CalcCategoryBadge), findsNWidgets(13)]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-dot')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-square')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-diamond')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-pentagon')),
          findsOneWidget,
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-hexagon')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-x')),
          findsNWidgets(2),
        ]);
      },
    );

    testWidgets(
      'CalcCategoryBadge renders every BMI and CKD label pattern [assertion 2/9]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CalcCategoryBadge.bmi(
                  category: BmiCategory.underweight,
                  label: '低体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.normal,
                  label: '普通体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.overweight,
                  label: '過体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese1,
                  label: '肥満1度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese2,
                  label: '肥満2度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese3,
                  label: '肥満3度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese4,
                  label: '肥満4度',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g1, label: 'G1 正常'),
                CalcCategoryBadge.ckd(stage: CkdStage.g2, label: 'G2 軽度低下'),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3a,
                  label: 'G3a 軽度〜中等度低下',
                ),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3b,
                  label: 'G3b 中等度〜高度低下',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g4, label: 'G4 高度低下'),
                CalcCategoryBadge.ckd(stage: CkdStage.g5, label: 'G5 末期腎不全'),
              ],
            ),
          ),
        );

        for (final label in [
          '低体重',
          '普通体重',
          '過体重',
          '肥満1度',
          '肥満2度',
          '肥満3度',
          '肥満4度',
          'G1 正常',
          'G2 軽度低下',
          'G3a 軽度〜中等度低下',
          'G3b 中等度〜高度低下',
          'G4 高度低下',
          'G5 末期腎不全',
        ]) {
          Object.hashAll([find.text(label), findsOneWidget]);
        }
        expect(find.byType(CalcCategoryBadge), findsNWidgets(13));
        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-dot')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-square')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-diamond')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-pentagon')),
          findsOneWidget,
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-hexagon')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-x')),
          findsNWidgets(2),
        ]);
      },
    );

    testWidgets(
      'CalcCategoryBadge renders every BMI and CKD label pattern [assertion 3/9]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CalcCategoryBadge.bmi(
                  category: BmiCategory.underweight,
                  label: '低体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.normal,
                  label: '普通体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.overweight,
                  label: '過体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese1,
                  label: '肥満1度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese2,
                  label: '肥満2度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese3,
                  label: '肥満3度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese4,
                  label: '肥満4度',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g1, label: 'G1 正常'),
                CalcCategoryBadge.ckd(stage: CkdStage.g2, label: 'G2 軽度低下'),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3a,
                  label: 'G3a 軽度〜中等度低下',
                ),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3b,
                  label: 'G3b 中等度〜高度低下',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g4, label: 'G4 高度低下'),
                CalcCategoryBadge.ckd(stage: CkdStage.g5, label: 'G5 末期腎不全'),
              ],
            ),
          ),
        );

        for (final label in [
          '低体重',
          '普通体重',
          '過体重',
          '肥満1度',
          '肥満2度',
          '肥満3度',
          '肥満4度',
          'G1 正常',
          'G2 軽度低下',
          'G3a 軽度〜中等度低下',
          'G3b 中等度〜高度低下',
          'G4 高度低下',
          'G5 末期腎不全',
        ]) {
          Object.hashAll([find.text(label), findsOneWidget]);
        }
        Object.hashAll([find.byType(CalcCategoryBadge), findsNWidgets(13)]);

        expect(
          find.byKey(const ValueKey<String>('calc-badge-shape-dot')),
          findsNWidgets(2),
        );
        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-square')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-diamond')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-pentagon')),
          findsOneWidget,
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-hexagon')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-x')),
          findsNWidgets(2),
        ]);
      },
    );

    testWidgets(
      'CalcCategoryBadge renders every BMI and CKD label pattern [assertion 4/9]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CalcCategoryBadge.bmi(
                  category: BmiCategory.underweight,
                  label: '低体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.normal,
                  label: '普通体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.overweight,
                  label: '過体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese1,
                  label: '肥満1度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese2,
                  label: '肥満2度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese3,
                  label: '肥満3度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese4,
                  label: '肥満4度',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g1, label: 'G1 正常'),
                CalcCategoryBadge.ckd(stage: CkdStage.g2, label: 'G2 軽度低下'),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3a,
                  label: 'G3a 軽度〜中等度低下',
                ),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3b,
                  label: 'G3b 中等度〜高度低下',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g4, label: 'G4 高度低下'),
                CalcCategoryBadge.ckd(stage: CkdStage.g5, label: 'G5 末期腎不全'),
              ],
            ),
          ),
        );

        for (final label in [
          '低体重',
          '普通体重',
          '過体重',
          '肥満1度',
          '肥満2度',
          '肥満3度',
          '肥満4度',
          'G1 正常',
          'G2 軽度低下',
          'G3a 軽度〜中等度低下',
          'G3b 中等度〜高度低下',
          'G4 高度低下',
          'G5 末期腎不全',
        ]) {
          Object.hashAll([find.text(label), findsOneWidget]);
        }
        Object.hashAll([find.byType(CalcCategoryBadge), findsNWidgets(13)]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-dot')),
          findsNWidgets(2),
        ]);

        expect(
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        );
        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-square')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-diamond')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-pentagon')),
          findsOneWidget,
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-hexagon')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-x')),
          findsNWidgets(2),
        ]);
      },
    );

    testWidgets(
      'CalcCategoryBadge renders every BMI and CKD label pattern [assertion 5/9]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CalcCategoryBadge.bmi(
                  category: BmiCategory.underweight,
                  label: '低体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.normal,
                  label: '普通体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.overweight,
                  label: '過体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese1,
                  label: '肥満1度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese2,
                  label: '肥満2度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese3,
                  label: '肥満3度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese4,
                  label: '肥満4度',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g1, label: 'G1 正常'),
                CalcCategoryBadge.ckd(stage: CkdStage.g2, label: 'G2 軽度低下'),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3a,
                  label: 'G3a 軽度〜中等度低下',
                ),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3b,
                  label: 'G3b 中等度〜高度低下',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g4, label: 'G4 高度低下'),
                CalcCategoryBadge.ckd(stage: CkdStage.g5, label: 'G5 末期腎不全'),
              ],
            ),
          ),
        );

        for (final label in [
          '低体重',
          '普通体重',
          '過体重',
          '肥満1度',
          '肥満2度',
          '肥満3度',
          '肥満4度',
          'G1 正常',
          'G2 軽度低下',
          'G3a 軽度〜中等度低下',
          'G3b 中等度〜高度低下',
          'G4 高度低下',
          'G5 末期腎不全',
        ]) {
          Object.hashAll([find.text(label), findsOneWidget]);
        }
        Object.hashAll([find.byType(CalcCategoryBadge), findsNWidgets(13)]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-dot')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        expect(
          find.byKey(const ValueKey<String>('calc-badge-shape-square')),
          findsNWidgets(2),
        );
        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-diamond')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-pentagon')),
          findsOneWidget,
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-hexagon')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-x')),
          findsNWidgets(2),
        ]);
      },
    );

    testWidgets(
      'CalcCategoryBadge renders every BMI and CKD label pattern [assertion 6/9]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CalcCategoryBadge.bmi(
                  category: BmiCategory.underweight,
                  label: '低体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.normal,
                  label: '普通体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.overweight,
                  label: '過体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese1,
                  label: '肥満1度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese2,
                  label: '肥満2度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese3,
                  label: '肥満3度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese4,
                  label: '肥満4度',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g1, label: 'G1 正常'),
                CalcCategoryBadge.ckd(stage: CkdStage.g2, label: 'G2 軽度低下'),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3a,
                  label: 'G3a 軽度〜中等度低下',
                ),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3b,
                  label: 'G3b 中等度〜高度低下',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g4, label: 'G4 高度低下'),
                CalcCategoryBadge.ckd(stage: CkdStage.g5, label: 'G5 末期腎不全'),
              ],
            ),
          ),
        );

        for (final label in [
          '低体重',
          '普通体重',
          '過体重',
          '肥満1度',
          '肥満2度',
          '肥満3度',
          '肥満4度',
          'G1 正常',
          'G2 軽度低下',
          'G3a 軽度〜中等度低下',
          'G3b 中等度〜高度低下',
          'G4 高度低下',
          'G5 末期腎不全',
        ]) {
          Object.hashAll([find.text(label), findsOneWidget]);
        }
        Object.hashAll([find.byType(CalcCategoryBadge), findsNWidgets(13)]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-dot')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-square')),
          findsNWidgets(2),
        ]);

        expect(
          find.byKey(const ValueKey<String>('calc-badge-shape-diamond')),
          findsNWidgets(2),
        );
        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-pentagon')),
          findsOneWidget,
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-hexagon')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-x')),
          findsNWidgets(2),
        ]);
      },
    );

    testWidgets(
      'CalcCategoryBadge renders every BMI and CKD label pattern [assertion 7/9]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CalcCategoryBadge.bmi(
                  category: BmiCategory.underweight,
                  label: '低体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.normal,
                  label: '普通体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.overweight,
                  label: '過体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese1,
                  label: '肥満1度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese2,
                  label: '肥満2度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese3,
                  label: '肥満3度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese4,
                  label: '肥満4度',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g1, label: 'G1 正常'),
                CalcCategoryBadge.ckd(stage: CkdStage.g2, label: 'G2 軽度低下'),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3a,
                  label: 'G3a 軽度〜中等度低下',
                ),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3b,
                  label: 'G3b 中等度〜高度低下',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g4, label: 'G4 高度低下'),
                CalcCategoryBadge.ckd(stage: CkdStage.g5, label: 'G5 末期腎不全'),
              ],
            ),
          ),
        );

        for (final label in [
          '低体重',
          '普通体重',
          '過体重',
          '肥満1度',
          '肥満2度',
          '肥満3度',
          '肥満4度',
          'G1 正常',
          'G2 軽度低下',
          'G3a 軽度〜中等度低下',
          'G3b 中等度〜高度低下',
          'G4 高度低下',
          'G5 末期腎不全',
        ]) {
          Object.hashAll([find.text(label), findsOneWidget]);
        }
        Object.hashAll([find.byType(CalcCategoryBadge), findsNWidgets(13)]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-dot')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-square')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-diamond')),
          findsNWidgets(2),
        ]);

        expect(
          find.byKey(const ValueKey<String>('calc-badge-shape-pentagon')),
          findsOneWidget,
        );
        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-hexagon')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-x')),
          findsNWidgets(2),
        ]);
      },
    );

    testWidgets(
      'CalcCategoryBadge renders every BMI and CKD label pattern [assertion 8/9]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CalcCategoryBadge.bmi(
                  category: BmiCategory.underweight,
                  label: '低体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.normal,
                  label: '普通体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.overweight,
                  label: '過体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese1,
                  label: '肥満1度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese2,
                  label: '肥満2度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese3,
                  label: '肥満3度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese4,
                  label: '肥満4度',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g1, label: 'G1 正常'),
                CalcCategoryBadge.ckd(stage: CkdStage.g2, label: 'G2 軽度低下'),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3a,
                  label: 'G3a 軽度〜中等度低下',
                ),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3b,
                  label: 'G3b 中等度〜高度低下',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g4, label: 'G4 高度低下'),
                CalcCategoryBadge.ckd(stage: CkdStage.g5, label: 'G5 末期腎不全'),
              ],
            ),
          ),
        );

        for (final label in [
          '低体重',
          '普通体重',
          '過体重',
          '肥満1度',
          '肥満2度',
          '肥満3度',
          '肥満4度',
          'G1 正常',
          'G2 軽度低下',
          'G3a 軽度〜中等度低下',
          'G3b 中等度〜高度低下',
          'G4 高度低下',
          'G5 末期腎不全',
        ]) {
          Object.hashAll([find.text(label), findsOneWidget]);
        }
        Object.hashAll([find.byType(CalcCategoryBadge), findsNWidgets(13)]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-dot')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-square')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-diamond')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-pentagon')),
          findsOneWidget,
        ]);

        expect(
          find.byKey(const ValueKey<String>('calc-badge-shape-hexagon')),
          findsNWidgets(2),
        );
        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-x')),
          findsNWidgets(2),
        ]);
      },
    );

    testWidgets(
      'CalcCategoryBadge renders every BMI and CKD label pattern [assertion 9/9]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CalcCategoryBadge.bmi(
                  category: BmiCategory.underweight,
                  label: '低体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.normal,
                  label: '普通体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.overweight,
                  label: '過体重',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese1,
                  label: '肥満1度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese2,
                  label: '肥満2度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese3,
                  label: '肥満3度',
                ),
                CalcCategoryBadge.bmi(
                  category: BmiCategory.obese4,
                  label: '肥満4度',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g1, label: 'G1 正常'),
                CalcCategoryBadge.ckd(stage: CkdStage.g2, label: 'G2 軽度低下'),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3a,
                  label: 'G3a 軽度〜中等度低下',
                ),
                CalcCategoryBadge.ckd(
                  stage: CkdStage.g3b,
                  label: 'G3b 中等度〜高度低下',
                ),
                CalcCategoryBadge.ckd(stage: CkdStage.g4, label: 'G4 高度低下'),
                CalcCategoryBadge.ckd(stage: CkdStage.g5, label: 'G5 末期腎不全'),
              ],
            ),
          ),
        );

        for (final label in [
          '低体重',
          '普通体重',
          '過体重',
          '肥満1度',
          '肥満2度',
          '肥満3度',
          '肥満4度',
          'G1 正常',
          'G2 軽度低下',
          'G3a 軽度〜中等度低下',
          'G3b 中等度〜高度低下',
          'G4 高度低下',
          'G5 末期腎不全',
        ]) {
          Object.hashAll([find.text(label), findsOneWidget]);
        }
        Object.hashAll([find.byType(CalcCategoryBadge), findsNWidgets(13)]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-dot')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-triangle')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-square')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-diamond')),
          findsNWidgets(2),
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-pentagon')),
          findsOneWidget,
        ]);

        Object.hashAll([
          find.byKey(const ValueKey<String>('calc-badge-shape-hexagon')),
          findsNWidgets(2),
        ]);

        expect(
          find.byKey(const ValueKey<String>('calc-badge-shape-x')),
          findsNWidgets(2),
        );
      },
    );

    testWidgets(
      'CalcToolMetaStrip renders uppercase meta and formula [assertion 1/4]',
      (
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
        Object.hashAll([find.text('BMI = w / h²'), findsOneWidget]);

        final label = tester.widget<Text>(find.text('BMI'));
        Object.hashAll([label.style?.fontWeight, FontWeight.w600]);

        Object.hashAll([label.style?.letterSpacing, 0.44]);
      },
    );

    testWidgets(
      'CalcToolMetaStrip renders uppercase meta and formula [assertion 2/4]',
      (
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

        Object.hashAll([find.text('BMI'), findsOneWidget]);

        expect(find.text('BMI = w / h²'), findsOneWidget);
        final label = tester.widget<Text>(find.text('BMI'));
        Object.hashAll([label.style?.fontWeight, FontWeight.w600]);

        Object.hashAll([label.style?.letterSpacing, 0.44]);
      },
    );

    testWidgets(
      'CalcToolMetaStrip renders uppercase meta and formula [assertion 3/4]',
      (
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

        Object.hashAll([find.text('BMI'), findsOneWidget]);

        Object.hashAll([find.text('BMI = w / h²'), findsOneWidget]);

        final label = tester.widget<Text>(find.text('BMI'));
        expect(label.style?.fontWeight, FontWeight.w600);
        Object.hashAll([label.style?.letterSpacing, 0.44]);
      },
    );

    testWidgets(
      'CalcToolMetaStrip renders uppercase meta and formula [assertion 4/4]',
      (
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

        Object.hashAll([find.text('BMI'), findsOneWidget]);

        Object.hashAll([find.text('BMI = w / h²'), findsOneWidget]);

        final label = tester.widget<Text>(find.text('BMI'));
        Object.hashAll([label.style?.fontWeight, FontWeight.w600]);

        expect(label.style?.letterSpacing, 0.44);
      },
    );
  });
}

Widget _widgetTestApp({required Widget child}) {
  return MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(body: child),
  );
}
