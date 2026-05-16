part of '../search_view.dart';

Future<void> _showSortSheet(
  BuildContext context,
  SearchScreenState state, {
  required Future<void> Function(DrugSort sort) onChangeDrugSort,
  required Future<void> Function(DiseaseSort sort) onChangeDiseaseSort,
}) {
  final l10n = AppLocalizations.of(context)!;
  final palette =
      Theme.of(context).extension<AppPalette>() ??
      (Theme.of(context).brightness == Brightness.dark
          ? AppPalette.dark
          : AppPalette.light);
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
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => _Round6SortSheet(
      palette: palette,
      children: state.tab == SearchTab.drugs
          ? [
              for (var index = 0; index < drugOptions.length; index++)
                _SortOptionTile(
                  label: drugOptions[index].label,
                  selected:
                      (state.drugParams.sort ?? DrugSort.revisedAtDesc) ==
                      drugOptions[index].sort,
                  selectedKey: drugOptions[index].key,
                  isLast: index == drugOptions.length - 1,
                  palette: palette,
                  onTap: () {
                    Navigator.of(context).pop();
                    unawaited(onChangeDrugSort(drugOptions[index].sort));
                  },
                ),
            ]
          : [
              for (var index = 0; index < diseaseOptions.length; index++)
                _SortOptionTile(
                  label: diseaseOptions[index].label,
                  selected:
                      (state.diseaseParams.sort ?? DiseaseSort.revisedAtDesc) ==
                      diseaseOptions[index].sort,
                  selectedKey: diseaseOptions[index].key,
                  isLast: index == diseaseOptions.length - 1,
                  palette: palette,
                  onTap: () {
                    Navigator.of(context).pop();
                    unawaited(
                      onChangeDiseaseSort(diseaseOptions[index].sort),
                    );
                  },
                ),
            ],
    ),
  );
}

class _Round6SortSheet extends StatelessWidget {
  const _Round6SortSheet({required this.palette, required this.children});

  final AppPalette palette;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      top: false,
      child: Material(
        key: const ValueKey('search-sort-sheet'),
        color: palette.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: DecoratedBox(
                    key: const ValueKey('search-sort-sheet-handle'),
                    decoration: BoxDecoration(
                      color: palette.hairline,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const SizedBox(width: 40, height: 4),
                  ),
                ),
                DecoratedBox(
                  key: const ValueKey('search-sort-sheet-header'),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: palette.hairline)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Center(
                      child: Text(
                        l10n.searchSortTitle,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: palette.ink,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                ),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SortOptionTile extends StatelessWidget {
  const _SortOptionTile({
    required this.label,
    required this.selected,
    required this.selectedKey,
    required this.isLast,
    required this.palette,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final String selectedKey;
  final bool isLast;
  final AppPalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          key: ValueKey('search-sort-row-$selectedKey'),
          borderRadius: BorderRadius.zero,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: selected ? palette.primary : palette.ink,
                      fontSize: 14,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
                if (selected)
                  Icon(
                    Icons.check,
                    key: ValueKey('search-sort-check-$selectedKey'),
                    color: palette.primary,
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            key: ValueKey('search-sort-divider-$selectedKey'),
            height: 0,
            thickness: 0.5,
            color: palette.hairline2,
          ),
      ],
    );
  }
}
