import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailAccordion matches closed accordion tokens', (
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
    expect(decoration.border, Border.all(color: colors.outlineVariant));
    expect(decoration.borderRadius, BorderRadius.circular(10));
    expect(find.text('重篤な過敏症の既往がある患者'), findsNothing);
    expect(title.style?.fontSize, 13);
    expect(title.style?.fontWeight, FontWeight.w600);
    expect(title.style?.color, colors.onSurface);
  });

  testWidgets('DetailAccordion expands body and rotates chevron', (
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
    expect(find.text('肝機能障害を観察する'), findsOneWidget);
    expect(body.style.fontSize, 12.5);
    expect(body.style.color, colors.onSurface);
    expect(body.style.height, 1.6);
    expect(rotation.turns, 0.5);
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_accordion',
    description: 'DetailAccordion follows Detail Spec acc CSS',
    sizes: const ['phone'],
    textScalers: const ['normal'],
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
