import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../golden/golden_test_helpers.dart';

void main() {
  setUpAll(() {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
  });

  runHistoryGoldenMatrix(
    fileNamePrefix: 'bookmarks_normal',
    description: 'Bookmarks normal state',
    builder: (theme, size, deviceName, textScaler, textScalerName) {
      return _BookmarksGoldenApp(
        theme: theme,
        stream: Stream.value(_normalEntries),
      );
    },
    whilePerforming: _settleBookmarksGolden,
  );

  runHistoryGoldenMatrix(
    fileNamePrefix: 'bookmarks_empty',
    description: 'Bookmarks empty state',
    builder: (theme, size, deviceName, textScaler, textScalerName) {
      return _BookmarksGoldenApp(
        theme: theme,
        stream: Stream<List<BookmarkEntry>>.value(const []),
      );
    },
    whilePerforming: _settleBookmarksGolden,
  );

  runHistoryGoldenMatrix(
    fileNamePrefix: 'bookmarks_loading',
    description: 'Bookmarks loading state',
    builder: (theme, size, deviceName, textScaler, textScalerName) {
      return _BookmarksGoldenApp(
        theme: theme,
        stream: const Stream<List<BookmarkEntry>>.empty(),
      );
    },
    whilePerforming: _settleBookmarksGolden,
  );

  runHistoryGoldenMatrix(
    fileNamePrefix: 'bookmarks_search_zero',
    description: 'Bookmarks search zero state',
    builder: (theme, size, deviceName, textScaler, textScalerName) {
      return _BookmarksGoldenApp(
        theme: theme,
        stream: Stream.value(_normalEntries),
      );
    },
    whilePerforming: _enterSearchZeroQuery,
  );
}

class _BookmarksGoldenApp extends StatelessWidget {
  const _BookmarksGoldenApp({
    required this.theme,
    required this.stream,
  });

  final ThemeData theme;
  final Stream<List<BookmarkEntry>> stream;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        bookmarksStreamProvider.overrideWith((ref) => stream),
        drugCardImageCacheManagerProvider.overrideWithValue(
          _fallbackImageCacheManager(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: const BookmarksView(),
          bottomNavigationBar: AppShellBottomNavigation(
            selectedIndex: 1,
            onDestinationSelected: (_) {},
          ),
        ),
      ),
    );
  }
}

Future<Future<void> Function()?> _settleBookmarksGolden(
  WidgetTester tester,
) async {
  await tester.pump(const Duration(milliseconds: 100));
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1));
  });
  return null;
}

Future<Future<void> Function()?> _enterSearchZeroQuery(
  WidgetTester tester,
) async {
  await tester.pump(const Duration(milliseconds: 100));
  final searchBoxCount = find
      .byKey(const ValueKey('bookmarks-search-box'))
      .evaluate()
      .length;
  for (var index = 0; index < searchBoxCount; index += 1) {
    await tester.enterText(
      find.byKey(const ValueKey('bookmarks-search-box')).at(index),
      'アムロキ',
    );
    await tester.pump();
  }
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pump();
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1));
  });
  return null;
}

_MockBaseCacheManager _fallbackImageCacheManager() {
  final cacheManager = _MockBaseCacheManager();
  when(
    () => cacheManager.getSingleFile(
      any(),
      key: any(named: 'key'),
      headers: any(named: 'headers'),
    ),
  ).thenThrow(StateError('bookmarks goldens render the fallback image'));
  return cacheManager;
}

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}

final _normalEntries = <BookmarkEntry>[
  _drugEntry(
    const DrugSummary(
      id: 'drug_0089',
      brandName: 'アムロジ錠5mg「ニチイ」',
      genericName: 'アムロジピンベシル酸塩',
      therapeuticCategoryName: 'Ca拮抗薬',
      regulatoryClass: ['prescription_required'],
      dosageForm: 'tablet',
      brandNameKana: 'アムロジジョウ',
      atcCode: 'C08CA01',
      revisedAt: '2025-03-02',
      imageUrl: '/v1/images/drugs/drug_0089',
    ),
    DateTime.utc(2026, 5, 10, 5, 20),
  ),
  _diseaseEntry(
    const DiseaseSummary(
      id: 'disease_0079',
      name: '本態性高血圧症',
      icd10Chapter: 'chapter_ix',
      medicalDepartment: ['cardiology'],
      chronicity: 'chronic',
      infectious: false,
      nameKana: 'ホンタイセイコウケツアツショウ',
      revisedAt: '2024-11-18',
    ),
    DateTime.utc(2026, 5, 9, 5, 20),
  ),
  _drugEntry(
    const DrugSummary(
      id: 'drug_0042',
      brandName: 'セフメタゾン静注用1g',
      genericName: 'セフメタゾールナトリウム',
      therapeuticCategoryName: 'セフェム系抗菌薬',
      regulatoryClass: ['prescription_required'],
      dosageForm: 'injection',
      brandNameKana: 'セフメタゾン',
      atcCode: 'J01DC09',
      revisedAt: '2025-01-20',
      imageUrl: '/v1/images/drugs/drug_0042',
    ),
    DateTime.utc(2026, 5, 8, 5, 20),
  ),
  _diseaseEntry(
    const DiseaseSummary(
      id: 'disease_0028',
      name: '市中肺炎',
      icd10Chapter: 'chapter_x',
      medicalDepartment: ['呼吸器内科'],
      chronicity: 'acute',
      infectious: true,
      nameKana: 'シチュウハイエン',
      revisedAt: '2024-10-07',
    ),
    DateTime.utc(2026, 5, 6, 5, 20),
  ),
  _drugEntry(
    const DrugSummary(
      id: 'drug_0112',
      brandName: 'リエラース錠10mg',
      genericName: 'エチゾラム',
      therapeuticCategoryName: '抗不安薬',
      regulatoryClass: ['psychotropic_3'],
      dosageForm: 'tablet',
      brandNameKana: 'リエラース',
      atcCode: 'N05BA',
      revisedAt: '2024-09-04',
      imageUrl: '/v1/images/drugs/drug_0112',
    ),
    DateTime.utc(2026, 5, 5, 5, 20),
  ),
  _diseaseEntry(
    const DiseaseSummary(
      id: 'disease_0041',
      name: '2型糖尿病',
      icd10Chapter: 'chapter_iv',
      medicalDepartment: ['endocrinology'],
      chronicity: 'chronic',
      infectious: false,
      nameKana: 'ニガタトウニョウビョウ',
      revisedAt: '2025-02-11',
    ),
    DateTime.utc(2026, 4, 30, 5, 20),
  ),
];

BookmarkEntry _drugEntry(DrugSummary summary, DateTime bookmarkedAt) {
  return BookmarkEntry(
    id: summary.id,
    snapshotJson: const DrugBookmarkSnapshotCodec().encode(summary),
    bookmarkedAt: bookmarkedAt,
  );
}

BookmarkEntry _diseaseEntry(DiseaseSummary summary, DateTime bookmarkedAt) {
  return BookmarkEntry(
    id: summary.id,
    snapshotJson: const DiseaseBookmarkSnapshotCodec().encode(summary),
    bookmarkedAt: bookmarkedAt,
  );
}
