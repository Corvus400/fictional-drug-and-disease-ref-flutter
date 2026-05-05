part of '../search_view.dart';

void _showSortSheet(
  BuildContext context,
  SearchScreenState state, {
  required Future<void> Function(DrugSort sort) onChangeDrugSort,
  required Future<void> Function(DiseaseSort sort) onChangeDiseaseSort,
}) {
  final l10n = AppLocalizations.of(context)!;
  final palette =
      Theme.of(context).extension<SearchPalette>() ??
      (Theme.of(context).brightness == Brightness.dark
          ? SearchPalette.dark
          : SearchPalette.light);
  final drugOptions = <({DrugSort sort, String label, String key})>[
    (
      sort: DrugSort.revisedAtDesc,
      label: l10n.searchSortByRevised,
      key: 'drug-revised',
    ),
    (
      sort: DrugSort.brandNameKana,
      label: l10n.searchSortByBrandKana,
      key: 'drug-brand-kana',
    ),
    (
      sort: DrugSort.atcCode,
      label: l10n.searchSortByAtcCode,
      key: 'drug-atc-code',
    ),
    (
      sort: DrugSort.therapeuticCategoryName,
      label: l10n.searchSortByTherapeuticCategory,
      key: 'drug-therapeutic-category',
    ),
  ];
  final diseaseOptions = <({DiseaseSort sort, String label, String key})>[
    (
      sort: DiseaseSort.revisedAtDesc,
      label: l10n.searchSortDiseaseRevisedAt,
      key: 'disease-revised',
    ),
    (
      sort: DiseaseSort.nameKana,
      label: l10n.searchSortDiseaseName,
      key: 'disease-name',
    ),
    (
      sort: DiseaseSort.icd10Chapter,
      label: l10n.searchSortDiseaseIcd10,
      key: 'disease-icd10',
    ),
  ];
  unawaited(
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.tab == SearchTab.drugs)
              for (final option in drugOptions)
                _SortOptionTile(
                  label: option.label,
                  selected:
                      (state.drugParams.sort ?? DrugSort.revisedAtDesc) ==
                      option.sort,
                  selectedKey: option.key,
                  palette: palette,
                  onTap: () {
                    Navigator.of(context).pop();
                    unawaited(onChangeDrugSort(option.sort));
                  },
                )
            else
              for (final option in diseaseOptions)
                _SortOptionTile(
                  label: option.label,
                  selected:
                      (state.diseaseParams.sort ?? DiseaseSort.revisedAtDesc) ==
                      option.sort,
                  selectedKey: option.key,
                  palette: palette,
                  onTap: () {
                    Navigator.of(context).pop();
                    unawaited(onChangeDiseaseSort(option.sort));
                  },
                ),
          ],
        ),
      ),
    ),
  );
}

class _SortOptionTile extends StatelessWidget {
  const _SortOptionTile({
    required this.label,
    required this.selected,
    required this.selectedKey,
    required this.palette,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final String selectedKey;
  final SearchPalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: selected ? palette.primary : null,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      trailing: selected
          ? Icon(
              Icons.check,
              key: ValueKey('search-sort-check-$selectedKey'),
              color: palette.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}
