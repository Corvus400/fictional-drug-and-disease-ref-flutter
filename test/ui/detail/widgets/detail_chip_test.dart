import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DetailChip uses W2 color for the requested enum kind', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [AppPalette.light],
        ),
        home: const Scaffold(
          body: Column(
            children: [
              DetailChip(
                enumKey: 'tablet',
                enumKind: ChipKind.dosageForm,
                label: '錠剤',
              ),
              DetailChip(
                enumKey: 'inhalation',
                enumKind: ChipKind.routeOfAdmin,
                label: '吸入',
              ),
            ],
          ),
        ),
      ),
    );

    final chips = tester.widgetList<Container>(
      find.byKey(const ValueKey<String>('detail-chip')),
    );

    expect(
      (chips.elementAt(0).decoration! as BoxDecoration).color,
      AppPalette.light.chipDosageForm['tablet'],
    );
    expect(
      (chips.elementAt(1).decoration! as BoxDecoration).color,
      AppPalette.light.chipRouteOfAdmin['inhalation'],
    );
  });

  testWidgets('DetailChip follows the T2 wrapping and sizing rule', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [AppPalette.light],
        ),
        home: const Scaffold(
          body: SizedBox(
            width: 96,
            child: DetailChip(
              enumKey: 'tablet',
              enumKind: ChipKind.dosageForm,
              label: 'とても長い剤形ラベル',
            ),
          ),
        ),
      ),
    );

    final chip = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-chip')),
    );
    final text = tester.widget<Text>(find.text('とても長い剤形ラベル'));

    expect(chip.constraints?.minHeight, 30);
    expect(text.softWrap, isTrue);
    expect(text.maxLines, isNull);
    expect(text.style?.height, 1.35);
    expect(
      tester
          .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
          .width,
      96,
    );
  });

  testWidgets('DetailChip keeps border on the wrapper only', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [AppPalette.light],
        ),
        home: const Scaffold(
          body: DetailChip(
            enumKey: 'tablet',
            enumKind: ChipKind.dosageForm,
            label: '錠剤',
          ),
        ),
      ),
    );

    final wrapper = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-chip-wrapper')),
    );
    final chip = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-chip')),
    );

    expect((wrapper.decoration! as BoxDecoration).border, isNotNull);
    expect((wrapper.decoration! as BoxDecoration).borderRadius, isNotNull);
    expect((chip.decoration! as BoxDecoration).border, isNull);
  });
}
