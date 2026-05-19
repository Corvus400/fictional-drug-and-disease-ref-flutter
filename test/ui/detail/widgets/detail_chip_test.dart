import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 1/17]',
    (
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
      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 2/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      expect(hostAlign.alignment, Alignment.center);
      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 3/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      expect(wrapperDecoration.color, palette.surface);
      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 4/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      expect(
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      );
      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 5/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      expect(wrapperDecoration.borderRadius, BorderRadius.circular(10));
      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 6/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      expect(chip.constraints?.minHeight, 30);
      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 7/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      expect(
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      );
      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 8/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      expect(chipDecoration.color, palette.surface3);
      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 9/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      expect(chipDecoration.borderRadius, BorderRadius.circular(15));
      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 10/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      expect(chipDecoration.border, isNull);
      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 11/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      expect(text.textAlign, TextAlign.center);
      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 12/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      expect(text.softWrap, isTrue);
      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 13/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      expect(text.style?.color, palette.ink2);
      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 14/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      expect(text.style?.fontSize, 12);
      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 15/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      expect(text.style?.fontWeight, FontWeight.w600);
      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 16/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      expect(text.style?.height, 1.35);
      Object.hashAll([
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      ]);
    },
  );

  testWidgets(
    'DetailChip matches the search-chip host and neutral chip CSS [assertion 17/17]',
    (
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

      Object.hashAll([
        wrapper.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ]);

      Object.hashAll([hostAlign.alignment, Alignment.center]);

      Object.hashAll([wrapperDecoration.color, palette.surface]);

      Object.hashAll([
        wrapperDecoration.border,
        Border.all(color: palette.hairline, width: 0.5),
      ]);

      Object.hashAll([
        wrapperDecoration.borderRadius,
        BorderRadius.circular(10),
      ]);

      Object.hashAll([chip.constraints?.minHeight, 30]);

      Object.hashAll([
        chip.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([chipDecoration.color, palette.surface3]);

      Object.hashAll([chipDecoration.borderRadius, BorderRadius.circular(15)]);

      Object.hashAll([chipDecoration.border, isNull]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.color, palette.ink2]);

      Object.hashAll([text.style?.fontSize, 12]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      expect(
        tester
            .getSize(find.byKey(const ValueKey<String>('detail-chip-wrapper')))
            .width,
        96,
      );
    },
  );

  testWidgets(
    'DetailChip supports only danger and dx accent tones [assertion 1/4]',
    (
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
      Object.hashAll([
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      ]);

      Object.hashAll([
        (chips.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('診断')).style?.color,
        palette.dxInk,
      ]);
    },
  );

  testWidgets(
    'DetailChip supports only danger and dx accent tones [assertion 2/4]',
    (
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

      Object.hashAll([
        (chips.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      ]);

      expect(tester.widget<Text>(find.text('警告')).style?.color, palette.danger);
      Object.hashAll([
        (chips.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('診断')).style?.color,
        palette.dxInk,
      ]);
    },
  );

  testWidgets(
    'DetailChip supports only danger and dx accent tones [assertion 3/4]',
    (
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

      Object.hashAll([
        (chips.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      ]);

      expect(
        (chips.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      );
      Object.hashAll([
        tester.widget<Text>(find.text('診断')).style?.color,
        palette.dxInk,
      ]);
    },
  );

  testWidgets(
    'DetailChip supports only danger and dx accent tones [assertion 4/4]',
    (
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

      Object.hashAll([
        (chips.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      ]);

      Object.hashAll([
        (chips.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      ]);

      expect(tester.widget<Text>(find.text('診断')).style?.color, palette.dxInk);
    },
  );

  runGoldenMatrix(
    fileNamePrefix: 'detail_chip',
    description: 'DetailChip follows Detail Spec chip CSS',
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
