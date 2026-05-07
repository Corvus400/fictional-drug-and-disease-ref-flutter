import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:flutter/material.dart';

/// Clinical course tab for disease detail.
class DiseaseDetailClinicalCourseTab extends StatelessWidget {
  /// Creates a clinical course tab.
  const DiseaseDetailClinicalCourseTab({required this.disease, super.key});

  /// Disease detail model.
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailPanel(
          sectionIndex: 'E13',
          title: l10n.detailDiseaseSectionPrognosis,
          child: disease.prognosis == null
              ? const SizedBox.shrink()
              : _BodyText(disease.prognosis!),
        ),
        DetailPanel(
          sectionIndex: 'E14',
          title: l10n.detailDiseaseSectionPrevention,
          showBottomDivider: false,
          child: _NumberedTextList(items: disease.prevention),
        ),
      ],
    );
  }
}

class _NumberedTextList extends StatelessWidget {
  const _NumberedTextList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, item) in items.indexed)
          _NumberedText(index: index + 1, text: item),
      ],
    );
  }
}

class _NumberedText extends StatelessWidget {
  const _NumberedText({required this.index, required this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: DetailConstants.gapXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index. ',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: DetailConstants.kvFontSize,
              fontWeight: FontWeight.w700,
              height: DetailConstants.bodyTextLineHeight,
            ),
          ),
          Expanded(child: _BodyText(text)),
        ],
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Text(
      text,
      style: TextStyle(
        color: colors.onSurface,
        fontSize: DetailConstants.kvFontSize,
        height: DetailConstants.bodyTextLineHeight,
      ),
    );
  }
}
