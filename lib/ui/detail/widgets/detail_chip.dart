import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Detail chip color source.
enum ChipKind {
  /// DosageForm W2 color map.
  dosageForm,

  /// RouteOfAdministration W2 color map.
  routeOfAdmin,

  /// PrecautionPopulationCategory W2 color map.
  precaution,

  /// Icd10Chapter W2 color map.
  icd10Chapter,

  /// OnsetPattern W2 color map.
  onsetPattern,

  /// ExamCategory W2 color map.
  examCategory,

  /// W1 semantic color source.
  w1Semantic,
}

/// Badge-like chip used on detail screens.
class DetailChip extends StatelessWidget {
  /// Creates a detail chip.
  const DetailChip({
    required this.enumKey,
    required this.enumKind,
    required this.label,
    super.key,
  });

  /// Mock-server serial name.
  final String enumKey;

  /// Enum kind used to choose a W2 color map.
  final ChipKind enumKind;

  /// User-visible label from l10n or domain data.
  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final color = _colorFor(palette);
    return Container(
      key: const ValueKey<String>('detail-chip-wrapper'),
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border.all(
          color: palette.hairline,
          width: DetailConstants.chipHostBorderWidth,
        ),
        borderRadius: BorderRadius.circular(DetailConstants.chipHostRadius),
      ),
      child: Container(
        key: const ValueKey<String>('detail-chip'),
        constraints: const BoxConstraints(
          minHeight: DetailConstants.chipMinHeight,
        ),
        decoration: BoxDecoration(color: color),
        child: Text(
          label,
          softWrap: true,
          style: const TextStyle(height: DetailConstants.chipTextHeight),
        ),
      ),
    );
  }

  Color _colorFor(AppPalette palette) {
    return switch (enumKind) {
          ChipKind.dosageForm => palette.chipDosageForm[enumKey],
          ChipKind.routeOfAdmin => palette.chipRouteOfAdmin[enumKey],
          ChipKind.precaution => palette.chipPrecaution[enumKey],
          ChipKind.icd10Chapter => palette.chipIcd10Chapter[enumKey],
          ChipKind.onsetPattern => palette.chipOnsetPattern[enumKey],
          ChipKind.examCategory => palette.chipExamCategory[enumKey],
          ChipKind.w1Semantic => null,
        } ??
        palette.ink2;
  }
}
