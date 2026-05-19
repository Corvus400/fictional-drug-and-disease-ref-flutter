import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets(
    'DetailAccordion matches closed accordion tokens [assertion 1/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '禁忌',
              child: Text('重篤な過敏症の既往がある患者'),
            ),
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final title = tester.widget<Text>(find.text('禁忌'));

      expect(decoration.color, colors.surfaceContainerLow);
      Object.hashAll([
        decoration.border,
        Border.all(color: colors.outlineVariant),
      ]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

      Object.hashAll([find.text('重篤な過敏症の既往がある患者'), findsNothing]);

      Object.hashAll([title.style?.fontSize, 13]);

      Object.hashAll([title.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([title.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailAccordion matches closed accordion tokens [assertion 2/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '禁忌',
              child: Text('重篤な過敏症の既往がある患者'),
            ),
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final title = tester.widget<Text>(find.text('禁忌'));

      Object.hashAll([decoration.color, colors.surfaceContainerLow]);

      expect(decoration.border, Border.all(color: colors.outlineVariant));
      Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

      Object.hashAll([find.text('重篤な過敏症の既往がある患者'), findsNothing]);

      Object.hashAll([title.style?.fontSize, 13]);

      Object.hashAll([title.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([title.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailAccordion matches closed accordion tokens [assertion 3/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '禁忌',
              child: Text('重篤な過敏症の既往がある患者'),
            ),
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final title = tester.widget<Text>(find.text('禁忌'));

      Object.hashAll([decoration.color, colors.surfaceContainerLow]);

      Object.hashAll([
        decoration.border,
        Border.all(color: colors.outlineVariant),
      ]);

      expect(decoration.borderRadius, BorderRadius.circular(10));
      Object.hashAll([find.text('重篤な過敏症の既往がある患者'), findsNothing]);

      Object.hashAll([title.style?.fontSize, 13]);

      Object.hashAll([title.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([title.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailAccordion matches closed accordion tokens [assertion 4/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '禁忌',
              child: Text('重篤な過敏症の既往がある患者'),
            ),
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final title = tester.widget<Text>(find.text('禁忌'));

      Object.hashAll([decoration.color, colors.surfaceContainerLow]);

      Object.hashAll([
        decoration.border,
        Border.all(color: colors.outlineVariant),
      ]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

      expect(find.text('重篤な過敏症の既往がある患者'), findsNothing);
      Object.hashAll([title.style?.fontSize, 13]);

      Object.hashAll([title.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([title.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailAccordion matches closed accordion tokens [assertion 5/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '禁忌',
              child: Text('重篤な過敏症の既往がある患者'),
            ),
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final title = tester.widget<Text>(find.text('禁忌'));

      Object.hashAll([decoration.color, colors.surfaceContainerLow]);

      Object.hashAll([
        decoration.border,
        Border.all(color: colors.outlineVariant),
      ]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

      Object.hashAll([find.text('重篤な過敏症の既往がある患者'), findsNothing]);

      expect(title.style?.fontSize, 13);
      Object.hashAll([title.style?.fontWeight, FontWeight.w600]);

      Object.hashAll([title.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailAccordion matches closed accordion tokens [assertion 6/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '禁忌',
              child: Text('重篤な過敏症の既往がある患者'),
            ),
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final title = tester.widget<Text>(find.text('禁忌'));

      Object.hashAll([decoration.color, colors.surfaceContainerLow]);

      Object.hashAll([
        decoration.border,
        Border.all(color: colors.outlineVariant),
      ]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

      Object.hashAll([find.text('重篤な過敏症の既往がある患者'), findsNothing]);

      Object.hashAll([title.style?.fontSize, 13]);

      expect(title.style?.fontWeight, FontWeight.w600);
      Object.hashAll([title.style?.color, colors.onSurface]);
    },
  );

  testWidgets(
    'DetailAccordion matches closed accordion tokens [assertion 7/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '禁忌',
              child: Text('重篤な過敏症の既往がある患者'),
            ),
          ),
        ),
      );

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final title = tester.widget<Text>(find.text('禁忌'));

      Object.hashAll([decoration.color, colors.surfaceContainerLow]);

      Object.hashAll([
        decoration.border,
        Border.all(color: colors.outlineVariant),
      ]);

      Object.hashAll([decoration.borderRadius, BorderRadius.circular(10)]);

      Object.hashAll([find.text('重篤な過敏症の既往がある患者'), findsNothing]);

      Object.hashAll([title.style?.fontSize, 13]);

      Object.hashAll([title.style?.fontWeight, FontWeight.w600]);

      expect(title.style?.color, colors.onSurface);
    },
  );

  testWidgets(
    'DetailAccordion expands body and rotates chevron [assertion 1/6]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '重大な副作用',
              child: Text('肝機能障害を観察する'),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey<String>('detail-accordion')));
      await tester.pumpAndSettle();

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final body = tester.widget<DefaultTextStyle>(
        find.byKey(const ValueKey<String>('detail-accordion-body-text-style')),
      );
      final rotation = tester.widget<AnimatedRotation>(
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
      );

      expect(decoration.color, colors.surfaceContainer);
      Object.hashAll([find.text('肝機能障害を観察する'), findsOneWidget]);

      Object.hashAll([body.style.fontSize, 12.5]);

      Object.hashAll([body.style.color, colors.onSurface]);

      Object.hashAll([body.style.height, 1.6]);

      Object.hashAll([rotation.turns, 0.5]);
    },
  );

  testWidgets(
    'DetailAccordion expands body and rotates chevron [assertion 2/6]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '重大な副作用',
              child: Text('肝機能障害を観察する'),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey<String>('detail-accordion')));
      await tester.pumpAndSettle();

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final body = tester.widget<DefaultTextStyle>(
        find.byKey(const ValueKey<String>('detail-accordion-body-text-style')),
      );
      final rotation = tester.widget<AnimatedRotation>(
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
      );

      Object.hashAll([decoration.color, colors.surfaceContainer]);

      expect(find.text('肝機能障害を観察する'), findsOneWidget);
      Object.hashAll([body.style.fontSize, 12.5]);

      Object.hashAll([body.style.color, colors.onSurface]);

      Object.hashAll([body.style.height, 1.6]);

      Object.hashAll([rotation.turns, 0.5]);
    },
  );

  testWidgets(
    'DetailAccordion expands body and rotates chevron [assertion 3/6]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '重大な副作用',
              child: Text('肝機能障害を観察する'),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey<String>('detail-accordion')));
      await tester.pumpAndSettle();

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final body = tester.widget<DefaultTextStyle>(
        find.byKey(const ValueKey<String>('detail-accordion-body-text-style')),
      );
      final rotation = tester.widget<AnimatedRotation>(
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
      );

      Object.hashAll([decoration.color, colors.surfaceContainer]);

      Object.hashAll([find.text('肝機能障害を観察する'), findsOneWidget]);

      expect(body.style.fontSize, 12.5);
      Object.hashAll([body.style.color, colors.onSurface]);

      Object.hashAll([body.style.height, 1.6]);

      Object.hashAll([rotation.turns, 0.5]);
    },
  );

  testWidgets(
    'DetailAccordion expands body and rotates chevron [assertion 4/6]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '重大な副作用',
              child: Text('肝機能障害を観察する'),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey<String>('detail-accordion')));
      await tester.pumpAndSettle();

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final body = tester.widget<DefaultTextStyle>(
        find.byKey(const ValueKey<String>('detail-accordion-body-text-style')),
      );
      final rotation = tester.widget<AnimatedRotation>(
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
      );

      Object.hashAll([decoration.color, colors.surfaceContainer]);

      Object.hashAll([find.text('肝機能障害を観察する'), findsOneWidget]);

      Object.hashAll([body.style.fontSize, 12.5]);

      expect(body.style.color, colors.onSurface);
      Object.hashAll([body.style.height, 1.6]);

      Object.hashAll([rotation.turns, 0.5]);
    },
  );

  testWidgets(
    'DetailAccordion expands body and rotates chevron [assertion 5/6]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '重大な副作用',
              child: Text('肝機能障害を観察する'),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey<String>('detail-accordion')));
      await tester.pumpAndSettle();

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final body = tester.widget<DefaultTextStyle>(
        find.byKey(const ValueKey<String>('detail-accordion-body-text-style')),
      );
      final rotation = tester.widget<AnimatedRotation>(
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
      );

      Object.hashAll([decoration.color, colors.surfaceContainer]);

      Object.hashAll([find.text('肝機能障害を観察する'), findsOneWidget]);

      Object.hashAll([body.style.fontSize, 12.5]);

      Object.hashAll([body.style.color, colors.onSurface]);

      expect(body.style.height, 1.6);
      Object.hashAll([rotation.turns, 0.5]);
    },
  );

  testWidgets(
    'DetailAccordion expands body and rotates chevron [assertion 6/6]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '重大な副作用',
              child: Text('肝機能障害を観察する'),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey<String>('detail-accordion')));
      await tester.pumpAndSettle();

      final colors = AppTheme.light().extension<DetailColorExtension>()!;
      final accordion = tester.widget<Container>(
        find.byKey(const ValueKey<String>('detail-accordion')),
      );
      final decoration = accordion.decoration! as BoxDecoration;
      final body = tester.widget<DefaultTextStyle>(
        find.byKey(const ValueKey<String>('detail-accordion-body-text-style')),
      );
      final rotation = tester.widget<AnimatedRotation>(
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
      );

      Object.hashAll([decoration.color, colors.surfaceContainer]);

      Object.hashAll([find.text('肝機能障害を観察する'), findsOneWidget]);

      Object.hashAll([body.style.fontSize, 12.5]);

      Object.hashAll([body.style.color, colors.onSurface]);

      Object.hashAll([body.style.height, 1.6]);

      expect(rotation.turns, 0.5);
    },
  );

  testWidgets(
    'DetailAccordion shows disabled status without expanding [assertion 1/3]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '妊婦',
              statusLabel: '該当なし',
              enabled: false,
              child: Text('表示しない'),
            ),
          ),
        ),
      );

      expect(find.text('該当なし'), findsOneWidget);
      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsNothing,
      ]);

      await tester.tap(find.byKey(const ValueKey<String>('detail-accordion')));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('表示しない'), findsNothing]);
    },
  );

  testWidgets(
    'DetailAccordion shows disabled status without expanding [assertion 2/3]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '妊婦',
              statusLabel: '該当なし',
              enabled: false,
              child: Text('表示しない'),
            ),
          ),
        ),
      );

      Object.hashAll([find.text('該当なし'), findsOneWidget]);

      expect(
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsNothing,
      );

      await tester.tap(find.byKey(const ValueKey<String>('detail-accordion')));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('表示しない'), findsNothing]);
    },
  );

  testWidgets(
    'DetailAccordion shows disabled status without expanding [assertion 3/3]',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailAccordion(
              title: '妊婦',
              statusLabel: '該当なし',
              enabled: false,
              child: Text('表示しない'),
            ),
          ),
        ),
      );

      Object.hashAll([find.text('該当なし'), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('detail-accordion-chevron')),
        findsNothing,
      ]);

      await tester.tap(find.byKey(const ValueKey<String>('detail-accordion')));
      await tester.pumpAndSettle();

      expect(find.text('表示しない'), findsNothing);
    },
  );

  runGoldenMatrix(
    fileNamePrefix: 'detail_accordion',
    description: 'DetailAccordion follows Detail Spec acc CSS',
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DetailAccordion(
                        title: '禁忌',
                        child: Text('重篤な過敏症の既往がある患者'),
                      ),
                      SizedBox(height: 8),
                      DetailAccordion(
                        title: '重大な副作用',
                        initiallyExpanded: true,
                        child: Text('肝機能障害を観察する'),
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
