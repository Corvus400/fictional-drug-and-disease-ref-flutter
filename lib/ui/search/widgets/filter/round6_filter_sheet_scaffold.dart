part of '../../search_view.dart';

/// Shared frame for the Round 6 search filter sheet.
class Round6FilterSheetFrame extends StatelessWidget {
  /// Creates a fixed-height filter sheet frame.
  const Round6FilterSheetFrame({
    required this.height,
    required this.child,
    super.key,
  });

  /// Sheet height.
  final double height;

  /// Sheet body.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      key: const ValueKey('search-round6-filter-sheet'),
      width: double.infinity,
      height: height,
      child: Material(
        key: const ValueKey('search-round6-filter-sheet-material'),
        color: theme.colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(SearchConstants.searchFilterSheetTopRadius),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(top: false, child: child),
      ),
    );
  }
}

/// Presentation model for one filter axis row.
final class FilterAxis {
  /// Creates a filter axis row description.
  const FilterAxis({
    required this.id,
    required this.title,
    required this.summary,
    required this.selectedCount,
    required this.hint,
    required this.content,
  });

  /// Stable axis id used for expansion state and widget keys.
  final String id;

  /// Axis title.
  final String title;

  /// Current selected-value summary.
  final String summary;

  /// Number of selected values.
  final int selectedCount;

  /// Helper text shown on the row.
  final String hint;

  /// Expanded content for this axis.
  final Widget content;
}

/// Shared scaffold for the Round 6 search filter sheet.
class Round6FilterSheetScaffold extends StatelessWidget {
  /// Creates a search filter sheet scaffold.
  const Round6FilterSheetScaffold({
    required this.title,
    required this.axisPolicy,
    required this.axes,
    required this.expandedAxis,
    required this.onToggleAxis,
    required this.onReset,
    required this.onApply,
    required this.resultCount,
    super.key,
  });

  /// Sheet title.
  final String title;

  /// Axis selection policy copy.
  final String axisPolicy;

  /// Axis rows rendered by the sheet.
  final List<FilterAxis> axes;

  /// Currently expanded axis id.
  final String expandedAxis;

  /// Called when an axis row is tapped.
  final ValueChanged<String> onToggleAxis;

  /// Called when reset is tapped.
  final VoidCallback onReset;

  /// Called when apply is tapped.
  final VoidCallback onApply;

  /// Result count preview shown in the apply button.
  final int resultCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet =
            constraints.maxWidth >= SearchConstants.searchTabletBreakpoint;
        final gutter = isTablet
            ? SearchConstants.searchTabletGutter
            : SearchConstants.searchPhoneGutter;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.hairline,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const SizedBox(
                  key: ValueKey('search-filter-handle'),
                  width: 40,
                  height: 4,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: palette.hairline)),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(gutter, 4, gutter, 12),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: palette.ink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: onReset,
                              child: Text(
                                l10n.searchFilterReset,
                                style: TextStyle(
                                  color: palette.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            IconButton(
                              key: const ValueKey('filter-sheet-close-icon'),
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(
                                Icons.close,
                                color: palette.primary,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          axisPolicy,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Column(
                      children: [
                        for (final axis in axes)
                          _FilterAxisRow(
                            axis: axis,
                            expanded: expandedAxis == axis.id,
                            gutter: gutter,
                            onTap: () => onToggleAxis(axis.id),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(top: BorderSide(color: palette.hairline)),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(gutter, 12, gutter, 28),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: FilledButton(
                        key: const ValueKey('filterApplyCta'),
                        onPressed: onApply,
                        style: FilledButton.styleFrom(
                          backgroundColor: palette.primary,
                          foregroundColor: palette.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          l10n.searchFilterApplyWithCount(resultCount),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FilterAxisRow extends StatelessWidget {
  const _FilterAxisRow({
    required this.axis,
    required this.expanded,
    required this.gutter,
    required this.onTap,
  });

  final FilterAxis axis;
  final bool expanded;
  final double gutter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    final keySuffix = _axisWidgetKeySuffix(axis.id);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: expanded ? palette.surfaceSubtle : theme.colorScheme.surface,
        border: Border(bottom: BorderSide(color: palette.hairline)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                axis.title,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            if (axis.selectedCount > 0) ...[
                              const SizedBox(width: 6),
                              _FilterCountPill(
                                key: ValueKey(
                                  'search-filter-count-pill-$keySuffix',
                                ),
                                count: axis.selectedCount,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                axis.summary,
                                key: ValueKey('axisSummary_$keySuffix'),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              axis.hint,
                              key: ValueKey('axisHint_$keySuffix'),
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: expanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 120),
                    child: const Icon(Icons.chevron_right, size: 18),
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            Padding(
              padding: EdgeInsets.fromLTRB(gutter, 0, gutter, 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: axis.content,
              ),
            ),
        ],
      ),
    );
  }
}

String _axisWidgetKeySuffix(String id) {
  return id.replaceAllMapped(
    RegExp('_([a-z])'),
    (match) => match.group(1)!.toUpperCase(),
  );
}

class _FilterCountPill extends StatelessWidget {
  const _FilterCountPill({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.primary,
        borderRadius: BorderRadius.circular(9),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: Text(
              '$count',
              style: theme.textTheme.labelSmall?.copyWith(
                color: palette.onPrimary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Wrap of selectable filter chips.
class FilterChipGroup extends StatelessWidget {
  /// Creates a filter chip group.
  const FilterChipGroup({
    required this.values,
    required this.selected,
    required this.labelFor,
    required this.onToggle,
    super.key,
  });

  /// Values rendered as chips.
  final List<String> values;

  /// Currently selected values.
  final Set<String> selected;

  /// Maps a raw value to display text.
  final String Function(String value) labelFor;

  /// Called when a chip is toggled.
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final value in values)
          _FilterPillChip(
            value: value,
            label: Text(
              labelFor(value),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            selected: selected.contains(value),
            onTap: () => onToggle(value),
          ),
      ],
    );
  }
}

class _FilterPillChip extends StatelessWidget {
  const _FilterPillChip({
    required this.value,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String value;
  final Widget label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    final safeValue = value.replaceAll(RegExp('[^A-Za-z0-9_-]'), '_');
    const borderRadius = 14.0;
    final textStyle = theme.textTheme.labelSmall?.copyWith(
      color: selected ? palette.primary : palette.ink2,
      fontSize: 12,
      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
    );
    final fillColor = selected
        ? palette.primarySoft
        : theme.brightness == Brightness.dark
        ? palette.surface2
        : palette.surface;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: DecoratedBox(
        key: ValueKey(
          'search-filter-pill-chip-'
          '${selected ? 'selected' : 'unselected'}-$safeValue',
        ),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: selected ? palette.primaryRing : palette.hairline,
            width: 0.5,
          ),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selected) ...[
                  Icon(
                    Icons.check,
                    key: ValueKey('search-filter-pill-check-$safeValue'),
                    size: 10,
                    color: palette.primary,
                  ),
                  const SizedBox(width: 4),
                ],
                Flexible(
                  child: DefaultTextStyle.merge(style: textStyle, child: label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Two-choice boolean chip group.
class BoolChipGroup extends StatelessWidget {
  /// Creates a boolean chip group.
  const BoolChipGroup({
    required this.value,
    required this.trueLabel,
    required this.falseLabel,
    required this.onChanged,
    super.key,
  });

  /// Current boolean value, or null when unselected.
  final bool? value;

  /// Label for true.
  final String trueLabel;

  /// Label for false.
  final String falseLabel;

  /// Called when the selected value changes.
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _FilterPillChip(
          value: 'true',
          label: Text(
            trueLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          selected: value == true,
          onTap: () => onChanged(value == true ? null : true),
        ),
        const SizedBox(width: 6),
        _FilterPillChip(
          value: 'false',
          label: Text(
            falseLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          selected: value == false,
          onTap: () => onChanged(value == false ? null : false),
        ),
      ],
    );
  }
}
