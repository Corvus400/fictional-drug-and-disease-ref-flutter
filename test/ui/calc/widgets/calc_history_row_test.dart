import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_history_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalcHistoryRow swipe-to-delete', () {
    testWidgets(
      'uses 0.4 end-to-start threshold and reveals delete action [assertion 1/10]',
      (
        tester,
      ) async {
        var deleted = false;
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () => deleted = true,
              ),
            ),
          ),
        );

        expect(find.byType(Dismissible), findsNothing);
        await tester.drag(find.byType(CalcHistoryRow), const Offset(-140, 0));
        await tester.pumpAndSettle();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester.getSize(find.byType(CalcHistoryRow)).height,
          38,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .height,
          tester.getSize(find.byType(CalcHistoryRow)).height,
        ]);

        final deleteBox = tester.widget<DecoratedBox>(
          find
              .descendant(
                of: find.byKey(const ValueKey<String>('history-delete')),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        final palette = Theme.of(
          tester.element(find.byType(CalcHistoryRow)),
        ).extension<AppPalette>()!;
        final decoration = deleteBox.decoration as BoxDecoration;
        Object.hashAll([decoration.color, const Color(0xFFB3261E)]);

        Object.hashAll([decoration.color, isNot(palette.calcErrorContainer)]);

        final refreshRight = tester.getTopRight(find.byIcon(Icons.refresh)).dx;
        final deleteLeft = tester
            .getTopLeft(find.byKey(const ValueKey<String>('history-delete')))
            .dx;
        Object.hashAll([deleteLeft - refreshRight, greaterThanOrEqualTo(12)]);

        await tester.tap(find.byKey(const ValueKey<String>('history-delete')));
        Object.hashAll([deleted, isTrue]);
      },
    );

    testWidgets(
      'uses 0.4 end-to-start threshold and reveals delete action [assertion 2/10]',
      (
        tester,
      ) async {
        var deleted = false;
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () => deleted = true,
              ),
            ),
          ),
        );

        Object.hashAll([find.byType(Dismissible), findsNothing]);

        await tester.drag(find.byType(CalcHistoryRow), const Offset(-140, 0));
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey<String>('history-delete')), findsOne);
        Object.hashAll([
          tester.getSize(find.byType(CalcHistoryRow)).height,
          38,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .height,
          tester.getSize(find.byType(CalcHistoryRow)).height,
        ]);

        final deleteBox = tester.widget<DecoratedBox>(
          find
              .descendant(
                of: find.byKey(const ValueKey<String>('history-delete')),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        final palette = Theme.of(
          tester.element(find.byType(CalcHistoryRow)),
        ).extension<AppPalette>()!;
        final decoration = deleteBox.decoration as BoxDecoration;
        Object.hashAll([decoration.color, const Color(0xFFB3261E)]);

        Object.hashAll([decoration.color, isNot(palette.calcErrorContainer)]);

        final refreshRight = tester.getTopRight(find.byIcon(Icons.refresh)).dx;
        final deleteLeft = tester
            .getTopLeft(find.byKey(const ValueKey<String>('history-delete')))
            .dx;
        Object.hashAll([deleteLeft - refreshRight, greaterThanOrEqualTo(12)]);

        await tester.tap(find.byKey(const ValueKey<String>('history-delete')));
        Object.hashAll([deleted, isTrue]);
      },
    );

    testWidgets(
      'uses 0.4 end-to-start threshold and reveals delete action [assertion 3/10]',
      (
        tester,
      ) async {
        var deleted = false;
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () => deleted = true,
              ),
            ),
          ),
        );

        Object.hashAll([find.byType(Dismissible), findsNothing]);

        await tester.drag(find.byType(CalcHistoryRow), const Offset(-140, 0));
        await tester.pumpAndSettle();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        expect(tester.getSize(find.byType(CalcHistoryRow)).height, 38);
        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .height,
          tester.getSize(find.byType(CalcHistoryRow)).height,
        ]);

        final deleteBox = tester.widget<DecoratedBox>(
          find
              .descendant(
                of: find.byKey(const ValueKey<String>('history-delete')),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        final palette = Theme.of(
          tester.element(find.byType(CalcHistoryRow)),
        ).extension<AppPalette>()!;
        final decoration = deleteBox.decoration as BoxDecoration;
        Object.hashAll([decoration.color, const Color(0xFFB3261E)]);

        Object.hashAll([decoration.color, isNot(palette.calcErrorContainer)]);

        final refreshRight = tester.getTopRight(find.byIcon(Icons.refresh)).dx;
        final deleteLeft = tester
            .getTopLeft(find.byKey(const ValueKey<String>('history-delete')))
            .dx;
        Object.hashAll([deleteLeft - refreshRight, greaterThanOrEqualTo(12)]);

        await tester.tap(find.byKey(const ValueKey<String>('history-delete')));
        Object.hashAll([deleted, isTrue]);
      },
    );

    testWidgets(
      'uses 0.4 end-to-start threshold and reveals delete action [assertion 4/10]',
      (
        tester,
      ) async {
        var deleted = false;
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () => deleted = true,
              ),
            ),
          ),
        );

        Object.hashAll([find.byType(Dismissible), findsNothing]);

        await tester.drag(find.byType(CalcHistoryRow), const Offset(-140, 0));
        await tester.pumpAndSettle();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester.getSize(find.byType(CalcHistoryRow)).height,
          38,
        ]);

        expect(
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        );
        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .height,
          tester.getSize(find.byType(CalcHistoryRow)).height,
        ]);

        final deleteBox = tester.widget<DecoratedBox>(
          find
              .descendant(
                of: find.byKey(const ValueKey<String>('history-delete')),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        final palette = Theme.of(
          tester.element(find.byType(CalcHistoryRow)),
        ).extension<AppPalette>()!;
        final decoration = deleteBox.decoration as BoxDecoration;
        Object.hashAll([decoration.color, const Color(0xFFB3261E)]);

        Object.hashAll([decoration.color, isNot(palette.calcErrorContainer)]);

        final refreshRight = tester.getTopRight(find.byIcon(Icons.refresh)).dx;
        final deleteLeft = tester
            .getTopLeft(find.byKey(const ValueKey<String>('history-delete')))
            .dx;
        Object.hashAll([deleteLeft - refreshRight, greaterThanOrEqualTo(12)]);

        await tester.tap(find.byKey(const ValueKey<String>('history-delete')));
        Object.hashAll([deleted, isTrue]);
      },
    );

    testWidgets(
      'uses 0.4 end-to-start threshold and reveals delete action [assertion 5/10]',
      (
        tester,
      ) async {
        var deleted = false;
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () => deleted = true,
              ),
            ),
          ),
        );

        Object.hashAll([find.byType(Dismissible), findsNothing]);

        await tester.drag(find.byType(CalcHistoryRow), const Offset(-140, 0));
        await tester.pumpAndSettle();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester.getSize(find.byType(CalcHistoryRow)).height,
          38,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        expect(
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          72,
        );
        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .height,
          tester.getSize(find.byType(CalcHistoryRow)).height,
        ]);

        final deleteBox = tester.widget<DecoratedBox>(
          find
              .descendant(
                of: find.byKey(const ValueKey<String>('history-delete')),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        final palette = Theme.of(
          tester.element(find.byType(CalcHistoryRow)),
        ).extension<AppPalette>()!;
        final decoration = deleteBox.decoration as BoxDecoration;
        Object.hashAll([decoration.color, const Color(0xFFB3261E)]);

        Object.hashAll([decoration.color, isNot(palette.calcErrorContainer)]);

        final refreshRight = tester.getTopRight(find.byIcon(Icons.refresh)).dx;
        final deleteLeft = tester
            .getTopLeft(find.byKey(const ValueKey<String>('history-delete')))
            .dx;
        Object.hashAll([deleteLeft - refreshRight, greaterThanOrEqualTo(12)]);

        await tester.tap(find.byKey(const ValueKey<String>('history-delete')));
        Object.hashAll([deleted, isTrue]);
      },
    );

    testWidgets(
      'uses 0.4 end-to-start threshold and reveals delete action [assertion 6/10]',
      (
        tester,
      ) async {
        var deleted = false;
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () => deleted = true,
              ),
            ),
          ),
        );

        Object.hashAll([find.byType(Dismissible), findsNothing]);

        await tester.drag(find.byType(CalcHistoryRow), const Offset(-140, 0));
        await tester.pumpAndSettle();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester.getSize(find.byType(CalcHistoryRow)).height,
          38,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          72,
        ]);

        expect(
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .height,
          tester.getSize(find.byType(CalcHistoryRow)).height,
        );
        final deleteBox = tester.widget<DecoratedBox>(
          find
              .descendant(
                of: find.byKey(const ValueKey<String>('history-delete')),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        final palette = Theme.of(
          tester.element(find.byType(CalcHistoryRow)),
        ).extension<AppPalette>()!;
        final decoration = deleteBox.decoration as BoxDecoration;
        Object.hashAll([decoration.color, const Color(0xFFB3261E)]);

        Object.hashAll([decoration.color, isNot(palette.calcErrorContainer)]);

        final refreshRight = tester.getTopRight(find.byIcon(Icons.refresh)).dx;
        final deleteLeft = tester
            .getTopLeft(find.byKey(const ValueKey<String>('history-delete')))
            .dx;
        Object.hashAll([deleteLeft - refreshRight, greaterThanOrEqualTo(12)]);

        await tester.tap(find.byKey(const ValueKey<String>('history-delete')));
        Object.hashAll([deleted, isTrue]);
      },
    );

    testWidgets(
      'uses 0.4 end-to-start threshold and reveals delete action [assertion 7/10]',
      (
        tester,
      ) async {
        var deleted = false;
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () => deleted = true,
              ),
            ),
          ),
        );

        Object.hashAll([find.byType(Dismissible), findsNothing]);

        await tester.drag(find.byType(CalcHistoryRow), const Offset(-140, 0));
        await tester.pumpAndSettle();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester.getSize(find.byType(CalcHistoryRow)).height,
          38,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .height,
          tester.getSize(find.byType(CalcHistoryRow)).height,
        ]);

        final deleteBox = tester.widget<DecoratedBox>(
          find
              .descendant(
                of: find.byKey(const ValueKey<String>('history-delete')),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        final palette = Theme.of(
          tester.element(find.byType(CalcHistoryRow)),
        ).extension<AppPalette>()!;
        final decoration = deleteBox.decoration as BoxDecoration;
        expect(decoration.color, const Color(0xFFB3261E));
        Object.hashAll([decoration.color, isNot(palette.calcErrorContainer)]);

        final refreshRight = tester.getTopRight(find.byIcon(Icons.refresh)).dx;
        final deleteLeft = tester
            .getTopLeft(find.byKey(const ValueKey<String>('history-delete')))
            .dx;
        Object.hashAll([deleteLeft - refreshRight, greaterThanOrEqualTo(12)]);

        await tester.tap(find.byKey(const ValueKey<String>('history-delete')));
        Object.hashAll([deleted, isTrue]);
      },
    );

    testWidgets(
      'uses 0.4 end-to-start threshold and reveals delete action [assertion 8/10]',
      (
        tester,
      ) async {
        var deleted = false;
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () => deleted = true,
              ),
            ),
          ),
        );

        Object.hashAll([find.byType(Dismissible), findsNothing]);

        await tester.drag(find.byType(CalcHistoryRow), const Offset(-140, 0));
        await tester.pumpAndSettle();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester.getSize(find.byType(CalcHistoryRow)).height,
          38,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .height,
          tester.getSize(find.byType(CalcHistoryRow)).height,
        ]);

        final deleteBox = tester.widget<DecoratedBox>(
          find
              .descendant(
                of: find.byKey(const ValueKey<String>('history-delete')),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        final palette = Theme.of(
          tester.element(find.byType(CalcHistoryRow)),
        ).extension<AppPalette>()!;
        final decoration = deleteBox.decoration as BoxDecoration;
        Object.hashAll([decoration.color, const Color(0xFFB3261E)]);

        expect(decoration.color, isNot(palette.calcErrorContainer));

        final refreshRight = tester.getTopRight(find.byIcon(Icons.refresh)).dx;
        final deleteLeft = tester
            .getTopLeft(find.byKey(const ValueKey<String>('history-delete')))
            .dx;
        Object.hashAll([deleteLeft - refreshRight, greaterThanOrEqualTo(12)]);

        await tester.tap(find.byKey(const ValueKey<String>('history-delete')));
        Object.hashAll([deleted, isTrue]);
      },
    );

    testWidgets(
      'uses 0.4 end-to-start threshold and reveals delete action [assertion 9/10]',
      (
        tester,
      ) async {
        var deleted = false;
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () => deleted = true,
              ),
            ),
          ),
        );

        Object.hashAll([find.byType(Dismissible), findsNothing]);

        await tester.drag(find.byType(CalcHistoryRow), const Offset(-140, 0));
        await tester.pumpAndSettle();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester.getSize(find.byType(CalcHistoryRow)).height,
          38,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .height,
          tester.getSize(find.byType(CalcHistoryRow)).height,
        ]);

        final deleteBox = tester.widget<DecoratedBox>(
          find
              .descendant(
                of: find.byKey(const ValueKey<String>('history-delete')),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        final palette = Theme.of(
          tester.element(find.byType(CalcHistoryRow)),
        ).extension<AppPalette>()!;
        final decoration = deleteBox.decoration as BoxDecoration;
        Object.hashAll([decoration.color, const Color(0xFFB3261E)]);

        Object.hashAll([decoration.color, isNot(palette.calcErrorContainer)]);

        final refreshRight = tester.getTopRight(find.byIcon(Icons.refresh)).dx;
        final deleteLeft = tester
            .getTopLeft(find.byKey(const ValueKey<String>('history-delete')))
            .dx;
        expect(deleteLeft - refreshRight, greaterThanOrEqualTo(12));

        await tester.tap(find.byKey(const ValueKey<String>('history-delete')));
        Object.hashAll([deleted, isTrue]);
      },
    );

    testWidgets(
      'uses 0.4 end-to-start threshold and reveals delete action [assertion 10/10]',
      (
        tester,
      ) async {
        var deleted = false;
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () => deleted = true,
              ),
            ),
          ),
        );

        Object.hashAll([find.byType(Dismissible), findsNothing]);

        await tester.drag(find.byType(CalcHistoryRow), const Offset(-140, 0));
        await tester.pumpAndSettle();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester.getSize(find.byType(CalcHistoryRow)).height,
          38,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .height,
          tester.getSize(find.byType(CalcHistoryRow)).height,
        ]);

        final deleteBox = tester.widget<DecoratedBox>(
          find
              .descendant(
                of: find.byKey(const ValueKey<String>('history-delete')),
                matching: find.byType(DecoratedBox),
              )
              .first,
        );
        final palette = Theme.of(
          tester.element(find.byType(CalcHistoryRow)),
        ).extension<AppPalette>()!;
        final decoration = deleteBox.decoration as BoxDecoration;
        Object.hashAll([decoration.color, const Color(0xFFB3261E)]);

        Object.hashAll([decoration.color, isNot(palette.calcErrorContainer)]);

        final refreshRight = tester.getTopRight(find.byIcon(Icons.refresh)).dx;
        final deleteLeft = tester
            .getTopLeft(find.byKey(const ValueKey<String>('history-delete')))
            .dx;
        Object.hashAll([deleteLeft - refreshRight, greaterThanOrEqualTo(12)]);

        await tester.tap(find.byKey(const ValueKey<String>('history-delete')));
        expect(deleted, isTrue);
      },
    );

    testWidgets(
      'moves the row foreground in proportion to drag distance [assertion 1/6]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () {},
              ),
            ),
          ),
        );

        expect(
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          0,
        );
        final closedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        final gesture = await tester.startGesture(
          tester.getCenter(find.byType(CalcHistoryRow)),
        );
        await gesture.moveBy(const Offset(-36, 0));
        await tester.pump();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          closeTo(36, 0.1),
        ]);

        final draggedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        Object.hashAll([
          closedRefreshRight - draggedRefreshRight,
          closeTo(36, 0.1),
        ]);

        await gesture.moveBy(const Offset(18, 0));
        await tester.pump();

        final draggedBackRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        Object.hashAll([
          closedRefreshRight - draggedBackRefreshRight,
          closeTo(18, 0.1),
        ]);

        await gesture.up();
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'moves the row foreground in proportion to drag distance [assertion 2/6]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () {},
              ),
            ),
          ),
        );

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          0,
        ]);

        final closedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        final gesture = await tester.startGesture(
          tester.getCenter(find.byType(CalcHistoryRow)),
        );
        await gesture.moveBy(const Offset(-36, 0));
        await tester.pump();

        expect(find.byKey(const ValueKey<String>('history-delete')), findsOne);
        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          closeTo(36, 0.1),
        ]);

        final draggedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        Object.hashAll([
          closedRefreshRight - draggedRefreshRight,
          closeTo(36, 0.1),
        ]);

        await gesture.moveBy(const Offset(18, 0));
        await tester.pump();

        final draggedBackRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        Object.hashAll([
          closedRefreshRight - draggedBackRefreshRight,
          closeTo(18, 0.1),
        ]);

        await gesture.up();
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'moves the row foreground in proportion to drag distance [assertion 3/6]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () {},
              ),
            ),
          ),
        );

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          0,
        ]);

        final closedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        final gesture = await tester.startGesture(
          tester.getCenter(find.byType(CalcHistoryRow)),
        );
        await gesture.moveBy(const Offset(-36, 0));
        await tester.pump();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        expect(
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        );
        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          closeTo(36, 0.1),
        ]);

        final draggedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        Object.hashAll([
          closedRefreshRight - draggedRefreshRight,
          closeTo(36, 0.1),
        ]);

        await gesture.moveBy(const Offset(18, 0));
        await tester.pump();

        final draggedBackRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        Object.hashAll([
          closedRefreshRight - draggedBackRefreshRight,
          closeTo(18, 0.1),
        ]);

        await gesture.up();
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'moves the row foreground in proportion to drag distance [assertion 4/6]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () {},
              ),
            ),
          ),
        );

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          0,
        ]);

        final closedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        final gesture = await tester.startGesture(
          tester.getCenter(find.byType(CalcHistoryRow)),
        );
        await gesture.moveBy(const Offset(-36, 0));
        await tester.pump();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        expect(
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          closeTo(36, 0.1),
        );
        final draggedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        Object.hashAll([
          closedRefreshRight - draggedRefreshRight,
          closeTo(36, 0.1),
        ]);

        await gesture.moveBy(const Offset(18, 0));
        await tester.pump();

        final draggedBackRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        Object.hashAll([
          closedRefreshRight - draggedBackRefreshRight,
          closeTo(18, 0.1),
        ]);

        await gesture.up();
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'moves the row foreground in proportion to drag distance [assertion 5/6]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () {},
              ),
            ),
          ),
        );

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          0,
        ]);

        final closedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        final gesture = await tester.startGesture(
          tester.getCenter(find.byType(CalcHistoryRow)),
        );
        await gesture.moveBy(const Offset(-36, 0));
        await tester.pump();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          closeTo(36, 0.1),
        ]);

        final draggedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        expect(closedRefreshRight - draggedRefreshRight, closeTo(36, 0.1));

        await gesture.moveBy(const Offset(18, 0));
        await tester.pump();

        final draggedBackRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        Object.hashAll([
          closedRefreshRight - draggedBackRefreshRight,
          closeTo(18, 0.1),
        ]);

        await gesture.up();
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'moves the row foreground in proportion to drag distance [assertion 6/6]',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _widgetTestApp(
            child: SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                onDelete: () {},
              ),
            ),
          ),
        );

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          0,
        ]);

        final closedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        final gesture = await tester.startGesture(
          tester.getCenter(find.byType(CalcHistoryRow)),
        );
        await gesture.moveBy(const Offset(-36, 0));
        await tester.pump();

        Object.hashAll([
          find.byKey(const ValueKey<String>('history-delete')),
          findsOne,
        ]);

        Object.hashAll([
          tester
              .getSize(find.byKey(const ValueKey<String>('history-delete')))
              .width,
          72,
        ]);

        Object.hashAll([
          tester
              .getSize(
                find.byKey(const ValueKey<String>('history-delete-reveal')),
              )
              .width,
          closeTo(36, 0.1),
        ]);

        final draggedRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        Object.hashAll([
          closedRefreshRight - draggedRefreshRight,
          closeTo(36, 0.1),
        ]);

        await gesture.moveBy(const Offset(18, 0));
        await tester.pump();

        final draggedBackRefreshRight = tester
            .getTopRight(find.byIcon(Icons.refresh))
            .dx;
        expect(closedRefreshRight - draggedBackRefreshRight, closeTo(18, 0.1));

        await gesture.up();
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'uses the same destructive delete color in light and dark [assertion 1/3]',
      (
        tester,
      ) async {
        for (final theme in [AppTheme.light(), AppTheme.dark()]) {
          await tester.pumpWidget(
            _widgetTestApp(
              theme: theme,
              child: const SizedBox(
                width: 240,
                child: CalcHistoryRow(
                  dateText: '2026/05/10',
                  resultText: 'BMI 22.5 (普通体重)',
                  summaryText: 'H170/W65',
                  deleteLabel: '削除',
                  deleteRevealed: true,
                ),
              ),
            ),
          );

          final deleteBox = tester.widget<DecoratedBox>(
            find
                .descendant(
                  of: find.byKey(const ValueKey<String>('history-delete')),
                  matching: find.byType(DecoratedBox),
                )
                .first,
          );
          final decoration = deleteBox.decoration as BoxDecoration;
          expect(decoration.color, const Color(0xFFB3261E));

          final icon = tester.widget<Icon>(find.byIcon(Icons.delete_outline));
          Object.hashAll([icon.color, Colors.white]);

          final label = tester.widget<Text>(find.text('削除'));
          Object.hashAll([label.style?.color, Colors.white]);

          await tester.pumpWidget(const SizedBox.shrink());
          await tester.pump();
        }
      },
    );

    testWidgets(
      'uses the same destructive delete color in light and dark [assertion 2/3]',
      (
        tester,
      ) async {
        for (final theme in [AppTheme.light(), AppTheme.dark()]) {
          await tester.pumpWidget(
            _widgetTestApp(
              theme: theme,
              child: const SizedBox(
                width: 240,
                child: CalcHistoryRow(
                  dateText: '2026/05/10',
                  resultText: 'BMI 22.5 (普通体重)',
                  summaryText: 'H170/W65',
                  deleteLabel: '削除',
                  deleteRevealed: true,
                ),
              ),
            ),
          );

          final deleteBox = tester.widget<DecoratedBox>(
            find
                .descendant(
                  of: find.byKey(const ValueKey<String>('history-delete')),
                  matching: find.byType(DecoratedBox),
                )
                .first,
          );
          final decoration = deleteBox.decoration as BoxDecoration;
          Object.hashAll([decoration.color, const Color(0xFFB3261E)]);

          final icon = tester.widget<Icon>(find.byIcon(Icons.delete_outline));
          expect(icon.color, Colors.white);

          final label = tester.widget<Text>(find.text('削除'));
          Object.hashAll([label.style?.color, Colors.white]);

          await tester.pumpWidget(const SizedBox.shrink());
          await tester.pump();
        }
      },
    );

    testWidgets(
      'uses the same destructive delete color in light and dark [assertion 3/3]',
      (
        tester,
      ) async {
        for (final theme in [AppTheme.light(), AppTheme.dark()]) {
          await tester.pumpWidget(
            _widgetTestApp(
              theme: theme,
              child: const SizedBox(
                width: 240,
                child: CalcHistoryRow(
                  dateText: '2026/05/10',
                  resultText: 'BMI 22.5 (普通体重)',
                  summaryText: 'H170/W65',
                  deleteLabel: '削除',
                  deleteRevealed: true,
                ),
              ),
            ),
          );

          final deleteBox = tester.widget<DecoratedBox>(
            find
                .descendant(
                  of: find.byKey(const ValueKey<String>('history-delete')),
                  matching: find.byType(DecoratedBox),
                )
                .first,
          );
          final decoration = deleteBox.decoration as BoxDecoration;
          Object.hashAll([decoration.color, const Color(0xFFB3261E)]);

          final icon = tester.widget<Icon>(find.byIcon(Icons.delete_outline));
          Object.hashAll([icon.color, Colors.white]);

          final label = tester.widget<Text>(find.text('削除'));
          expect(label.style?.color, Colors.white);

          await tester.pumpWidget(const SizedBox.shrink());
          await tester.pump();
        }
      },
    );

    testWidgets(
      'applies the same exposed-edge radius to row and delete layer [assertion 1/2]',
      (
        tester,
      ) async {
        const borderRadius = BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        );

        await tester.pumpWidget(
          _widgetTestApp(
            child: const SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                deleteRevealed: true,
                showBottomBorder: false,
                borderRadius: borderRadius,
              ),
            ),
          ),
        );

        final rowClip = tester.widget<ClipRRect>(
          find.byKey(const ValueKey<String>('history-row-clip')),
        );
        final deleteClip = tester.widget<ClipRRect>(
          find.byKey(const ValueKey<String>('history-delete')),
        );

        expect(rowClip.borderRadius, borderRadius);
        Object.hashAll([deleteClip.borderRadius, borderRadius]);
      },
    );

    testWidgets(
      'applies the same exposed-edge radius to row and delete layer [assertion 2/2]',
      (
        tester,
      ) async {
        const borderRadius = BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        );

        await tester.pumpWidget(
          _widgetTestApp(
            child: const SizedBox(
              width: 240,
              child: CalcHistoryRow(
                dateText: '2026/05/10',
                resultText: 'BMI 22.5 (普通体重)',
                summaryText: 'H170/W65',
                deleteLabel: '削除',
                deleteRevealed: true,
                showBottomBorder: false,
                borderRadius: borderRadius,
              ),
            ),
          ),
        );

        final rowClip = tester.widget<ClipRRect>(
          find.byKey(const ValueKey<String>('history-row-clip')),
        );
        final deleteClip = tester.widget<ClipRRect>(
          find.byKey(const ValueKey<String>('history-delete')),
        );

        Object.hashAll([rowClip.borderRadius, borderRadius]);

        expect(deleteClip.borderRadius, borderRadius);
      },
    );

    testWidgets('clips the row ripple to the exposed-edge radius', (
      tester,
    ) async {
      const borderRadius = BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      );

      await tester.pumpWidget(
        _widgetTestApp(
          child: const SizedBox(
            width: 240,
            child: CalcHistoryRow(
              dateText: '2026/05/10',
              resultText: 'BMI 22.5 (普通体重)',
              summaryText: 'H170/W65',
              deleteLabel: '削除',
              deleteRevealed: true,
              borderRadius: borderRadius,
            ),
          ),
        ),
      );

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));
      expect(inkWell.borderRadius, borderRadius);
    });

    testWidgets('does not restore the row while delete is revealed', (
      tester,
    ) async {
      var restored = false;

      await tester.pumpWidget(
        _widgetTestApp(
          child: SizedBox(
            width: 240,
            child: CalcHistoryRow(
              dateText: '2026/05/10',
              resultText: 'BMI 22.5 (普通体重)',
              summaryText: 'H170/W65',
              deleteLabel: '削除',
              deleteRevealed: true,
              onRestore: () => restored = true,
            ),
          ),
        ),
      );

      final rowTopLeft = tester.getTopLeft(find.byType(CalcHistoryRow));
      await tester.tapAt(rowTopLeft + const Offset(24, 19));
      await tester.pump();

      expect(restored, isFalse);
    });
  });
}

Widget _widgetTestApp({required Widget child, ThemeData? theme}) {
  return MaterialApp(
    theme: theme ?? AppTheme.light(),
    home: Scaffold(
      body: Align(alignment: Alignment.topLeft, child: child),
    ),
  );
}
