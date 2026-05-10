part of 'calc_view.dart';

enum _CalcResponsiveMode {
  compact,
  landscapePhone,
  iPadPortrait,
  iPadLandscape
  ;

  static _CalcResponsiveMode fromSize(Size size) {
    if (size.width < 600) {
      return _CalcResponsiveMode.compact;
    }
    if (size.height < 480) {
      return _CalcResponsiveMode.landscapePhone;
    }
    if (size.width >= 1024) {
      return _CalcResponsiveMode.iPadLandscape;
    }
    if (size.width >= 768) {
      return _CalcResponsiveMode.iPadPortrait;
    }
    return _CalcResponsiveMode.compact;
  }
}

class _CalcResponsiveBody extends StatelessWidget {
  const _CalcResponsiveBody({
    required this.mode,
    required this.state,
    required this.restoringHistory,
    required this.restoringProgressValue,
    required this.focusNodes,
    required this.onToolChanged,
    required this.onFieldChanged,
    required this.onSexChanged,
    required this.onHistoryToggle,
    required this.onHistoryRestore,
    required this.onHistoryDelete,
  });

  final _CalcResponsiveMode mode;
  final CalcScreenState state;
  final bool restoringHistory;
  final double? restoringProgressValue;
  final Map<CalcInputFieldKey, FocusNode> focusNodes;
  final ValueChanged<CalcType> onToolChanged;
  final void Function(CalcInputFieldKey field, String value) onFieldChanged;
  final ValueChanged<Sex> onSexChanged;
  final VoidCallback onHistoryToggle;
  final ValueChanged<CalculationHistoryEntry> onHistoryRestore;
  final Future<void> Function(String id) onHistoryDelete;

  @override
  Widget build(BuildContext context) {
    return switch (mode) {
      _CalcResponsiveMode.compact => _CalcCompactLayout(
        state: state,
        restoringHistory: restoringHistory,
        restoringProgressValue: restoringProgressValue,
        focusNodes: focusNodes,
        onToolChanged: onToolChanged,
        onFieldChanged: onFieldChanged,
        onSexChanged: onSexChanged,
        onHistoryToggle: onHistoryToggle,
        onHistoryRestore: onHistoryRestore,
        onHistoryDelete: onHistoryDelete,
      ),
      _CalcResponsiveMode.landscapePhone => _CalcLandscapePhoneLayout(
        state: state,
        restoringHistory: restoringHistory,
        restoringProgressValue: restoringProgressValue,
        focusNodes: focusNodes,
        onToolChanged: onToolChanged,
        onFieldChanged: onFieldChanged,
        onSexChanged: onSexChanged,
        onHistoryToggle: onHistoryToggle,
        onHistoryRestore: onHistoryRestore,
        onHistoryDelete: onHistoryDelete,
      ),
      _CalcResponsiveMode.iPadPortrait => _CalcIPadPortraitLayout(
        state: state,
        restoringHistory: restoringHistory,
        restoringProgressValue: restoringProgressValue,
        focusNodes: focusNodes,
        onToolChanged: onToolChanged,
        onFieldChanged: onFieldChanged,
        onSexChanged: onSexChanged,
        onHistoryToggle: onHistoryToggle,
        onHistoryRestore: onHistoryRestore,
        onHistoryDelete: onHistoryDelete,
      ),
      _CalcResponsiveMode.iPadLandscape => _CalcIPadLandscapeLayout(
        state: state,
        restoringHistory: restoringHistory,
        restoringProgressValue: restoringProgressValue,
        focusNodes: focusNodes,
        onToolChanged: onToolChanged,
        onFieldChanged: onFieldChanged,
        onSexChanged: onSexChanged,
        onHistoryToggle: onHistoryToggle,
        onHistoryRestore: onHistoryRestore,
        onHistoryDelete: onHistoryDelete,
      ),
    };
  }
}

class _CalcCompactLayout extends StatelessWidget {
  const _CalcCompactLayout({
    required this.state,
    required this.restoringHistory,
    required this.restoringProgressValue,
    required this.focusNodes,
    required this.onToolChanged,
    required this.onFieldChanged,
    required this.onSexChanged,
    required this.onHistoryToggle,
    required this.onHistoryRestore,
    required this.onHistoryDelete,
  });

  final CalcScreenState state;
  final bool restoringHistory;
  final double? restoringProgressValue;
  final Map<CalcInputFieldKey, FocusNode> focusNodes;
  final ValueChanged<CalcType> onToolChanged;
  final void Function(CalcInputFieldKey field, String value) onFieldChanged;
  final ValueChanged<Sex> onSexChanged;
  final VoidCallback onHistoryToggle;
  final ValueChanged<CalculationHistoryEntry> onHistoryRestore;
  final Future<void> Function(String id) onHistoryDelete;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Stack(
      key: const ValueKey<String>('calc-layout-compact'),
      children: [
        ListView(
          padding: EdgeInsets.fromLTRB(
            spacing.s4,
            spacing.s5,
            spacing.s4,
            110,
          ),
          children: [
            _CalcFormPane(
              state: state,
              focusNodes: focusNodes,
              onChanged: onFieldChanged,
              onSexChanged: onSexChanged,
              dimmed: restoringHistory,
            ),
            SizedBox(height: spacing.s4),
            _CalcResultPane(
              state: state,
              restoringHistory: restoringHistory,
              restoringProgressValue: restoringProgressValue,
            ),
            SizedBox(height: spacing.s4),
            _CalcHistoryPane(
              state: state,
              onToggle: onHistoryToggle,
              onRestore: onHistoryRestore,
              onDelete: onHistoryDelete,
              dimmed: restoringHistory,
            ),
          ],
        ),
        Positioned(
          left: spacing.s4,
          right: spacing.s4,
          bottom: spacing.s4,
          child: _CalcToolSegmentedControl(
            key: const ValueKey<String>('calc-tool-selector-bottom'),
            state: state,
            onChanged: onToolChanged,
            dimmed: restoringHistory,
          ),
        ),
      ],
    );
  }
}

class _CalcLandscapePhoneLayout extends StatelessWidget {
  const _CalcLandscapePhoneLayout({
    required this.state,
    required this.restoringHistory,
    required this.restoringProgressValue,
    required this.focusNodes,
    required this.onToolChanged,
    required this.onFieldChanged,
    required this.onSexChanged,
    required this.onHistoryToggle,
    required this.onHistoryRestore,
    required this.onHistoryDelete,
  });

  final CalcScreenState state;
  final bool restoringHistory;
  final double? restoringProgressValue;
  final Map<CalcInputFieldKey, FocusNode> focusNodes;
  final ValueChanged<CalcType> onToolChanged;
  final void Function(CalcInputFieldKey field, String value) onFieldChanged;
  final ValueChanged<Sex> onSexChanged;
  final VoidCallback onHistoryToggle;
  final ValueChanged<CalculationHistoryEntry> onHistoryRestore;
  final Future<void> Function(String id) onHistoryDelete;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Padding(
      key: const ValueKey<String>('calc-layout-landscape-phone'),
      padding: EdgeInsets.all(spacing.s4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 340,
                    child: _CalcToolSegmentedControl(
                      key: const ValueKey<String>(
                        'calc-tool-selector-landscape',
                      ),
                      state: state,
                      onChanged: onToolChanged,
                      height: 36,
                      dimmed: restoringHistory,
                    ),
                  ),
                ),
                SizedBox(height: spacing.s4),
                _CalcFormPane(
                  state: state,
                  focusNodes: focusNodes,
                  onChanged: onFieldChanged,
                  onSexChanged: onSexChanged,
                  dimmed: restoringHistory,
                ),
              ],
            ),
          ),
          SizedBox(width: spacing.s4),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _CalcResultPane(
                  state: state,
                  restoringHistory: restoringHistory,
                  restoringProgressValue: restoringProgressValue,
                ),
                SizedBox(height: spacing.s3),
                _CalcHistoryPane(
                  state: state,
                  onToggle: onHistoryToggle,
                  onRestore: onHistoryRestore,
                  onDelete: onHistoryDelete,
                  dimmed: restoringHistory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CalcIPadPortraitLayout extends StatelessWidget {
  const _CalcIPadPortraitLayout({
    required this.state,
    required this.restoringHistory,
    required this.restoringProgressValue,
    required this.focusNodes,
    required this.onToolChanged,
    required this.onFieldChanged,
    required this.onSexChanged,
    required this.onHistoryToggle,
    required this.onHistoryRestore,
    required this.onHistoryDelete,
  });

  final CalcScreenState state;
  final bool restoringHistory;
  final double? restoringProgressValue;
  final Map<CalcInputFieldKey, FocusNode> focusNodes;
  final ValueChanged<CalcType> onToolChanged;
  final void Function(CalcInputFieldKey field, String value) onFieldChanged;
  final ValueChanged<Sex> onSexChanged;
  final VoidCallback onHistoryToggle;
  final ValueChanged<CalculationHistoryEntry> onHistoryRestore;
  final Future<void> Function(String id) onHistoryDelete;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Padding(
      key: const ValueKey<String>('calc-layout-ipad-portrait'),
      padding: EdgeInsets.all(spacing.s7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 280,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _CalcToolList(
                  state: state,
                  onChanged: onToolChanged,
                  dimmed: restoringHistory,
                ),
                SizedBox(height: spacing.s6),
                _CalcFormPane(
                  state: state,
                  focusNodes: focusNodes,
                  onChanged: onFieldChanged,
                  onSexChanged: onSexChanged,
                  dimmed: restoringHistory,
                ),
              ],
            ),
          ),
          SizedBox(width: spacing.s6),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _CalcResultPane(
                  state: state,
                  restoringHistory: restoringHistory,
                  restoringProgressValue: restoringProgressValue,
                ),
                SizedBox(height: spacing.s3),
                _CalcHistoryPane(
                  state: state,
                  onToggle: onHistoryToggle,
                  onRestore: onHistoryRestore,
                  onDelete: onHistoryDelete,
                  dimmed: restoringHistory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CalcIPadLandscapeLayout extends StatelessWidget {
  const _CalcIPadLandscapeLayout({
    required this.state,
    required this.restoringHistory,
    required this.restoringProgressValue,
    required this.focusNodes,
    required this.onToolChanged,
    required this.onFieldChanged,
    required this.onSexChanged,
    required this.onHistoryToggle,
    required this.onHistoryRestore,
    required this.onHistoryDelete,
  });

  final CalcScreenState state;
  final bool restoringHistory;
  final double? restoringProgressValue;
  final Map<CalcInputFieldKey, FocusNode> focusNodes;
  final ValueChanged<CalcType> onToolChanged;
  final void Function(CalcInputFieldKey field, String value) onFieldChanged;
  final ValueChanged<Sex> onSexChanged;
  final VoidCallback onHistoryToggle;
  final ValueChanged<CalculationHistoryEntry> onHistoryRestore;
  final Future<void> Function(String id) onHistoryDelete;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Padding(
      key: const ValueKey<String>('calc-layout-ipad-landscape'),
      padding: EdgeInsets.all(spacing.s7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 440,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _CalcToolList(
                  state: state,
                  onChanged: onToolChanged,
                  dimmed: restoringHistory,
                ),
                SizedBox(height: spacing.s6),
                _CalcFormPane(
                  state: state,
                  focusNodes: focusNodes,
                  onChanged: onFieldChanged,
                  onSexChanged: onSexChanged,
                  dimmed: restoringHistory,
                ),
              ],
            ),
          ),
          SizedBox(width: spacing.s6),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _CalcResultPane(
                  state: state,
                  restoringHistory: restoringHistory,
                  restoringProgressValue: restoringProgressValue,
                ),
                SizedBox(height: spacing.s3),
                _CalcHistoryPane(
                  state: state,
                  onToggle: onHistoryToggle,
                  onRestore: onHistoryRestore,
                  onDelete: onHistoryDelete,
                  dimmed: restoringHistory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CalcFormPane extends StatelessWidget {
  const _CalcFormPane({
    required this.state,
    required this.focusNodes,
    required this.onChanged,
    required this.onSexChanged,
    required this.dimmed,
  });

  final CalcScreenState state;
  final Map<CalcInputFieldKey, FocusNode> focusNodes;
  final void Function(CalcInputFieldKey field, String value) onChanged;
  final ValueChanged<Sex> onSexChanged;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return _RestoringDim(
      dimmed: dimmed,
      child: KeyedSubtree(
        key: const ValueKey<String>('calc-form-pane'),
        child: _CalcForm(
          state: state,
          focusNodes: focusNodes,
          onChanged: onChanged,
          onSexChanged: onSexChanged,
        ),
      ),
    );
  }
}

class _CalcResultPane extends StatelessWidget {
  const _CalcResultPane({
    required this.state,
    required this.restoringHistory,
    required this.restoringProgressValue,
  });

  final CalcScreenState state;
  final bool restoringHistory;
  final double? restoringProgressValue;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: const ValueKey<String>('calc-result-pane'),
      child: _CalcResult(
        state: state,
        restoringHistory: restoringHistory,
        restoringProgressValue: restoringProgressValue,
      ),
    );
  }
}

class _CalcHistoryPane extends StatelessWidget {
  const _CalcHistoryPane({
    required this.state,
    required this.onToggle,
    required this.onRestore,
    required this.onDelete,
    required this.dimmed,
  });

  final CalcScreenState state;
  final VoidCallback onToggle;
  final ValueChanged<CalculationHistoryEntry> onRestore;
  final Future<void> Function(String id) onDelete;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return _RestoringDim(
      dimmed: dimmed,
      child: KeyedSubtree(
        key: const ValueKey<String>('calc-history-pane'),
        child: _CalcHistorySection(
          state: state,
          onToggle: onToggle,
          onRestore: onRestore,
          onDelete: onDelete,
        ),
      ),
    );
  }
}

class _CalcToolSegmentedControl extends StatelessWidget {
  const _CalcToolSegmentedControl({
    required this.state,
    required this.onChanged,
    this.dimmed = false,
    this.height,
    super.key,
  });

  final CalcScreenState state;
  final ValueChanged<CalcType> onChanged;
  final bool dimmed;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final largeText = MediaQuery.textScalerOf(context).scale(16) >= 20.8;

    return _RestoringDim(
      dimmed: dimmed,
      child: CalcSegmentedControl<CalcType>(
        selectedValue: state.activeTool,
        onChanged: onChanged,
        height: height ?? (largeText ? 56 : 42),
        padding: const EdgeInsets.all(3),
        gap: 2,
        selectedRadiusInset: 3,
        selectedFontWeight: FontWeight.w700,
        unselectedFontWeight: FontWeight.w700,
        letterSpacing: 0.26,
        selectedShadowOpacity: 0.10,
        items: [
          CalcSegmentedControlItem<CalcType>(
            value: CalcType.bmi,
            label: l10n.calcToolBmi,
          ),
          CalcSegmentedControlItem<CalcType>(
            value: CalcType.egfr,
            label: l10n.calcToolEgfr,
          ),
          CalcSegmentedControlItem<CalcType>(
            value: CalcType.crcl,
            label: l10n.calcToolCrcl,
          ),
        ],
      ),
    );
  }
}

class _CalcToolList extends StatelessWidget {
  const _CalcToolList({
    required this.state,
    required this.onChanged,
    required this.dimmed,
  });

  final CalcScreenState state;
  final ValueChanged<CalcType> onChanged;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final items = [
      (
        type: CalcType.bmi,
        label: l10n.calcToolBmi,
        formula: l10n.calcFormulaBmi,
        icon: Symbols.monitor_weight,
      ),
      (
        type: CalcType.egfr,
        label: l10n.calcToolEgfr,
        formula: l10n.calcFormulaEgfr,
        icon: Symbols.water_drop,
      ),
      (
        type: CalcType.crcl,
        label: l10n.calcToolCrcl,
        formula: l10n.calcFormulaCrcl,
        icon: Symbols.science,
      ),
    ];

    return _RestoringDim(
      dimmed: dimmed,
      child: DecoratedBox(
        key: const ValueKey<String>('calc-tool-list'),
        decoration: BoxDecoration(
          color: palette.calcSurface,
          border: Border.all(color: palette.calcHairline),
          borderRadius: BorderRadius.circular(radii.card),
        ),
        child: Padding(
          padding: EdgeInsets.all(spacing.s2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              for (final item in items)
                _CalcToolListItem(
                  active: item.type == state.activeTool,
                  label: item.label,
                  formula: item.formula,
                  icon: item.icon,
                  onTap: () => onChanged(item.type),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RestoringDim extends StatelessWidget {
  const _RestoringDim({required this.dimmed, required this.child});

  final bool dimmed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!dimmed) {
      return child;
    }
    return IgnorePointer(
      child: Opacity(
        opacity: 0.42,
        child: child,
      ),
    );
  }
}

class _CalcToolListItem extends StatelessWidget {
  const _CalcToolListItem({
    required this.active,
    required this.label,
    required this.formula,
    required this.icon,
    required this.onTap,
  });

  final bool active;
  final String label;
  final String formula;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;
    final foreground = active
        ? palette.calcOnPrimaryContainer
        : palette.calcInk;
    final muted = active ? palette.calcOnPrimaryContainer : palette.calcMuted;

    return Material(
      color: active ? palette.calcPrimaryContainer : Colors.transparent,
      borderRadius: BorderRadius.circular(radii.tile),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radii.tile),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.s3 + 2,
            vertical: spacing.s3 + 2,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 20, color: muted),
              SizedBox(width: spacing.s2 + 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text(
                      label,
                      style: typography.bodyM.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      formula,
                      style: typography.monoS.copyWith(
                        color: muted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
