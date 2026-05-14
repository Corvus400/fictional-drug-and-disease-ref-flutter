// Preview entrypoints must stay public for Flutter Widget Previewer.
// ignore_for_file: public_member_api_docs

import 'package:fictional_drug_and_disease_ref/ui/bookmarks/widgets/bookmark_search_box.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/widgets/bulk_delete_confirm_dialog.dart';
import 'package:fictional_drug_and_disease_ref/ui/previews/preview_support.dart';
import 'package:flutter/material.dart';

@FddComponentPreview(group: 'History', name: 'Bulk delete dialog')
Widget previewHistoryBulkDeleteDialog() {
  return const BulkDeleteConfirmDialogCard(count: 12);
}

@FddComponentPreview(group: 'Bookmarks', name: 'Search box')
Widget previewBookmarksSearchBox() {
  return BookmarkSearchBox(onChanged: (_) {});
}
