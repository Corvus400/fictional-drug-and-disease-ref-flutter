import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_expand_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailExpandTile matches ref-row summary and divider CSS', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailExpandTile(
            title: '主要文献 1',
            body: '架空文献 A, 2026.',
          ),
        ),
      ),
    );

    final colors = AppTheme.light().extension<DetailColorExtension>()!;
    final row = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-expand-tile')),
    );
    final decoration = row.decoration! as BoxDecoration;
    final summary = tester.widget<Padding>(
      find.byKey(const ValueKey<String>('detail-expand-tile-summary')),
    );
    final title = tester.widget<Text>(find.text('主要文献 1'));

    expect(
      decoration.border,
      Border(bottom: BorderSide(color: colors.outlineVariant)),
    );
    expect(summary.padding, const EdgeInsets.symmetric(vertical: 10));
    expect(title.style?.fontSize, 12);
    expect(title.style?.color, colors.onSurface);
    expect(find.text('架空文献 A, 2026.'), findsNothing);
    expect(find.byType(ExpansionTile), findsOneWidget);
  });

  testWidgets('DetailExpandTile expands plain text body', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailExpandTile(
            title: '主要文献 1',
            body: '架空文献 A, 2026.',
          ),
        ),
      ),
    );

    await tester.tap(find.text('主要文献 1'));
    await tester.pumpAndSettle();

    final colors = AppTheme.light().extension<DetailColorExtension>()!;
    final body = tester.widget<Text>(find.text('架空文献 A, 2026.'));

    expect(body.style?.fontSize, 11.5);
    expect(body.style?.height, 1.6);
    expect(body.style?.color, colors.onSurfaceVariant);
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_expand_tile',
    description: 'DetailExpandTile follows Detail Spec ref-row CSS',
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DetailExpandTile(
                        title: '主要文献 1',
                        body: '架空文献 A, 2026.',
                        initiallyExpanded: true,
                      ),
                      DetailExpandTile(
                        title: '主要文献 2',
                        body: '架空文献 B, 2026.',
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
