// Preview entrypoints must stay public for Flutter Widget Previewer.
// ignore_for_file: public_member_api_docs

import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/widgets/bookmark_search_box.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/widgets/swipe_delete_bookmark_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/widgets/bulk_delete_confirm_dialog.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/widgets/history_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/previews/preview_data.dart';
import 'package:fictional_drug_and_disease_ref/ui/previews/preview_support.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';
import 'package:flutter/material.dart';

@FddScreenPreview(group: 'History', name: 'Loaded rows')
Widget previewHistoryLoaded() {
  return _previewHistoryView(previewHistoryLoadedState);
}

@FddScreenPreview(group: 'History', name: 'Swipe reveal')
Widget previewHistorySwipeReveal() {
  return _previewHistoryView(
    previewHistoryLoadedState,
    debugSwipeRevealRowId: previewDrugSummary.id,
  );
}

@FddScreenPreview(group: 'History', name: 'Empty')
Widget previewHistoryEmpty() {
  return _previewHistoryView(const HistoryEmpty());
}

@FddScreenPreview(group: 'History', name: 'Loading')
Widget previewHistoryLoading() {
  return _previewHistoryView(const HistoryLoading());
}

@FddTabletPreview(group: 'History', name: 'Tablet pane')
Widget previewHistoryTabletPane() {
  return _previewHistoryView(previewHistoryLoadedState);
}

@FddComponentPreview(group: 'History', name: 'Row variants')
Widget previewHistoryRows() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (final row in previewHistoryLoadedState.rows)
        HistoryRowTile(
          row: row,
          now: previewNow,
          drugImageCacheManager: previewFailingCacheManager,
          logDrugImageErrors: false,
        ),
    ],
  );
}

@FddComponentPreview(group: 'History', name: 'Bulk delete dialog')
Widget previewHistoryBulkDeleteDialog() {
  return const BulkDeleteConfirmDialogCard(count: 12);
}

@FddScreenPreview(group: 'Bookmarks', name: 'Loaded rows')
Widget previewBookmarksLoaded() {
  return _previewBookmarksView(previewBookmarksLoadedState);
}

@FddScreenPreview(group: 'Bookmarks', name: 'Swipe reveal')
Widget previewBookmarksSwipeReveal() {
  return _previewBookmarksView(
    previewBookmarksLoadedState,
    debugSwipeRevealRowId: previewDrugSummary.id,
  );
}

@FddScreenPreview(group: 'Bookmarks', name: 'Search zero')
Widget previewBookmarksSearchZero() {
  return _previewBookmarksView(previewBookmarksSearchZeroState);
}

@FddScreenPreview(group: 'Bookmarks', name: 'Error')
Widget previewBookmarksError() {
  return _previewBookmarksView(
    const BookmarksError(
      selectedTab: BookmarksTab.all,
      searchQuery: '',
      visibleCount: 2,
      cause: 'preview',
    ),
  );
}

@FddScreenPreview(group: 'Bookmarks', name: 'Empty')
Widget previewBookmarksEmpty() {
  return _previewBookmarksView(
    const BookmarksEmpty(selectedTab: BookmarksTab.all, searchQuery: ''),
  );
}

@FddScreenPreview(group: 'Bookmarks', name: 'Loading')
Widget previewBookmarksLoading() {
  return _previewBookmarksView(
    const BookmarksLoading(selectedTab: BookmarksTab.all, searchQuery: ''),
  );
}

@FddTabletPreview(group: 'Bookmarks', name: 'Tablet pane')
Widget previewBookmarksTabletPane() {
  return _previewBookmarksView(previewBookmarksLoadedState);
}

@FddComponentPreview(group: 'Bookmarks', name: 'Search box and rows')
Widget previewBookmarksControls() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      BookmarkSearchBox(onChanged: (_) {}),
      const SizedBox(height: 12),
      for (final row in previewBookmarksLoadedState.visibleRows)
        SwipeDeleteBookmarkRow(
          row: row,
          drugImageCacheManager: previewFailingCacheManager,
          onDelete: (_) async {},
          revealForTesting: row.id == previewDrugSummary.id,
          logDrugImageErrors: false,
        ),
    ],
  );
}

Widget _previewHistoryView(
  HistoryScreenState state, {
  String? debugSwipeRevealRowId,
}) {
  return previewProviderScope(
    overrides: [
      drugCardImageCacheManagerProvider.overrideWithValue(
        previewFailingCacheManager,
      ),
      historyScreenProvider.overrideWithBuild((ref, notifier) => state),
    ],
    child: HistoryView(
      currentTime: previewNow,
      debugSwipeRevealRowId: debugSwipeRevealRowId,
      debugLogDrugImageErrors: false,
    ),
  );
}

Widget _previewBookmarksView(
  BookmarksScreenState state, {
  String? debugSwipeRevealRowId,
}) {
  return previewProviderScope(
    overrides: [
      drugCardImageCacheManagerProvider.overrideWithValue(
        previewFailingCacheManager,
      ),
      bookmarksScreenProvider.overrideWithBuild((ref, notifier) => state),
    ],
    child: BookmarksView(
      debugSwipeRevealRowId: debugSwipeRevealRowId,
      debugLogDrugImageErrors: false,
    ),
  );
}
