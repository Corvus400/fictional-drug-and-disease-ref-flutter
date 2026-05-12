import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('HistoryView empty state', () {
    late AppDatabase db;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    testWidgets('renders the design-specified empty state', (tester) async {
      tester.view.devicePixelRatio = 2;
      tester.view.physicalSize = const Size(780, 1688);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        _App(db: db, historyStream: Stream.value(const [])),
      );
      await tester.pump(const Duration(milliseconds: 100));
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
      });

      expect(find.text('閲覧履歴'), findsWidgets);
      expect(find.text('すべて'), findsOneWidget);
      expect(find.text('医薬品'), findsOneWidget);
      expect(find.text('疾患'), findsOneWidget);
      expect(find.text('閲覧履歴がありません'), findsOneWidget);
      expect(
        find.text('検索して薬品・疾患を閲覧すると、ここに履歴が表示されます'),
        findsOneWidget,
      );
      expect(find.text('検索画面へ'), findsOneWidget);

      final artRect = tester.getRect(
        find.byKey(const ValueKey('history-empty-art')),
      );
      expect(artRect.size, const Size(120, 120));
      final ctaRect = tester.getRect(
        find.byKey(const ValueKey('history-empty-cta')),
      );
      expect(ctaRect.height, greaterThanOrEqualTo(44));
      final tabBarRect = tester.getRect(
        find.byKey(const ValueKey('history-tabbar')),
      );
      expect(tabBarRect.height, greaterThanOrEqualTo(44));
      expect(find.text('閲覧履歴画面（プレースホルダー）'), findsNothing);
    });

    testWidgets('renders five loading skeleton rows', (tester) async {
      tester.view.devicePixelRatio = 2;
      tester.view.physicalSize = const Size(780, 1688);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const _App(
          db: null,
          historyStream: Stream<List<BrowsingHistoryEntry>>.empty(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
      });

      final rows = find.byKey(const ValueKey('history-loading-skeleton-row'));
      expect(rows, findsNWidgets(5));
      expect(find.text('閲覧履歴がありません'), findsNothing);
      expect(find.text('検索画面へ'), findsNothing);

      for (final element in rows.evaluate()) {
        final rect = tester.getRect(find.byWidget(element.widget));
        expect(rect.height, 80);
      }
    });
  });
}

class _App extends StatelessWidget {
  const _App({required this.db, required this.historyStream});

  final AppDatabase? db;
  final Stream<List<BrowsingHistoryEntry>> historyStream;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        if (db != null) appDatabaseProvider.overrideWithValue(db!),
        browsingHistoryStreamProvider.overrideWith(
          (ref) => historyStream,
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HistoryView(),
      ),
    );
  }
}
