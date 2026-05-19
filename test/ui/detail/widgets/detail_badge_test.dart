import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets(
    'DetailBadge matches base badge sizing and typography [assertion 1/11]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SizedBox(
              width: 96,
              child: DetailBadge(label: 'とても長いバッジラベル'),
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final badge = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );
      final decoration = badge.decoration! as BoxDecoration;
      final text = tester.widget<Text>(find.text('とても長いバッジラベル'));

      expect(badge.constraints?.minHeight, 24);
      Object.hashAll([
        badge.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([decoration.color, palette.surface3]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(12)]);

      Object.hashAll([
        decoration.border,
        Border.all(color: Colors.transparent),
      ]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.fontSize, 11]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([text.style?.color, palette.ink2]);
    },
  );

  testWidgets(
    'DetailBadge matches base badge sizing and typography [assertion 2/11]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SizedBox(
              width: 96,
              child: DetailBadge(label: 'とても長いバッジラベル'),
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final badge = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );
      final decoration = badge.decoration! as BoxDecoration;
      final text = tester.widget<Text>(find.text('とても長いバッジラベル'));

      Object.hashAll([badge.constraints?.minHeight, 24]);

      expect(
        badge.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      );
      Object.hashAll([decoration.color, palette.surface3]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(12)]);

      Object.hashAll([
        decoration.border,
        Border.all(color: Colors.transparent),
      ]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.fontSize, 11]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([text.style?.color, palette.ink2]);
    },
  );

  testWidgets(
    'DetailBadge matches base badge sizing and typography [assertion 3/11]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SizedBox(
              width: 96,
              child: DetailBadge(label: 'とても長いバッジラベル'),
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final badge = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );
      final decoration = badge.decoration! as BoxDecoration;
      final text = tester.widget<Text>(find.text('とても長いバッジラベル'));

      Object.hashAll([badge.constraints?.minHeight, 24]);

      Object.hashAll([
        badge.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      expect(decoration.color, palette.surface3);
      Object.hashAll([decoration.borderRadius, BorderRadius.circular(12)]);

      Object.hashAll([
        decoration.border,
        Border.all(color: Colors.transparent),
      ]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.fontSize, 11]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([text.style?.color, palette.ink2]);
    },
  );

  testWidgets(
    'DetailBadge matches base badge sizing and typography [assertion 4/11]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SizedBox(
              width: 96,
              child: DetailBadge(label: 'とても長いバッジラベル'),
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final badge = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );
      final decoration = badge.decoration! as BoxDecoration;
      final text = tester.widget<Text>(find.text('とても長いバッジラベル'));

      Object.hashAll([badge.constraints?.minHeight, 24]);

      Object.hashAll([
        badge.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([decoration.color, palette.surface3]);

      expect(decoration.borderRadius, BorderRadius.circular(12));
      Object.hashAll([
        decoration.border,
        Border.all(color: Colors.transparent),
      ]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.fontSize, 11]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([text.style?.color, palette.ink2]);
    },
  );

  testWidgets(
    'DetailBadge matches base badge sizing and typography [assertion 5/11]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SizedBox(
              width: 96,
              child: DetailBadge(label: 'とても長いバッジラベル'),
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final badge = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );
      final decoration = badge.decoration! as BoxDecoration;
      final text = tester.widget<Text>(find.text('とても長いバッジラベル'));

      Object.hashAll([badge.constraints?.minHeight, 24]);

      Object.hashAll([
        badge.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([decoration.color, palette.surface3]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(12)]);

      expect(decoration.border, Border.all(color: Colors.transparent));
      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.fontSize, 11]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([text.style?.color, palette.ink2]);
    },
  );

  testWidgets(
    'DetailBadge matches base badge sizing and typography [assertion 6/11]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SizedBox(
              width: 96,
              child: DetailBadge(label: 'とても長いバッジラベル'),
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final badge = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );
      final decoration = badge.decoration! as BoxDecoration;
      final text = tester.widget<Text>(find.text('とても長いバッジラベル'));

      Object.hashAll([badge.constraints?.minHeight, 24]);

      Object.hashAll([
        badge.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([decoration.color, palette.surface3]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(12)]);

      Object.hashAll([
        decoration.border,
        Border.all(color: Colors.transparent),
      ]);

      expect(text.textAlign, TextAlign.center);
      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.fontSize, 11]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([text.style?.color, palette.ink2]);
    },
  );

  testWidgets(
    'DetailBadge matches base badge sizing and typography [assertion 7/11]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SizedBox(
              width: 96,
              child: DetailBadge(label: 'とても長いバッジラベル'),
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final badge = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );
      final decoration = badge.decoration! as BoxDecoration;
      final text = tester.widget<Text>(find.text('とても長いバッジラベル'));

      Object.hashAll([badge.constraints?.minHeight, 24]);

      Object.hashAll([
        badge.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([decoration.color, palette.surface3]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(12)]);

      Object.hashAll([
        decoration.border,
        Border.all(color: Colors.transparent),
      ]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      expect(text.softWrap, isTrue);
      Object.hashAll([text.style?.fontSize, 11]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([text.style?.color, palette.ink2]);
    },
  );

  testWidgets(
    'DetailBadge matches base badge sizing and typography [assertion 8/11]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SizedBox(
              width: 96,
              child: DetailBadge(label: 'とても長いバッジラベル'),
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final badge = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );
      final decoration = badge.decoration! as BoxDecoration;
      final text = tester.widget<Text>(find.text('とても長いバッジラベル'));

      Object.hashAll([badge.constraints?.minHeight, 24]);

      Object.hashAll([
        badge.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([decoration.color, palette.surface3]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(12)]);

      Object.hashAll([
        decoration.border,
        Border.all(color: Colors.transparent),
      ]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      expect(text.style?.fontSize, 11);
      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([text.style?.color, palette.ink2]);
    },
  );

  testWidgets(
    'DetailBadge matches base badge sizing and typography [assertion 9/11]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SizedBox(
              width: 96,
              child: DetailBadge(label: 'とても長いバッジラベル'),
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final badge = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );
      final decoration = badge.decoration! as BoxDecoration;
      final text = tester.widget<Text>(find.text('とても長いバッジラベル'));

      Object.hashAll([badge.constraints?.minHeight, 24]);

      Object.hashAll([
        badge.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([decoration.color, palette.surface3]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(12)]);

      Object.hashAll([
        decoration.border,
        Border.all(color: Colors.transparent),
      ]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.fontSize, 11]);

      expect(text.style?.fontWeight, FontWeight.w600);
      Object.hashAll([text.style?.height, 1.35]);

      Object.hashAll([text.style?.color, palette.ink2]);
    },
  );

  testWidgets(
    'DetailBadge matches base badge sizing and typography [assertion 10/11]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SizedBox(
              width: 96,
              child: DetailBadge(label: 'とても長いバッジラベル'),
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final badge = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );
      final decoration = badge.decoration! as BoxDecoration;
      final text = tester.widget<Text>(find.text('とても長いバッジラベル'));

      Object.hashAll([badge.constraints?.minHeight, 24]);

      Object.hashAll([
        badge.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([decoration.color, palette.surface3]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(12)]);

      Object.hashAll([
        decoration.border,
        Border.all(color: Colors.transparent),
      ]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.fontSize, 11]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      expect(text.style?.height, 1.35);
      Object.hashAll([text.style?.color, palette.ink2]);
    },
  );

  testWidgets(
    'DetailBadge matches base badge sizing and typography [assertion 11/11]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SizedBox(
              width: 96,
              child: DetailBadge(label: 'とても長いバッジラベル'),
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final badge = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );
      final decoration = badge.decoration! as BoxDecoration;
      final text = tester.widget<Text>(find.text('とても長いバッジラベル'));

      Object.hashAll([badge.constraints?.minHeight, 24]);

      Object.hashAll([
        badge.padding,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ]);

      Object.hashAll([decoration.color, palette.surface3]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(12)]);

      Object.hashAll([
        decoration.border,
        Border.all(color: Colors.transparent),
      ]);

      Object.hashAll([text.textAlign, TextAlign.center]);

      Object.hashAll([text.softWrap, isTrue]);

      Object.hashAll([text.style?.fontSize, 11]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.height, 1.35]);

      expect(text.style?.color, palette.ink2);
    },
  );

  testWidgets(
    'DetailBadge supports danger dx outline and custom colors [assertion 1/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                DetailBadge(label: '警告', tone: DetailBadgeTone.danger),
                DetailBadge(label: '診断', tone: DetailBadgeTone.dx),
                DetailBadge(label: '外枠', tone: DetailBadgeTone.outline),
                DetailBadge(
                  label: '劇薬',
                  colors: DetailBadgeColors(
                    background: Color(0xFFFBF6F3),
                    foreground: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      final badges = tester.widgetList<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );

      expect(
        (badges.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      );
      Object.hashAll([
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      ]);

      Object.hashAll([
        (badges.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('診断')).style?.color,
        palette.dxInk,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).color,
        Colors.transparent,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).border,
        Border.all(color: detailColors.outline),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('外枠')).style?.color,
        detailColors.onSurfaceVariant,
      ]);

      Object.hashAll([
        (badges.elementAt(3).decoration! as BoxDecoration).color,
        const Color(0xFFFBF6F3),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('劇薬')).style?.color,
        const Color(0xFFB45309),
      ]);
    },
  );

  testWidgets(
    'DetailBadge supports danger dx outline and custom colors [assertion 2/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                DetailBadge(label: '警告', tone: DetailBadgeTone.danger),
                DetailBadge(label: '診断', tone: DetailBadgeTone.dx),
                DetailBadge(label: '外枠', tone: DetailBadgeTone.outline),
                DetailBadge(
                  label: '劇薬',
                  colors: DetailBadgeColors(
                    background: Color(0xFFFBF6F3),
                    foreground: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      final badges = tester.widgetList<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );

      Object.hashAll([
        (badges.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      ]);

      expect(
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      );
      Object.hashAll([
        (badges.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('診断')).style?.color,
        palette.dxInk,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).color,
        Colors.transparent,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).border,
        Border.all(color: detailColors.outline),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('外枠')).style?.color,
        detailColors.onSurfaceVariant,
      ]);

      Object.hashAll([
        (badges.elementAt(3).decoration! as BoxDecoration).color,
        const Color(0xFFFBF6F3),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('劇薬')).style?.color,
        const Color(0xFFB45309),
      ]);
    },
  );

  testWidgets(
    'DetailBadge supports danger dx outline and custom colors [assertion 3/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                DetailBadge(label: '警告', tone: DetailBadgeTone.danger),
                DetailBadge(label: '診断', tone: DetailBadgeTone.dx),
                DetailBadge(label: '外枠', tone: DetailBadgeTone.outline),
                DetailBadge(
                  label: '劇薬',
                  colors: DetailBadgeColors(
                    background: Color(0xFFFBF6F3),
                    foreground: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      final badges = tester.widgetList<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );

      Object.hashAll([
        (badges.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      ]);

      expect(
        (badges.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      );
      Object.hashAll([
        tester.widget<Text>(find.text('診断')).style?.color,
        palette.dxInk,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).color,
        Colors.transparent,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).border,
        Border.all(color: detailColors.outline),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('外枠')).style?.color,
        detailColors.onSurfaceVariant,
      ]);

      Object.hashAll([
        (badges.elementAt(3).decoration! as BoxDecoration).color,
        const Color(0xFFFBF6F3),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('劇薬')).style?.color,
        const Color(0xFFB45309),
      ]);
    },
  );

  testWidgets(
    'DetailBadge supports danger dx outline and custom colors [assertion 4/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                DetailBadge(label: '警告', tone: DetailBadgeTone.danger),
                DetailBadge(label: '診断', tone: DetailBadgeTone.dx),
                DetailBadge(label: '外枠', tone: DetailBadgeTone.outline),
                DetailBadge(
                  label: '劇薬',
                  colors: DetailBadgeColors(
                    background: Color(0xFFFBF6F3),
                    foreground: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      final badges = tester.widgetList<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );

      Object.hashAll([
        (badges.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      ]);

      Object.hashAll([
        (badges.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      ]);

      expect(tester.widget<Text>(find.text('診断')).style?.color, palette.dxInk);
      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).color,
        Colors.transparent,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).border,
        Border.all(color: detailColors.outline),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('外枠')).style?.color,
        detailColors.onSurfaceVariant,
      ]);

      Object.hashAll([
        (badges.elementAt(3).decoration! as BoxDecoration).color,
        const Color(0xFFFBF6F3),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('劇薬')).style?.color,
        const Color(0xFFB45309),
      ]);
    },
  );

  testWidgets(
    'DetailBadge supports danger dx outline and custom colors [assertion 5/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                DetailBadge(label: '警告', tone: DetailBadgeTone.danger),
                DetailBadge(label: '診断', tone: DetailBadgeTone.dx),
                DetailBadge(label: '外枠', tone: DetailBadgeTone.outline),
                DetailBadge(
                  label: '劇薬',
                  colors: DetailBadgeColors(
                    background: Color(0xFFFBF6F3),
                    foreground: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      final badges = tester.widgetList<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );

      Object.hashAll([
        (badges.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      ]);

      Object.hashAll([
        (badges.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('診断')).style?.color,
        palette.dxInk,
      ]);

      expect(
        (badges.elementAt(2).decoration! as BoxDecoration).color,
        Colors.transparent,
      );
      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).border,
        Border.all(color: detailColors.outline),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('外枠')).style?.color,
        detailColors.onSurfaceVariant,
      ]);

      Object.hashAll([
        (badges.elementAt(3).decoration! as BoxDecoration).color,
        const Color(0xFFFBF6F3),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('劇薬')).style?.color,
        const Color(0xFFB45309),
      ]);
    },
  );

  testWidgets(
    'DetailBadge supports danger dx outline and custom colors [assertion 6/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                DetailBadge(label: '警告', tone: DetailBadgeTone.danger),
                DetailBadge(label: '診断', tone: DetailBadgeTone.dx),
                DetailBadge(label: '外枠', tone: DetailBadgeTone.outline),
                DetailBadge(
                  label: '劇薬',
                  colors: DetailBadgeColors(
                    background: Color(0xFFFBF6F3),
                    foreground: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      final badges = tester.widgetList<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );

      Object.hashAll([
        (badges.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      ]);

      Object.hashAll([
        (badges.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('診断')).style?.color,
        palette.dxInk,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).color,
        Colors.transparent,
      ]);

      expect(
        (badges.elementAt(2).decoration! as BoxDecoration).border,
        Border.all(color: detailColors.outline),
      );
      Object.hashAll([
        tester.widget<Text>(find.text('外枠')).style?.color,
        detailColors.onSurfaceVariant,
      ]);

      Object.hashAll([
        (badges.elementAt(3).decoration! as BoxDecoration).color,
        const Color(0xFFFBF6F3),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('劇薬')).style?.color,
        const Color(0xFFB45309),
      ]);
    },
  );

  testWidgets(
    'DetailBadge supports danger dx outline and custom colors [assertion 7/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                DetailBadge(label: '警告', tone: DetailBadgeTone.danger),
                DetailBadge(label: '診断', tone: DetailBadgeTone.dx),
                DetailBadge(label: '外枠', tone: DetailBadgeTone.outline),
                DetailBadge(
                  label: '劇薬',
                  colors: DetailBadgeColors(
                    background: Color(0xFFFBF6F3),
                    foreground: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      final badges = tester.widgetList<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );

      Object.hashAll([
        (badges.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      ]);

      Object.hashAll([
        (badges.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('診断')).style?.color,
        palette.dxInk,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).color,
        Colors.transparent,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).border,
        Border.all(color: detailColors.outline),
      ]);

      expect(
        tester.widget<Text>(find.text('外枠')).style?.color,
        detailColors.onSurfaceVariant,
      );
      Object.hashAll([
        (badges.elementAt(3).decoration! as BoxDecoration).color,
        const Color(0xFFFBF6F3),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('劇薬')).style?.color,
        const Color(0xFFB45309),
      ]);
    },
  );

  testWidgets(
    'DetailBadge supports danger dx outline and custom colors [assertion 8/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                DetailBadge(label: '警告', tone: DetailBadgeTone.danger),
                DetailBadge(label: '診断', tone: DetailBadgeTone.dx),
                DetailBadge(label: '外枠', tone: DetailBadgeTone.outline),
                DetailBadge(
                  label: '劇薬',
                  colors: DetailBadgeColors(
                    background: Color(0xFFFBF6F3),
                    foreground: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      final badges = tester.widgetList<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );

      Object.hashAll([
        (badges.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      ]);

      Object.hashAll([
        (badges.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('診断')).style?.color,
        palette.dxInk,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).color,
        Colors.transparent,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).border,
        Border.all(color: detailColors.outline),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('外枠')).style?.color,
        detailColors.onSurfaceVariant,
      ]);

      expect(
        (badges.elementAt(3).decoration! as BoxDecoration).color,
        const Color(0xFFFBF6F3),
      );
      Object.hashAll([
        tester.widget<Text>(find.text('劇薬')).style?.color,
        const Color(0xFFB45309),
      ]);
    },
  );

  testWidgets(
    'DetailBadge supports danger dx outline and custom colors [assertion 9/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                DetailBadge(label: '警告', tone: DetailBadgeTone.danger),
                DetailBadge(label: '診断', tone: DetailBadgeTone.dx),
                DetailBadge(label: '外枠', tone: DetailBadgeTone.outline),
                DetailBadge(
                  label: '劇薬',
                  colors: DetailBadgeColors(
                    background: Color(0xFFFBF6F3),
                    foreground: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      const palette = AppPalette.light;
      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      final badges = tester.widgetList<Container>(
        find.byKey(const ValueKey<String>('detail-badge')),
      );

      Object.hashAll([
        (badges.elementAt(0).decoration! as BoxDecoration).color,
        palette.dangerCont,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('警告')).style?.color,
        palette.danger,
      ]);

      Object.hashAll([
        (badges.elementAt(1).decoration! as BoxDecoration).color,
        palette.dxTint,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('診断')).style?.color,
        palette.dxInk,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).color,
        Colors.transparent,
      ]);

      Object.hashAll([
        (badges.elementAt(2).decoration! as BoxDecoration).border,
        Border.all(color: detailColors.outline),
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('外枠')).style?.color,
        detailColors.onSurfaceVariant,
      ]);

      Object.hashAll([
        (badges.elementAt(3).decoration! as BoxDecoration).color,
        const Color(0xFFFBF6F3),
      ]);

      expect(
        tester.widget<Text>(find.text('劇薬')).style?.color,
        const Color(0xFFB45309),
      );
    },
  );

  testWidgets('DetailBadgeWrap matches badges wrap spacing [assertion 1/3]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailBadgeWrap(
            children: [
              DetailBadge(label: '内科'),
              DetailBadge(label: '急性'),
            ],
          ),
        ),
      ),
    );

    final margin = tester.widget<Padding>(
      find.byKey(const ValueKey<String>('detail-badge-wrap-margin')),
    );
    final wrap = tester.widget<Wrap>(
      find.byKey(const ValueKey<String>('detail-badge-wrap')),
    );

    expect(margin.padding, const EdgeInsets.only(top: 8));
    Object.hashAll([wrap.spacing, 6]);

    Object.hashAll([wrap.runSpacing, 6]);
  });

  testWidgets('DetailBadgeWrap matches badges wrap spacing [assertion 2/3]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailBadgeWrap(
            children: [
              DetailBadge(label: '内科'),
              DetailBadge(label: '急性'),
            ],
          ),
        ),
      ),
    );

    final margin = tester.widget<Padding>(
      find.byKey(const ValueKey<String>('detail-badge-wrap-margin')),
    );
    final wrap = tester.widget<Wrap>(
      find.byKey(const ValueKey<String>('detail-badge-wrap')),
    );

    Object.hashAll([margin.padding, const EdgeInsets.only(top: 8)]);

    expect(wrap.spacing, 6);
    Object.hashAll([wrap.runSpacing, 6]);
  });

  testWidgets('DetailBadgeWrap matches badges wrap spacing [assertion 3/3]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailBadgeWrap(
            children: [
              DetailBadge(label: '内科'),
              DetailBadge(label: '急性'),
            ],
          ),
        ),
      ),
    );

    final margin = tester.widget<Padding>(
      find.byKey(const ValueKey<String>('detail-badge-wrap-margin')),
    );
    final wrap = tester.widget<Wrap>(
      find.byKey(const ValueKey<String>('detail-badge-wrap')),
    );

    Object.hashAll([margin.padding, const EdgeInsets.only(top: 8)]);

    Object.hashAll([wrap.spacing, 6]);

    expect(wrap.runSpacing, 6);
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_badge',
    description: 'DetailBadge follows Detail Spec badge CSS',
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
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: DetailBadgeWrap(
                    children: [
                      DetailBadge(label: '普通薬'),
                      DetailBadge(label: '警告', tone: DetailBadgeTone.danger),
                      DetailBadge(label: '診断', tone: DetailBadgeTone.dx),
                      DetailBadge(label: '外枠', tone: DetailBadgeTone.outline),
                      DetailBadge(label: '長いバッジラベルの折り返し確認'),
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
