// Preview entrypoints must stay public for Flutter Widget Previewer.
// ignore_for_file: public_member_api_docs

import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_chip.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_exam_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_pk_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_warn_banner.dart';
import 'package:fictional_drug_and_disease_ref/ui/previews/preview_support.dart';
import 'package:flutter/material.dart';

@FddComponentPreview(group: 'Detail shared', name: 'Panels and tables')
Widget previewDetailPanelGallery() {
  return Builder(
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DetailPanel(
              sectionIndex: 'D1',
              title: l10n.detailDrugSectionComposition,
              child: const Column(
                children: [
                  DetailKvRow(
                    label: '有効成分',
                    value: 'アムロジピンベシル酸塩 5mg',
                    showTopBorder: true,
                  ),
                  DetailKvRow(label: '剤形', value: '錠剤'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const DetailExamTable(
              rows: [
                DetailExamRow(
                  name: '血圧測定',
                  category: 'vital',
                  finding: '持続的な血圧高値',
                ),
                DetailExamRow(
                  name: '血清Cr',
                  category: 'blood',
                  finding: '腎機能評価',
                ),
              ],
            ),
            const SizedBox(height: 12),
            const DetailPkTable(
              itemHeader: '項目',
              valueHeader: '値',
              rows: [
                DetailPkParameter(name: 'Tmax', value: '6-8時間'),
                DetailPkParameter(name: '半減期', value: '約35時間'),
              ],
            ),
          ],
        ),
      );
    },
  );
}

@FddComponentPreview(group: 'Detail shared', name: 'Badges and warning')
Widget previewDetailBadgeGallery() {
  return const SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            DetailBadge(label: '処方箋医薬品'),
            DetailBadge(label: '循環器系'),
            DetailChip(label: '内科'),
            DetailChip(label: '慢性'),
          ],
        ),
        SizedBox(height: 12),
        DetailWarnBanner(items: ['妊婦、高齢者、腎機能低下例では慎重に評価する']),
      ],
    ),
  );
}
