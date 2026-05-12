import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/widgets/swipe_delete_bookmark_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  testWidgets(
    'reveals the same 72dp destructive action as browsing history',
    (tester) async {
      String? deletedId;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 320,
                child: SwipeDeleteBookmarkRow(
                  row: BookmarksDiseaseRow(
                    id: _diseaseSummary.id,
                    bookmarkedAt: DateTime.utc(2026, 5, 10),
                    summary: _diseaseSummary,
                  ),
                  drugImageCacheManager: _fallbackImageCacheManager(),
                  onDelete: (id) async {
                    deletedId = id;
                  },
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Dismissible), findsNothing);
      expect(
        tester
            .getSize(
              find.byKey(
                ValueKey('bookmarks-row-swipe-reveal-${_diseaseSummary.id}'),
              ),
            )
            .width,
        0,
      );

      await tester.drag(
        find.byType(SwipeDeleteBookmarkRow),
        const Offset(-140, 0),
      );
      await tester.pumpAndSettle();

      final actionFinder = find.byKey(
        ValueKey('bookmarks-row-swipe-action-${_diseaseSummary.id}'),
      );
      final actionRect = tester.getRect(actionFinder);
      final rowRect = tester.getRect(
        find.byKey(ValueKey('disease-card-${_diseaseSummary.id}')),
      );
      final rowCard = tester.widget<Card>(
        find.byKey(ValueKey('disease-card-${_diseaseSummary.id}')),
      );
      final rowShape = rowCard.shape! as RoundedRectangleBorder;
      final actionClip = tester.widget<ClipRRect>(
        find.byKey(
          ValueKey('bookmarks-row-swipe-action-clip-${_diseaseSummary.id}'),
        ),
      );
      final actionMaterial = tester.widget<Material>(
        find.byKey(
          ValueKey(
            'bookmarks-row-swipe-action-material-${_diseaseSummary.id}',
          ),
        ),
      );
      final actionBox = tester.widget<DecoratedBox>(actionFinder);
      final decoration = actionBox.decoration as BoxDecoration;

      expect(actionRect.width, 72);
      expect(rowRect.right, moreOrLessEquals(actionRect.left));
      expect(actionRect.top, moreOrLessEquals(rowRect.top + 8));
      expect(actionRect.height, moreOrLessEquals(rowRect.height - 8));
      expect(
        tester
            .getSize(
              find.byKey(
                ValueKey('bookmarks-row-swipe-reveal-${_diseaseSummary.id}'),
              ),
            )
            .width,
        72,
      );
      expect(actionClip.clipBehavior, Clip.antiAlias);
      expect(
        actionClip.borderRadius,
        const BorderRadius.only(
          topRight: Radius.circular(SearchConstants.searchCardRadius),
          bottomRight: Radius.circular(SearchConstants.searchCardRadius),
        ),
      );
      expect(actionMaterial.clipBehavior, Clip.antiAlias);
      expect(
        actionMaterial.borderRadius,
        const BorderRadius.only(
          topRight: Radius.circular(SearchConstants.searchCardRadius),
          bottomRight: Radius.circular(SearchConstants.searchCardRadius),
        ),
      );
      expect(
        rowShape.borderRadius,
        const BorderRadius.only(
          topLeft: Radius.circular(SearchConstants.searchCardRadius),
          bottomLeft: Radius.circular(SearchConstants.searchCardRadius),
        ),
      );
      expect(decoration.color, const Color(0xFFD62A2A));
      expect(find.text('削除'), findsOneWidget);

      await tester.tap(actionFinder);
      await tester.pump();

      expect(deletedId, _diseaseSummary.id);
    },
  );
}

_MockBaseCacheManager _fallbackImageCacheManager() {
  final cacheManager = _MockBaseCacheManager();
  when(
    () => cacheManager.getSingleFile(
      any(),
      key: any(named: 'key'),
      headers: any(named: 'headers'),
    ),
  ).thenThrow(StateError('bookmarks swipe test renders fallback image'));
  return cacheManager;
}

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}

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
