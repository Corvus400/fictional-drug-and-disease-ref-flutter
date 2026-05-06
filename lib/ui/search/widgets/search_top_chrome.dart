part of '../search_view.dart';

class _SearchTopChrome extends StatelessWidget {
  const _SearchTopChrome({
    required this.state,
    required this.palette,
    required this.gutter,
    required this.isTablet,
    required this.historyTapRegionGroupId,
    required this.onChangeTab,
    required this.onOpenHistory,
    required this.onChangeQuery,
    required this.onClearQuery,
    required this.onSubmit,
    required this.onCancel,
  });

  final SearchScreenState state;
  final SearchPalette palette;
  final double gutter;
  final bool isTablet;
  final Object historyTapRegionGroupId;
  final Future<void> Function(SearchTab tab) onChangeTab;
  final VoidCallback onOpenHistory;
  final ValueChanged<String> onChangeQuery;
  final VoidCallback onClearQuery;
  final Future<void> Function() onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final fieldHeight = isTablet
        ? SearchConstants.searchTabletFieldHeight
        : SearchConstants.searchPhoneFieldHeight;
    return Material(
      key: const ValueKey('search-round6-top-chrome'),
      color: theme.colorScheme.surface,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: palette.hairline)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            gutter,
            (isTablet ? 0 : SearchConstants.searchPhoneTopChromeStatusPadding) +
                10,
            gutter,
            10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.tabSearch,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: isTablet
                      ? SearchConstants.searchTabletTitleFontSize
                      : SearchConstants.searchPhoneTitleFontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              _Round6SegmentedControl(
                selected: state.tab,
                palette: palette,
                onChanged: (tab) => unawaited(onChangeTab(tab)),
              ),
              const SizedBox(height: 10),
              Row(
                key: const ValueKey('search-round6-input-row'),
                children: [
                  Expanded(
                    child: SizedBox(
                      height: fieldHeight,
                      child: _SearchField(
                        queryText: state.queryText,
                        hintText: state.tab == SearchTab.drugs
                            ? l10n.searchHintDrugs
                            : l10n.searchHintDiseases,
                        palette: palette,
                        tapRegionGroupId: historyTapRegionGroupId,
                        onTap: onOpenHistory,
                        onChanged: onChangeQuery,
                        onClear: onClearQuery,
                        onSubmit: onSubmit,
                        onCancel: onCancel,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (state.historyDropdownOpen)
                    TextButton(
                      onPressed: onCancel,
                      child: Text(l10n.searchActionCancel),
                    )
                  else
                    SizedBox(
                      height: fieldHeight,
                      child: FilledButton(
                        key: const ValueKey('search-submit-button'),
                        onPressed: () => unawaited(onSubmit()),
                        style: FilledButton.styleFrom(
                          backgroundColor: palette.searchPrimaryActionBg,
                          foregroundColor: palette.searchPrimaryActionFg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              SearchConstants.searchButtonRadius,
                            ),
                          ),
                        ),
                        child: Text(l10n.searchActionSearch),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField({
    required this.queryText,
    required this.hintText,
    required this.palette,
    required this.tapRegionGroupId,
    required this.onTap,
    required this.onChanged,
    required this.onClear,
    required this.onSubmit,
    required this.onCancel,
  });

  final String queryText;
  final String hintText;
  final SearchPalette palette;
  final Object tapRegionGroupId;
  final VoidCallback onTap;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final Future<void> Function() onSubmit;
  final VoidCallback onCancel;

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.queryText);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.queryText != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.queryText,
        selection: TextSelection.collapsed(offset: widget.queryText.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const ValueKey('search-field'),
      controller: _controller,
      focusNode: _focusNode,
      groupId: widget.tapRegionGroupId,
      onTap: widget.onTap,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
        widget.onCancel();
      },
      onChanged: widget.onChanged,
      onSubmitted: (_) => unawaited(widget.onSubmit()),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: widget.queryText.isEmpty
            ? null
            : IconButton(
                key: const ValueKey('search-query-clear-button'),
                onPressed: () {
                  widget.onClear();
                  _focusNode.requestFocus();
                },
                icon: const Icon(Icons.cancel),
              ),
        filled: true,
        fillColor: widget.palette.searchFieldBg,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            SearchConstants.searchFieldRadius,
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            SearchConstants.searchFieldRadius,
          ),
          borderSide: BorderSide(color: widget.palette.primaryRing),
        ),
      ),
    );
  }
}

class _Round6SegmentedControl extends StatelessWidget {
  const _Round6SegmentedControl({
    required this.selected,
    required this.palette,
    required this.onChanged,
  });

  final SearchTab selected;
  final SearchPalette palette;
  final ValueChanged<SearchTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      key: const ValueKey('search-round6-segmented'),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: palette.surfaceSubtle,
        borderRadius: BorderRadius.circular(
          SearchConstants.searchSegmentedRadius,
        ),
      ),
      child: Row(
        children: [
          _Round6SegmentButton(
            label: l10n.searchTabDrugs,
            selected: selected == SearchTab.drugs,
            theme: theme,
            onPressed: () => onChanged(SearchTab.drugs),
          ),
          _Round6SegmentButton(
            label: l10n.searchTabDiseases,
            selected: selected == SearchTab.diseases,
            theme: theme,
            onPressed: () => onChanged(SearchTab.diseases),
          ),
        ],
      ),
    );
  }
}

class _Round6SegmentButton extends StatelessWidget {
  const _Round6SegmentButton({
    required this.label,
    required this.selected,
    required this.theme,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final ThemeData theme;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(
          SearchConstants.searchSelectedSegmentRadius,
        ),
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: selected ? theme.colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(
              SearchConstants.searchSelectedSegmentRadius,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: theme.shadowColor.withValues(alpha: 0.06),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: selected
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
