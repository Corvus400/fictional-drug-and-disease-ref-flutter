import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'DetailMarkdownBody renders CommonMark with flutter_markdown_plus',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: DetailMarkdownBody(data: '**重要** な説明\n\n- 箇条書き'),
          ),
        ),
      );

      expect(find.byType(MarkdownBody), findsOneWidget);
      final markdown = tester.widget<MarkdownBody>(find.byType(MarkdownBody));
      expect(markdown.data, '**重要** な説明\n\n- 箇条書き');
      expect(markdown.softLineBreak, isTrue);
      expect(markdown.styleSheet?.p?.fontSize, DetailConstants.kvFontSize);
      expect(markdown.styleSheet?.strong?.fontWeight, FontWeight.w700);
    },
  );
}
