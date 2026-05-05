part of '../search_view.dart';

void _showSortSheet(
  BuildContext context,
  SearchTab tab, {
  required Future<void> Function(DrugSort sort) onChangeDrugSort,
}) {
  final l10n = AppLocalizations.of(context)!;
  final drugLabels = {
    DrugSort.revisedAtDesc: l10n.searchSortByRevised,
    DrugSort.brandNameKana: l10n.searchSortByBrandKana,
    DrugSort.atcCode: l10n.searchSortByAtcCode,
    DrugSort.therapeuticCategoryName: l10n.searchSortByTherapeuticCategory,
  };
  unawaited(
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (tab == SearchTab.drugs)
              for (final entry in drugLabels.entries)
                ListTile(
                  title: Text(entry.value),
                  onTap: () {
                    Navigator.of(context).pop();
                    unawaited(onChangeDrugSort(entry.key));
                  },
                )
            else
              ListTile(
                title: Text(l10n.searchSortByRevised),
                onTap: () => Navigator.of(context).pop(),
              ),
          ],
        ),
      ),
    ),
  );
}
