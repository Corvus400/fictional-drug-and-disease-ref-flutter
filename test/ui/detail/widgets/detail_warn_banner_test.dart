import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_warn_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 1/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    expect(
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 2/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    expect(decoration.color, palette.dangerCont);
    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 3/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    expect(decoration.border, Border.all(color: palette.danger, width: 1.5));
    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 4/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    expect(decoration.borderRadius, BorderRadius.circular(10));
    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 5/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    expect(dot.constraints?.minWidth, 18);
    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 6/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    expect(dot.constraints?.minHeight, 18);
    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 7/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    expect(dotDecoration.color, palette.danger);
    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 8/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    expect(dotDecoration.borderRadius, BorderRadius.circular(9));
    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 9/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    expect(dot.margin, const EdgeInsets.only(top: 1));
    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 10/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    expect(dotText.style?.fontSize, 11);
    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 11/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    expect(dotText.style?.fontWeight, FontWeight.w700);
    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 12/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    expect(dotText.style?.color, palette.onPrimary);
    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 13/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    expect(prefix.style?.fontSize, 12.5);
    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 14/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    expect(prefix.style?.height, 1.55);
    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 15/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    expect(prefix.style?.color, palette.danger);
    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 16/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    expect(markdown.data, '妊婦には投与しないこと。');
    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 17/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    expect(markdown.fontSize, 12.5);
    Object.hashAll([markdown.height, 1.55]);

    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 18/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    expect(markdown.height, 1.55);
    Object.hashAll([markdown.color, palette.danger]);
  });

  testWidgets('DetailWarnBanner matches warning banner CSS [assertion 19/19]', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailWarnBanner(
            items: ['妊婦には投与しないこと。', '重大な副作用に注意すること。'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final banner = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner')),
    );
    final decoration = banner.decoration! as BoxDecoration;
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-warn-banner-dot')),
    );
    final dotDecoration = dot.decoration! as BoxDecoration;
    final dotText = tester.widget<Text>(find.text('!'));
    final prefix = tester.widget<Text>(find.text('1. '));
    final markdown = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody).first,
    );

    Object.hashAll([
      banner.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ]);

    Object.hashAll([decoration.color, palette.dangerCont]);

    Object.hashAll([
      decoration.border,
      Border.all(color: palette.danger, width: 1.5),
    ]);

    Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

    Object.hashAll([dot.constraints?.minWidth, 18]);

    Object.hashAll([dot.constraints?.minHeight, 18]);

    Object.hashAll([dotDecoration.color, palette.danger]);

    Object.hashAll([dotDecoration.borderRadius, BorderRadius.circular(9)]);

    Object.hashAll([dot.margin, const EdgeInsets.only(top: 1)]);

    Object.hashAll([dotText.style?.fontSize, 11]);

    Object.hashAll([dotText.style?.fontWeight, FontWeight.w700]);

    Object.hashAll([dotText.style?.color, palette.onPrimary]);

    Object.hashAll([prefix.style?.fontSize, 12.5]);

    Object.hashAll([prefix.style?.height, 1.55]);

    Object.hashAll([prefix.style?.color, palette.danger]);

    Object.hashAll([markdown.data, '妊婦には投与しないこと。']);

    Object.hashAll([markdown.fontSize, 12.5]);

    Object.hashAll([markdown.height, 1.55]);

    expect(markdown.color, palette.danger);
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_warn_banner',
    description: 'DetailWarnBanner follows Detail Spec warn-banner CSS',
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
                  child: DetailWarnBanner(
                    items: [
                      '妊婦には投与しないこと。',
                      '重大な副作用に注意すること。',
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
