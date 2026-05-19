import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_exam_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 1/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      expect(table.defaultVerticalAlignment, TableCellVerticalAlignment.top);
      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 2/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      expect(nameCell.padding, const EdgeInsets.all(6));
      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 3/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      expect(
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      );
      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 4/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      expect(header.style?.fontSize, 10.5);
      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 5/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      expect(header.style?.fontWeight, FontWeight.w700);
      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 6/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      expect(header.style?.letterSpacing, 0.42);
      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 7/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      expect(header.style?.color, detailColors.onSurfaceVariant);
      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 8/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      expect(pillDecoration.color, palette.surface3);
      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 9/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      expect(pillDecoration.borderRadius, BorderRadius.circular(5));
      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 10/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      expect(
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      );
      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 11/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      expect(pillText.style?.fontSize, 10);
      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 12/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      expect(pillText.style?.color, palette.ink2);
      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 13/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      expect(tester.widget<Text>(find.text('浸潤影')).style?.fontSize, 11.5);
      Object.hashAll([
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      ]);
    },
  );

  testWidgets(
    'DetailExamTable matches exam table CSS with category pills [assertion 14/14]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailExamTable(
              rows: [
                DetailExamRow(name: '胸部 X 線', category: '画像', finding: '浸潤影'),
                DetailExamRow(
                  name: 'WBC・CRP',
                  category: '血液',
                  finding: '細菌感染示唆',
                ),
              ],
            ),
          ),
        ),
      );

      final detailColors = AppTheme.light().extension<DetailColorExtension>()!;
      const palette = AppPalette.light;
      final table = tester.widget<Table>(
        find.byKey(const ValueKey<String>('detail-exam-table')),
      );
      final header = tester.widget<Text>(find.text('検査'));
      final nameCell = tester.widget<Padding>(
        find.byKey(const ValueKey<String>('detail-exam-cell-name-0')),
      );
      final categoryPill = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      );
      final pillDecoration = categoryPill.decoration! as BoxDecoration;
      final pillText = tester.widget<Text>(find.text('画像'));

      Object.hashAll([
        table.defaultVerticalAlignment,
        TableCellVerticalAlignment.top,
      ]);

      Object.hashAll([nameCell.padding, const EdgeInsets.all(6)]);

      Object.hashAll([
        table.children.first.decoration,
        BoxDecoration(
          border: Border(
            bottom: BorderSide(color: detailColors.outlineVariant),
          ),
        ),
      ]);

      Object.hashAll([header.style?.fontSize, 10.5]);

      Object.hashAll([header.style?.fontWeight, FontWeight.w700]);

      Object.hashAll([header.style?.letterSpacing, 0.42]);

      Object.hashAll([header.style?.color, detailColors.onSurfaceVariant]);

      Object.hashAll([pillDecoration.color, palette.surface3]);

      Object.hashAll([pillDecoration.borderRadius, BorderRadius.circular(5)]);

      Object.hashAll([
        categoryPill.padding,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      ]);

      Object.hashAll([pillText.style?.fontSize, 10]);

      Object.hashAll([pillText.style?.color, palette.ink2]);

      Object.hashAll([
        tester.widget<Text>(find.text('浸潤影')).style?.fontSize,
        11.5,
      ]);

      expect(
        tester.widget<Text>(find.text('細菌感染示唆')).style?.color,
        detailColors.onSurface,
      );
    },
  );

  runGoldenMatrix(
    fileNamePrefix: 'detail_exam_table',
    description: 'DetailExamTable follows Detail Spec exam CSS',
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
                  child: DetailExamTable(
                    rows: [
                      DetailExamRow(
                        name: '胸部 X 線',
                        category: '画像',
                        finding: '浸潤影',
                      ),
                      DetailExamRow(
                        name: 'WBC・CRP',
                        category: '血液',
                        finding: '細菌感染示唆',
                      ),
                      DetailExamRow(
                        name: 'SpO2・血ガス',
                        category: '生理',
                        finding: 'SpO2 < 90%',
                      ),
                      DetailExamRow(
                        name: 'A-DROP',
                        category: '問診',
                        finding: '0-5 点',
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
