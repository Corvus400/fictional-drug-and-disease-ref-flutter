import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_bookmark_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DetailBookmarkFooter switches bookmark icon and label', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: DetailBookmarkFooter(
            isBookmarked: true,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: _noop,
            onClearBookmarkError: _noop,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.bookmark), findsOneWidget);
    expect(find.text('ブックマークを解除'), findsOneWidget);
  });

  testWidgets('DetailBookmarkFooter calls toggle and disables while busy', (
    tester,
  ) async {
    var tapCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: null,
            onToggleBookmark: () => tapCount++,
            onClearBookmarkError: _noop,
          ),
        ),
      ),
    );

    await tester.tap(find.text('ブックマークに追加'));
    expect(tapCount, 1);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: true,
            bookmarkError: null,
            onToggleBookmark: () => tapCount++,
            onClearBookmarkError: _noop,
          ),
        ),
      ),
    );

    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });

  testWidgets('DetailBookmarkFooter shows inline error and clears it', (
    tester,
  ) async {
    var clearCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: DetailBookmarkFooter(
            isBookmarked: false,
            isBusy: false,
            bookmarkError: const StorageException(
              kind: StorageErrorKind.unknown,
            ),
            onToggleBookmark: _noop,
            onClearBookmarkError: () => clearCount++,
          ),
        ),
      ),
    );

    expect(find.text('ブックマークの更新に失敗しました'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));

    expect(clearCount, 1);
  });
}

void _noop() {}
