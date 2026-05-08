import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_severity_grade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailSeverityGrade matches grade CSS', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailSeverityGrade(
            label: '重',
            criteria: '3',
            recommendedAction: 'HCU',
          ),
        ),
      ),
    );

    final colors = AppTheme.light().extension<DetailColorExtension>()!;
    final card = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-severity-grade')),
    );
    final decoration = card.decoration! as BoxDecoration;
    final grid = tester.widget<Row>(
      find.byKey(const ValueKey<String>('detail-severity-grade-grid')),
    );
    final labelBox = tester.widget<SizedBox>(
      find.byKey(const ValueKey<String>('detail-severity-grade-label-box')),
    );
    final label = tester.widget<Text>(find.text('重'));
    final criteria = tester.widget<Text>(find.text('3'));
    final action = tester.widget<DetailMarkdownBody>(
      find.byType(DetailMarkdownBody),
    );

    expect(card.padding, const EdgeInsets.all(8));
    expect(card.margin, const EdgeInsets.only(top: 6));
    expect(decoration.color, colors.surfaceContainerLow);
    expect(decoration.border, Border.all(color: colors.outlineVariant));
    expect(decoration.borderRadius, BorderRadius.circular(8));
    expect(grid.crossAxisAlignment, CrossAxisAlignment.center);
    expect(labelBox.width, 46);
    expect(label.textAlign, TextAlign.center);
    expect(label.style?.fontSize, 13);
    expect(label.style?.fontWeight, FontWeight.w800);
    expect(label.style?.color, colors.primary);
    expect(criteria.style?.fontSize, 12);
    expect(criteria.style?.fontWeight, FontWeight.w700);
    expect(criteria.style?.color, colors.onSurface);
    expect(action.data, 'HCU');
    expect(action.fontSize, 12);
    expect(action.color, colors.onSurfaceVariant);
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_severity_grade',
    description: 'DetailSeverityGrade follows Detail Spec grade CSS',
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
                      DetailSeverityGrade(
                        label: '軽',
                        criteria: '0-1',
                        recommendedAction: '外来・経口',
                        isFirst: true,
                      ),
                      DetailSeverityGrade(
                        label: '中',
                        criteria: '2',
                        recommendedAction: '入院・注射',
                      ),
                      DetailSeverityGrade(
                        label: '重',
                        criteria: '3',
                        recommendedAction: 'HCU',
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
