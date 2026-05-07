import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailChip matches the search-chip host and neutral chip CSS', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: SizedBox(
            width: 96,
            child: DetailChip(label: 'とても長い剤形ラベル'),
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final wrapper = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-chip-wrapper')),
    );
    final wrapperDecoration = wrapper.decoration! as BoxDecoration;
    final hostAlign = tester.widget<Align>(
      find.byKey(const ValueKey<String>('detail-chip-host-align')),
    );
    final chip = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-chip')),
    );
    final chipDecoration = chip.decoration! as BoxDecoration;
    final text = tester.widget<Text>(find.text('とても長い剤形ラベル'));

    expect(
      wrapper.padding,
      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    );
    expect(hostAlign.alignment, Alignment.center);
    expect(wrapperDecoration.color, palette.surface);
    expect(
      wrapperDecoration.border,
      Border.all(color: palette.hairline, width: 0.5),
    );
    expect(wrapperDecoration.borderRadius, BorderRadius.circular(10));
    expect(chip.constraints?.minHeight, 30);
    expect(
      chip.padding,
      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    );
    expect(chipDecoration.color, palette.surface3);
    expect(chipDecoration.borderRadius, BorderRadius.circular(15));
    expect(chipDecoration.border, isNull);
    expect(text.textAlign, TextAlign.center);
    expect(text.softWrap, isTrue);
    expect(text.style?.color, palette.ink2);
    expect(text.style?.fontSize, 12);
    expect(text.style?.fontWeight, FontWeight.w600);
    expect(text.style?.height, 1.35);
    expect(
      tester
          .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
          .width,
      96,
    );
  });

  testWidgets('DetailChip supports only danger and dx accent tones', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: Column(
            children: [
              DetailChip(label: '警告', tone: DetailChipTone.danger),
              DetailChip(label: '診断', tone: DetailChipTone.dx),
            ],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final chips = tester.widgetList<Container>(
      find.byKey(const ValueKey<String>('detail-chip')),
    );

    expect(
      (chips.elementAt(0).decoration! as BoxDecoration).color,
      palette.dangerCont,
    );
    expect(tester.widget<Text>(find.text('警告')).style?.color, palette.danger);
    expect(
      (chips.elementAt(1).decoration! as BoxDecoration).color,
      palette.dxTint,
    );
    expect(tester.widget<Text>(find.text('診断')).style?.color, palette.dxInk);
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_chip',
    description: 'DetailChip follows Detail Spec chip CSS',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: (theme, size, textScaler) {
      return MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final palette = Theme.of(context).extension<AppPalette>()!;
              return ColoredBox(
                color: palette.bg,
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      DetailChip(label: '普通'),
                      DetailChip(label: '警告', tone: DetailChipTone.danger),
                      DetailChip(label: '診断', tone: DetailChipTone.dx),
                      SizedBox(
                        width: 116,
                        child: DetailChip(label: '長いチップラベルの折り返し'),
                      ),
                    ],
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
