import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Item for [CalcSegmentedControl].
class CalcSegmentedControlItem<T> {
  /// Creates a segmented control item.
  const CalcSegmentedControlItem({
    required this.value,
    required this.label,
    this.icon,
    this.leadingGlyph,
  });

  /// Item value.
  final T value;

  /// Item label.
  final String label;

  /// Optional icon.
  final IconData? icon;

  /// Optional tree-shake-safe decorative glyph shown before the label.
  final String? leadingGlyph;
}

/// Calc segmented control atom.
class CalcSegmentedControl<T> extends StatelessWidget {
  /// Creates a calc segmented control.
  const CalcSegmentedControl({
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.enabled = true,
    this.height = 36,
    this.padding = const EdgeInsets.all(2),
    this.gap = 0,
    this.selectedRadiusInset = 2,
    this.selectedFontWeight = FontWeight.w600,
    this.unselectedFontWeight = FontWeight.w600,
    this.letterSpacing,
    this.selectedShadowOpacity = 0.08,
    super.key,
  });

  /// Creates the tool switcher variant from the design spec.
  const CalcSegmentedControl.tool({
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.enabled = true,
    super.key,
  }) : height = 42,
       padding = const EdgeInsets.all(3),
       gap = 2,
       selectedRadiusInset = 3,
       selectedFontWeight = FontWeight.w700,
       unselectedFontWeight = FontWeight.w700,
       letterSpacing = 0.26,
       selectedShadowOpacity = 0.10;

  /// Creates the sex selector variant from the design spec.
  const CalcSegmentedControl.sex({
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.enabled = true,
    super.key,
  }) : height = 36,
       padding = const EdgeInsets.all(2),
       gap = 0,
       selectedRadiusInset = 2,
       selectedFontWeight = FontWeight.w600,
       unselectedFontWeight = FontWeight.w600,
       letterSpacing = null,
       selectedShadowOpacity = 0.08;

  /// Selected value.
  final T selectedValue;

  /// Control items.
  final List<CalcSegmentedControlItem<T>> items;

  /// Selection callback.
  final ValueChanged<T> onChanged;

  /// Whether the control is enabled.
  final bool enabled;

  /// Control height in logical pixels.
  final double height;

  /// Inner padding around segments.
  final EdgeInsetsGeometry padding;

  /// Gap between segments.
  final double gap;

  /// Amount subtracted from pill radius for the selected segment.
  final double selectedRadiusInset;

  /// Selected label weight.
  final FontWeight selectedFontWeight;

  /// Unselected label weight.
  final FontWeight unselectedFontWeight;

  /// Segment label letter spacing.
  final double? letterSpacing;

  /// Selected segment shadow opacity.
  final double selectedShadowOpacity;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return Semantics(
      label: '計算ツール選択',
      button: true,
      child: Opacity(
        opacity: enabled ? 1 : 0.45,
        child: Container(
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: palette.calcSurface3,
            borderRadius: BorderRadius.circular(radii.pill),
          ),
          child: Row(
            spacing: gap,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final item in items)
                Expanded(
                  child: _Segment(
                    item: item,
                    selected: item.value == selectedValue,
                    enabled: enabled,
                    spacing: spacing,
                    typography: typography,
                    palette: palette,
                    radii: radii,
                    selectedRadiusInset: selectedRadiusInset,
                    selectedFontWeight: selectedFontWeight,
                    unselectedFontWeight: unselectedFontWeight,
                    letterSpacing: letterSpacing,
                    selectedShadowOpacity: selectedShadowOpacity,
                    onTap: () => onChanged(item.value),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Segment<T> extends StatelessWidget {
  const _Segment({
    required this.item,
    required this.selected,
    required this.enabled,
    required this.spacing,
    required this.typography,
    required this.palette,
    required this.radii,
    required this.selectedRadiusInset,
    required this.selectedFontWeight,
    required this.unselectedFontWeight,
    required this.letterSpacing,
    required this.selectedShadowOpacity,
    required this.onTap,
  });

  final CalcSegmentedControlItem<T> item;
  final bool selected;
  final bool enabled;
  final AppSpacing spacing;
  final AppTypography typography;
  final AppPalette palette;
  final AppRadii radii;
  final double selectedRadiusInset;
  final FontWeight selectedFontWeight;
  final FontWeight unselectedFontWeight;
  final double? letterSpacing;
  final double selectedShadowOpacity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          key: ValueKey<String>('calc-segment-${item.value}'),
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            color: selected ? palette.calcSurface : Colors.transparent,
            borderRadius: BorderRadius.circular(
              radii.pill - selectedRadiusInset,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Color.fromRGBO(
                        15,
                        23,
                        42,
                        selectedShadowOpacity,
                      ),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.leadingGlyph != null) ...[
                ExcludeSemantics(
                  child: Text(
                    item.leadingGlyph!,
                    style: typography.bodyS.copyWith(
                      color: selected ? palette.calcPrimary : palette.calcInk2,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: spacing.s1),
              ] else if (item.icon != null) ...[
                Icon(
                  item.icon,
                  size: 16,
                  color: selected ? palette.calcPrimary : palette.calcInk2,
                ),
                SizedBox(width: spacing.s1),
              ],
              Flexible(
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: typography.bodyS.copyWith(
                    color: selected ? palette.calcPrimary : palette.calcInk2,
                    fontWeight: selected
                        ? selectedFontWeight
                        : unselectedFontWeight,
                    letterSpacing: letterSpacing,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
