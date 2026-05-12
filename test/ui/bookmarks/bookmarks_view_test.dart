import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(() {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
  });

  testWidgets('loaded state shows tabs search count and rows', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_App(entries: _bookmarkEntries));
    await _pumpBookmarks(tester);

    expect(find.byKey(const ValueKey('bookmarks-tabbar')), findsOneWidget);
    expect(find.byKey(const ValueKey('bookmarks-search-box')), findsOneWidget);
    expect(find.text('2件'), findsOneWidget);
    expect(find.text('Amlodipine'), findsOneWidget);
    expect(find.text('高血圧症'), findsOneWidget);
    expect(find.text('保存 2026/05/10'), findsOneWidget);
  });

  testWidgets('row taps navigate to detail routes', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_App(entries: _bookmarkEntries, useRouter: true));
    await _pumpBookmarks(tester);

    await tester.tap(find.text('Amlodipine'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('drug detail: drug_001'), findsOneWidget);

    await tester.pumpWidget(_App(entries: _bookmarkEntries, useRouter: true));
    await _pumpBookmarks(tester);
    await tester.tap(find.text('高血圧症'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('disease detail: disease_001'), findsOneWidget);
  });
}

Future<void> _pumpBookmarks(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump(const Duration(milliseconds: 100));
}

class _App extends StatelessWidget {
  _App({required this.entries, this.useRouter = false})
    : cacheManager = _fallbackImageCacheManager();

  final List<BookmarkEntry> entries;
  final bool useRouter;
  final BaseCacheManager cacheManager;

  @override
  Widget build(BuildContext context) {
    final child = useRouter
        ? MaterialApp.router(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: GoRouter(
              initialLocation: AppRoutes.bookmarks,
              routes: [
                GoRoute(
                  path: AppRoutes.bookmarks,
                  builder: (context, state) => const BookmarksView(),
                ),
                GoRoute(
                  path: AppRoutes.drugDetail(':id'),
                  builder: (context, state) => Scaffold(
                    body: Text('drug detail: ${state.pathParameters['id']}'),
                  ),
                ),
                GoRoute(
                  path: AppRoutes.diseaseDetail(':id'),
                  builder: (context, state) => Scaffold(
                    body: Text('disease detail: ${state.pathParameters['id']}'),
                  ),
                ),
              ],
            ),
          )
        : MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const BookmarksView(),
          );

    return ProviderScope(
      overrides: [
        bookmarksStreamProvider.overrideWith((ref) => Stream.value(entries)),
        drugCardImageCacheManagerProvider.overrideWithValue(cacheManager),
      ],
      child: child,
    );
  }
}

_MockBaseCacheManager _fallbackImageCacheManager() {
  final cacheManager = _MockBaseCacheManager();
  when(
    () => cacheManager.getSingleFile(
      any(),
      key: any(named: 'key'),
      headers: any(named: 'headers'),
    ),
  ).thenThrow(StateError('bookmarks tests render the fallback image'));
  return cacheManager;
}

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}

final _bookmarkEntries = [
  BookmarkEntry(
    id: _drugSummary.id,
    snapshotJson: const DrugBookmarkSnapshotCodec().encode(_drugSummary),
    bookmarkedAt: DateTime.utc(2026, 5, 10),
  ),
  BookmarkEntry(
    id: _diseaseSummary.id,
    snapshotJson: const DiseaseBookmarkSnapshotCodec().encode(_diseaseSummary),
    bookmarkedAt: DateTime.utc(2026, 5, 9),
  ),
];

const _drugSummary = DrugSummary(
  id: 'drug_001',
  brandName: 'Amlodipine',
  genericName: 'amlodipine besilate',
  therapeuticCategoryName: 'Ca拮抗薬',
  regulatoryClass: ['prescription_required'],
  dosageForm: 'tablet',
  brandNameKana: 'アムロジピン',
  atcCode: 'C08CA01',
  revisedAt: '2026-01-01',
  imageUrl: '/v1/images/drugs/drug_001',
);

const _diseaseSummary = DiseaseSummary(
  id: 'disease_001',
  name: '高血圧症',
  icd10Chapter: 'chapter_ix',
  medicalDepartment: ['cardiology'],
  chronicity: 'chronic',
  infectious: false,
  nameKana: 'コウケツアツショウ',
  revisedAt: '2026-01-01',
);
