import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_bookmark_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 1/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      expect(footer.constraints?.minHeight, 64);
      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 2/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      expect(footer.constraints?.maxHeight, 64);
      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 3/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      expect(footer.padding, const EdgeInsets.symmetric(horizontal: 16));
      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 4/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      expect(footerDecoration.color, colors.surfaceContainerLowest);
      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 5/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      expect(
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      );
      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 6/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      expect(footerDecoration.boxShadow?.single.offset, const Offset(0, -4));
      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 7/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      expect(footerDecoration.boxShadow?.single.blurRadius, 12);
      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 8/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      expect(button.constraints?.minHeight, 44);
      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 9/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      expect(button.constraints?.maxHeight, 44);
      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 10/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      expect(button.padding, const EdgeInsets.symmetric(horizontal: 16));
      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 11/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      expect(buttonDecoration.color, colors.surfaceContainer);
      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 12/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      expect(buttonDecoration.borderRadius, BorderRadius.circular(22));
      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 13/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      expect(icon.color, colors.onSurface);
      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 14/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      expect(text.style?.fontSize, 14);
      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 15/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      expect(text.style?.fontWeight, FontWeight.w600);
      Object.hashAll([text.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter matches footer and bookmark button CSS [assertion 16/16]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final footer = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-footer')),
      );
      final footerDecoration = footer.decoration! as BoxDecoration;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;
      final icon = tester.widget<Icon>(find.byIcon(Icons.bookmark_border));
      final text = tester.widget<Text>(find.text('ブックマーク'));

      Object.hashAll([footer.constraints?.minHeight, 64]);

      Object.hashAll([footer.constraints?.maxHeight, 64]);

      Object.hashAll([
        footer.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([footerDecoration.color, colors.surfaceContainerLowest]);

      Object.hashAll([
        footerDecoration.border,
        Border(top: BorderSide(color: colors.outlineVariant)),
      ]);

      Object.hashAll([
        footerDecoration.boxShadow?.single.offset,
        const Offset(0, -4),
      ]);

      Object.hashAll([footerDecoration.boxShadow?.single.blurRadius, 12]);

      Object.hashAll([button.constraints?.minHeight, 44]);

      Object.hashAll([button.constraints?.maxHeight, 44]);

      Object.hashAll([
        button.padding,
        const EdgeInsets.symmetric(horizontal: 16),
      ]);

      Object.hashAll([buttonDecoration.color, colors.surfaceContainer]);

      Object.hashAll([
        buttonDecoration.borderRadius,
        BorderRadius.circular(22),
      ]);

      Object.hashAll([icon.color, colors.onSurface]);

      Object.hashAll([text.style?.fontSize, 14]);

      Object.hashAll([text.style?.fontWeight, FontWeight.w600]);

      expect(text.style?.color, colors.onSurface);
    },
  );

  testWidgets(
    'DetailBookmarkFooter uses bookmarked state and toggles [assertion 1/5]',
    (
      tester,
    ) async {
      var tapCount = 0;
      await tester.pumpWidget(
        _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: true,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: () => tapCount += 1,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;

      expect(find.byIcon(Icons.bookmark), findsOneWidget);
      Object.hashAll([find.text('ブックマーク済み'), findsOneWidget]);

      Object.hashAll([buttonDecoration.color, colors.primaryContainer]);

      Object.hashAll([
        tester.widget<Text>(find.text('ブックマーク済み')).style?.color,
        colors.onPrimaryContainer,
      ]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter uses bookmarked state and toggles [assertion 2/5]',
    (
      tester,
    ) async {
      var tapCount = 0;
      await tester.pumpWidget(
        _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: true,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: () => tapCount += 1,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;

      Object.hashAll([find.byIcon(Icons.bookmark), findsOneWidget]);

      expect(find.text('ブックマーク済み'), findsOneWidget);
      Object.hashAll([buttonDecoration.color, colors.primaryContainer]);

      Object.hashAll([
        tester.widget<Text>(find.text('ブックマーク済み')).style?.color,
        colors.onPrimaryContainer,
      ]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter uses bookmarked state and toggles [assertion 3/5]',
    (
      tester,
    ) async {
      var tapCount = 0;
      await tester.pumpWidget(
        _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: true,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: () => tapCount += 1,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;

      Object.hashAll([find.byIcon(Icons.bookmark), findsOneWidget]);

      Object.hashAll([find.text('ブックマーク済み'), findsOneWidget]);

      expect(buttonDecoration.color, colors.primaryContainer);
      Object.hashAll([
        tester.widget<Text>(find.text('ブックマーク済み')).style?.color,
        colors.onPrimaryContainer,
      ]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter uses bookmarked state and toggles [assertion 4/5]',
    (
      tester,
    ) async {
      var tapCount = 0;
      await tester.pumpWidget(
        _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: true,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: () => tapCount += 1,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;

      Object.hashAll([find.byIcon(Icons.bookmark), findsOneWidget]);

      Object.hashAll([find.text('ブックマーク済み'), findsOneWidget]);

      Object.hashAll([buttonDecoration.color, colors.primaryContainer]);

      expect(
        tester.widget<Text>(find.text('ブックマーク済み')).style?.color,
        colors.onPrimaryContainer,
      );

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      Object.hashAll([tapCount, 1]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter uses bookmarked state and toggles [assertion 5/5]',
    (
      tester,
    ) async {
      var tapCount = 0;
      await tester.pumpWidget(
        _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: true,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: () => tapCount += 1,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final button = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      final buttonDecoration = button.decoration! as BoxDecoration;

      Object.hashAll([find.byIcon(Icons.bookmark), findsOneWidget]);

      Object.hashAll([find.text('ブックマーク済み'), findsOneWidget]);

      Object.hashAll([buttonDecoration.color, colors.primaryContainer]);

      Object.hashAll([
        tester.widget<Text>(find.text('ブックマーク済み')).style?.color,
        colors.onPrimaryContainer,
      ]);

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );
      expect(tapCount, 1);
    },
  );

  testWidgets(
    'DetailBookmarkFooter disables taps while busy without inline error [assertion 1/2]',
    (
      tester,
    ) async {
      var tapCount = 0;
      await tester.pumpWidget(
        _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: true,
            bookmarkError: const StorageException(
              kind: StorageErrorKind.unknown,
            ),
            onToggleBookmark: () => tapCount += 1,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );

      expect(tapCount, 0);
      Object.hashAll([find.text('ブックマークの更新に失敗しました'), findsNothing]);
    },
  );

  testWidgets(
    'DetailBookmarkFooter disables taps while busy without inline error [assertion 2/2]',
    (
      tester,
    ) async {
      var tapCount = 0;
      await tester.pumpWidget(
        _FooterTestApp(
          child: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: true,
            bookmarkError: const StorageException(
              kind: StorageErrorKind.unknown,
            ),
            onToggleBookmark: () => tapCount += 1,
            onClearBookmarkError: _noop,
          ),
        ),
      );

      await tester.tap(
        find.byKey(const ValueKey<String>('detail-bookmark-button')),
      );

      Object.hashAll([tapCount, 0]);

      expect(find.text('ブックマークの更新に失敗しました'), findsNothing);
    },
  );

  runGoldenMatrix(
    fileNamePrefix: 'detail_bookmark_footer',
    description: 'DetailBookmarkFooter follows Detail Spec footer CSS',
    builder: (theme, size, textScaler) {
      return MaterialApp(
        theme: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final colors = Theme.of(
                context,
              ).extension<DetailColorExtension>()!;
              return ColoredBox(
                color: colors.surface,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 390,
                      child: DetailBookmarkFooter(
                        isBookmarked: false,
                        isBusy: false,
                        bookmarkError: null,
                        onToggleBookmark: _noop,
                        onClearBookmarkError: _noop,
                      ),
                    ),
                    SizedBox(
                      width: 390,
                      child: DetailBookmarkFooter(
                        isBookmarked: true,
                        isBusy: false,
                        bookmarkError: null,
                        onToggleBookmark: _noop,
                        onClearBookmarkError: _noop,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

class _FooterTestApp extends StatelessWidget {
  const _FooterTestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }
}

void _noop() {}
