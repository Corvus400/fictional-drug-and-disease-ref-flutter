import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_category_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_tool_meta_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  _badgePatternGolden(
    description: 'Calc category badge patterns match light spec',
    theme: AppTheme.light(),
    fileName: 'goldens/macos/calc_category_badges_all_light.png',
  );
  _badgePatternGolden(
    description: 'Calc category badge patterns match dark spec',
    theme: AppTheme.dark(),
    fileName: 'goldens/macos/calc_category_badges_all_dark.png',
  );

  testWidgets('Calc result atoms match spec reference card', (tester) async {
    await tester.binding.setSurfaceSize(const Size(270, 524));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Material(
          child: RepaintBoundary(
            key: ValueKey<String>('result-atoms-reference-boundary'),
            child: SizedBox(
              width: 270,
              height: 524,
              child: _ResultAtomsCard(),
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byKey(const ValueKey<String>('result-atoms-reference-boundary')),
      matchesGoldenFile('goldens/macos/calc_result_atoms_light.png'),
    );
  }, tags: const ['golden']);

  testWidgets('Calc tool meta strip matches CSS spec', (tester) async {
    await tester.binding.setSurfaceSize(const Size(358, 48));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: RepaintBoundary(
            key: ValueKey<String>('tool-meta-strip-boundary'),
            child: Material(
              child: SizedBox(
                width: 358,
                height: 48,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CalcToolMetaStrip(
                    label: 'BMI',
                    formula: 'BMI = w / h²',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byKey(const ValueKey<String>('tool-meta-strip-boundary')),
      matchesGoldenFile('goldens/macos/calc_tool_meta_strip_light.png'),
    );
  }, tags: const ['golden']);
}

void _badgePatternGolden({
  required String description,
  required ThemeData theme,
  required String fileName,
}) {
  testWidgets(description, (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 280));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: const Material(
          child: RepaintBoundary(
            key: ValueKey<String>('category-badges-boundary'),
            child: SizedBox(
              width: 390,
              height: 280,
              child: _BadgePatternCard(),
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byKey(const ValueKey<String>('category-badges-boundary')),
      matchesGoldenFile(fileName),
    );
  }, tags: const ['golden']);
}

class _BadgePatternCard extends StatelessWidget {
  const _BadgePatternCard();

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return ColoredBox(
      color: surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BMI labels',
              style: TextStyle(
                fontFamily: 'NotoSansJP',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            const Wrap(
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
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'eGFR labels',
              style: TextStyle(
                fontFamily: 'NotoSansJP',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
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
          ],
        ),
      ),
    );
  }
}

class _ResultAtomsCard extends StatelessWidget {
  const _ResultAtomsCard();

  @override
  Widget build(BuildContext context) {
    const pageCard = Color(0xFFFFFFFF);
    const pageRule = Color(0xFFD8DCE3);
    const pageFg = Color(0xFF15181D);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: pageCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: pageRule),
      ),
      child: const Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Result card',
              style: TextStyle(
                fontFamily: 'NotoSansJP',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                height: 1.25,
                color: pageFg,
              ),
            ),
            SizedBox(height: 10),
            _AtomRow(
              label: 'empty',
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
            SizedBox(height: 8),
            _AtomRow(
              label: 'valid',
              child: SizedBox(
                width: 168,
                child: CalcResultCard(
                  title: '結果',
                  formula: 'BMI = w / h²',
                  valueText: '22.5',
                  unit: 'kg/m²',
                ),
              ),
            ),
            SizedBox(height: 8),
            _AtomRow(
              label: 'w/ class',
              child: SizedBox(
                width: 168,
                child: CalcResultCard(
                  title: '結果',
                  formula: 'BMI = w / h²',
                  valueText: '22.5',
                  unit: 'kg/m²',
                  badges: [
                    CalcCategoryBadge.bmi(
                      category: BmiCategory.normal,
                      label: '普通体重',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AtomRow extends StatelessWidget {
  const _AtomRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const pageMuted = Color(0xFF5C6370);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 64,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'JetBrainsMono',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.16,
              letterSpacing: 0.44,
            ).copyWith(color: pageMuted),
          ),
        ),
        const SizedBox(width: 8),
        child,
      ],
    );
  }
}
