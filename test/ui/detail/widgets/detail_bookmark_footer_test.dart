import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_bookmark_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailBookmarkFooter matches footer and bookmark button CSS', (
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
    expect(footer.constraints?.maxHeight, 64);
    expect(footer.padding, const EdgeInsets.symmetric(horizontal: 16));
    expect(footerDecoration.color, colors.surfaceContainerLowest);
    expect(
      footerDecoration.border,
      Border(top: BorderSide(color: colors.outlineVariant)),
    );
    expect(footerDecoration.boxShadow?.single.offset, const Offset(0, -4));
    expect(footerDecoration.boxShadow?.single.blurRadius, 12);
    expect(button.constraints?.minHeight, 44);
    expect(button.constraints?.maxHeight, 44);
    expect(button.padding, const EdgeInsets.symmetric(horizontal: 16));
    expect(buttonDecoration.color, colors.surfaceContainer);
    expect(buttonDecoration.borderRadius, BorderRadius.circular(22));
    expect(icon.color, colors.onSurface);
    expect(text.style?.fontSize, 14);
    expect(text.style?.fontWeight, FontWeight.w600);
    expect(text.style?.color, colors.onSurface);
  });

  testWidgets('DetailBookmarkFooter uses bookmarked state and toggles', (
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
    expect(find.text('ブックマーク済み'), findsOneWidget);
    expect(buttonDecoration.color, colors.primaryContainer);
    expect(
      tester.widget<Text>(find.text('ブックマーク済み')).style?.color,
      colors.onPrimaryContainer,
    );

    await tester.tap(
      find.byKey(const ValueKey<String>('detail-bookmark-button')),
    );
    expect(tapCount, 1);
  });

  testWidgets(
    'DetailBookmarkFooter disables taps while busy without inline error',
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
      expect(find.text('ブックマークの更新に失敗しました'), findsNothing);
    },
  );

  runGoldenMatrix(
    fileNamePrefix: 'detail_bookmark_footer',
    description: 'DetailBookmarkFooter follows Detail Spec footer CSS',
    sizes: const ['phone'],
    textScalers: const ['normal'],
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
