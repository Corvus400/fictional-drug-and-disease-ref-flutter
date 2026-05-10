part of 'calc_view.dart';

class _CalcHistorySection extends StatelessWidget {
  const _CalcHistorySection({
    required this.state,
    required this.onToggle,
    required this.onRestore,
    required this.onDelete,
  });

  static const _inputsCodec = CalculationInputsCodec();
  static const _resultCodec = CalculationResultCodec();

  final CalcScreenState state;
  final VoidCallback onToggle;
  final ValueChanged<CalculationHistoryEntry> onRestore;
  final Future<void> Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final isEmpty =
        state.historyPhase == CalcHistoryPhase.empty || state.history.isEmpty;
    final showBody = state.historyExpanded || isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _CalcHistoryHeader(
          count: state.history.length,
          expanded: showBody,
          onToggle: isEmpty ? null : onToggle,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          reverseDuration: const Duration(milliseconds: 320),
          switchInCurve: const Cubic(.2, 0, 0, 1),
          switchOutCurve: const Cubic(.2, 0, 0, 1),
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                ...previousChildren,
                ?currentChild,
              ],
            );
          },
          transitionBuilder: (child, animation) {
            return ClipRect(
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: -1,
                child: FadeTransition(opacity: animation, child: child),
              ),
            );
          },
          child: showBody
              ? Column(
                  key: ValueKey<String>(
                    'calc-history-body-${isEmpty ? 'empty' : 'list'}-'
                    '${state.history.length}',
                  ),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: spacing.s2 - 2),
                    if (isEmpty)
                      CalcHistoryEmptyState(message: l10n.calcHistoryEmpty)
                    else
                      _CalcHistoryList(
                        deleteLabel: l10n.calcHistoryActionDelete,
                        rows: [
                          for (final indexed in state.history.indexed)
                            _CalcHistoryRowData.fromEntry(
                              entry: indexed.$2,
                              l10n: l10n,
                              inputsCodec: _inputsCodec,
                              resultCodec: _resultCodec,
                              showBottomBorder:
                                  indexed.$1 != state.history.length - 1,
                            ),
                        ],
                        onRestore: onRestore,
                        onDelete: onDelete,
                      ),
                  ],
                )
              : const SizedBox.shrink(
                  key: ValueKey<String>('calc-history-body-collapsed'),
                ),
        ),
      ],
    );
  }
}

class _CalcHistoryHeader extends StatelessWidget {
  const _CalcHistoryHeader({
    required this.count,
    required this.expanded,
    required this.onToggle,
  });

  final int count;
  final bool expanded;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radii.card),
        onTap: onToggle,
        child: Ink(
          decoration: BoxDecoration(
            color: palette.calcSurface,
            border: Border.all(color: palette.calcHairline),
            borderRadius: BorderRadius.circular(radii.card),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.s3,
              vertical: spacing.s2,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${l10n.calcHistoryHeader} ($count)',
                    style: typography.labelM
                        .copyWith(color: palette.calcInk)
                        .withVariableWeight(FontWeight.w700),
                  ),
                ),
                Icon(
                  key: const ValueKey<String>('calc-history-header-icon'),
                  count == 0
                      ? Icons.history_toggle_off
                      : expanded
                      ? Icons.expand_less
                      : Icons.expand_more,
                  size: 18,
                  color: count == 0 ? palette.calcMuted2 : palette.calcMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CalcHistoryList extends StatelessWidget {
  const _CalcHistoryList({
    required this.deleteLabel,
    required this.rows,
    required this.onRestore,
    required this.onDelete,
  });

  final String deleteLabel;
  final List<_CalcHistoryRowData> rows;
  final ValueChanged<CalculationHistoryEntry> onRestore;
  final Future<void> Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final showScrollHint = rows.length > 5;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.calcSurface,
        border: Border.all(color: palette.calcHairline),
        borderRadius: BorderRadius.circular(radii.card),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radii.card),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 220),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    for (final indexed in rows.indexed)
                      CalcHistoryRow(
                        key: ValueKey<String>(
                          'calc-history-${indexed.$2.entry.id}',
                        ),
                        dateText: indexed.$2.dateText,
                        resultText: indexed.$2.resultText,
                        summaryText: indexed.$2.summaryText,
                        deleteLabel: deleteLabel,
                        showBottomBorder: indexed.$2.showBottomBorder,
                        borderRadius: _historyRowRightRadius(
                          index: indexed.$1,
                          count: rows.length,
                          radius: radii.card,
                        ),
                        onRestore: () => onRestore(indexed.$2.entry),
                        onDelete: () => onDelete(indexed.$2.entry.id),
                      ),
                  ],
                ),
              ),
              if (showScrollHint)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 18,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            palette.calcSurface.withValues(alpha: 0),
                            palette.calcSurface,
                          ],
                        ),
                      ),
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

BorderRadius _historyRowRightRadius({
  required int index,
  required int count,
  required double radius,
}) {
  if (count <= 0) {
    return BorderRadius.zero;
  }

  final isFirst = index == 0;
  final isLast = index == count - 1;
  return BorderRadius.only(
    topRight: isFirst ? Radius.circular(radius) : Radius.zero,
    bottomRight: isLast ? Radius.circular(radius) : Radius.zero,
  );
}

class _CalcHistoryRowData {
  const _CalcHistoryRowData({
    required this.entry,
    required this.dateText,
    required this.resultText,
    required this.summaryText,
    required this.showBottomBorder,
  });

  factory _CalcHistoryRowData.fromEntry({
    required CalculationHistoryEntry entry,
    required AppLocalizations l10n,
    required CalculationInputsCodec inputsCodec,
    required CalculationResultCodec resultCodec,
    required bool showBottomBorder,
  }) {
    try {
      final calcType = CalcType.parse(entry.calcType);
      final inputs = inputsCodec.decode(calcType, entry.inputsJson);
      final result = resultCodec.decode(calcType, entry.resultJson);
      return _CalcHistoryRowData(
        entry: entry,
        dateText: _formatDate(entry.calculatedAt),
        resultText: _historyResultText(l10n, calcType, result),
        summaryText: _historySummaryText(l10n, inputs),
        showBottomBorder: showBottomBorder,
      );
    } on Object {
      return _CalcHistoryRowData(
        entry: entry,
        dateText: _formatDate(entry.calculatedAt),
        resultText: entry.calcType,
        summaryText: '--',
        showBottomBorder: showBottomBorder,
      );
    }
  }

  final CalculationHistoryEntry entry;
  final String dateText;
  final String resultText;
  final String summaryText;
  final bool showBottomBorder;
}

String _historyResultText(
  AppLocalizations l10n,
  CalcType calcType,
  Object result,
) {
  return switch ((calcType, result)) {
    (CalcType.bmi, BmiResult(:final bmi, :final category)) =>
      'BMI ${_formatFixed(bmi, 1)} (${_bmiCategoryLabel(l10n, category)})',
    (CalcType.egfr, EgfrResult(:final eGfrMlMin173m2, :final stage)) => [
      'eGFR ${_formatFixed(eGfrMlMin173m2, 1)}',
      '(${_ckdStageLabel(l10n, stage)})',
    ].join(' '),
    (CalcType.crcl, CrClResult(:final crClMlMin)) =>
      'CrCl ${_formatFixed(crClMlMin, 1)}',
    _ => '--',
  };
}

String _historySummaryText(AppLocalizations l10n, Object inputs) {
  return switch (inputs) {
    BmiInputs(:final heightCm, :final weightKg) =>
      'H${_formatNumber(heightCm)}/W${_formatNumber(weightKg)}',
    EgfrInputs(:final ageYears, :final sex, :final serumCreatinineMgDl) =>
      '$ageYears歳/${_sexLabel(l10n, sex)}/Cr${_formatNumber(serumCreatinineMgDl)}',
    CrClInputs(
      :final ageYears,
      :final sex,
      :final weightKg,
      :final serumCreatinineMgDl,
    ) =>
      '$ageYears歳/${_sexLabel(l10n, sex)}/W${_formatNumber(weightKg)}/Cr${_formatNumber(serumCreatinineMgDl)}',
    _ => '--',
  };
}

String _sexLabel(AppLocalizations l10n, Sex sex) {
  return switch (sex) {
    Sex.male => l10n.calcSexMale,
    Sex.female => l10n.calcSexFemale,
  };
}

String _formatDate(DateTime value) {
  final local = value.toLocal();
  return [
    local.year.toString().padLeft(4, '0'),
    local.month.toString().padLeft(2, '0'),
    local.day.toString().padLeft(2, '0'),
  ].join('/');
}
