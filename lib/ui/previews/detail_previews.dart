// Preview entrypoints must stay public for Flutter Widget Previewer.
// ignore_for_file: avoid_redundant_argument_values, public_member_api_docs

import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_accordion.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_bookmark_footer.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_carousel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_chip.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_dose_calc_button.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_exam_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_expand_tile.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_pk_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_responsive_layout.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_serious_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_severity_grade.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_tab_button.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_warn_banner.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/previews/preview_data.dart';
import 'package:fictional_drug_and_disease_ref/ui/previews/preview_support.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';
import 'package:flutter/material.dart';

@FddScreenPreview(group: 'Drug detail', name: 'Loading')
Widget previewDrugDetailLoading() {
  return _previewDrugDetail(
    const DrugDetailScreenState.initial(),
  );
}

@FddScreenPreview(group: 'Drug detail', name: 'Error')
Widget previewDrugDetailError() {
  return _previewDrugDetail(
    const DrugDetailScreenState(
      phase: DrugDetailErrorPhase(NetworkException()),
      activeTab: DrugDetailTab.overview,
      isBookmarked: false,
      isBookmarkBusy: false,
      bookmarkError: null,
    ),
  );
}

@FddScreenPreview(group: 'Drug detail', name: 'Overview tab')
Widget previewDrugDetailOverview() {
  return _previewDrugDetail(previewDrugDetailState(DrugDetailTab.overview));
}

@FddScreenPreview(group: 'Drug detail', name: 'Dose tab')
Widget previewDrugDetailDose() {
  return _previewDrugDetail(previewDrugDetailState(DrugDetailTab.dose));
}

@FddScreenPreview(group: 'Drug detail', name: 'Caution tab')
Widget previewDrugDetailCaution() {
  return _previewDrugDetail(previewDrugDetailState(DrugDetailTab.caution));
}

@FddScreenPreview(group: 'Drug detail', name: 'Adverse effects tab')
Widget previewDrugDetailAdverseEffects() {
  return _previewDrugDetail(
    previewDrugDetailState(DrugDetailTab.adverseEffects),
  );
}

@FddScreenPreview(group: 'Drug detail', name: 'Pharmacokinetics tab')
Widget previewDrugDetailPharmacokinetics() {
  return _previewDrugDetail(
    previewDrugDetailState(DrugDetailTab.pharmacokinetics),
  );
}

@FddScreenPreview(group: 'Drug detail', name: 'Related tab')
Widget previewDrugDetailRelated() {
  return _previewDrugDetail(previewDrugDetailState(DrugDetailTab.related));
}

@FddScreenPreview(group: 'Disease detail', name: 'Loading')
Widget previewDiseaseDetailLoading() {
  return _previewDiseaseDetail(
    const DiseaseDetailScreenState.initial(),
  );
}

@FddScreenPreview(group: 'Disease detail', name: 'Error')
Widget previewDiseaseDetailError() {
  return _previewDiseaseDetail(
    const DiseaseDetailScreenState(
      phase: DiseaseDetailErrorPhase(NetworkException()),
      activeTab: DiseaseDetailTab.overview,
      isBookmarked: false,
      isBookmarkBusy: false,
      bookmarkError: null,
    ),
  );
}

@FddScreenPreview(group: 'Disease detail', name: 'Overview tab')
Widget previewDiseaseDetailOverview() {
  return _previewDiseaseDetail(
    previewDiseaseDetailState(DiseaseDetailTab.overview),
  );
}

@FddScreenPreview(group: 'Disease detail', name: 'Diagnosis tab')
Widget previewDiseaseDetailDiagnosis() {
  return _previewDiseaseDetail(
    previewDiseaseDetailState(DiseaseDetailTab.diagnosis),
  );
}

@FddScreenPreview(group: 'Disease detail', name: 'Treatment tab')
Widget previewDiseaseDetailTreatment() {
  return _previewDiseaseDetail(
    previewDiseaseDetailState(DiseaseDetailTab.treatment),
  );
}

@FddScreenPreview(group: 'Disease detail', name: 'Clinical course tab')
Widget previewDiseaseDetailClinicalCourse() {
  return _previewDiseaseDetail(
    previewDiseaseDetailState(DiseaseDetailTab.clinicalCourse),
  );
}

@FddScreenPreview(group: 'Disease detail', name: 'Related tab')
Widget previewDiseaseDetailRelated() {
  return _previewDiseaseDetail(
    previewDiseaseDetailState(DiseaseDetailTab.related),
  );
}

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
            const DetailExamTable(
              nameHeader: '検査',
              categoryHeader: '区分',
              findingHeader: '所見',
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
            const SizedBox(height: 16),
            const DetailPkTable(
              itemHeader: '項目',
              valueHeader: '値',
              rows: [
                DetailPkParameter(name: 'Tmax', value: '6-8 h'),
                DetailPkParameter(name: 'T1/2', value: '約35 h'),
              ],
            ),
          ],
        ),
      );
    },
  );
}

@FddComponentPreview(group: 'Detail shared', name: 'Badges and warnings')
Widget previewDetailWarningGallery() {
  return const SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DetailWarnBanner(items: ['過度の血圧低下に注意して投与する。']),
        SizedBox(height: 16),
        DetailSeriousCard(
          name: '過度の血圧低下',
          description: 'ふらつき、失神、めまいがあらわれることがある。',
          meta: ['頻度不明', '減量または休薬'],
        ),
        SizedBox(height: 16),
        DetailSeverityGrade(
          label: 'II度',
          criteria: '160-179/100-109mmHg',
          recommendedAction: '薬物療法を検討する。',
        ),
      ],
    ),
  );
}

@FddComponentPreview(group: 'Detail shared', name: 'Controls')
Widget previewDetailControlsGallery() {
  return Builder(
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DetailResponsiveLayout(
            tabs: [
              DetailTabButton(
                label: l10n.detailDrugTabOverview,
                selected: true,
                sectionNumber: 1,
                onPressed: () {},
              ),
              DetailTabButton(
                label: l10n.detailDrugTabDose,
                selected: false,
                sectionNumber: 2,
                onPressed: () {},
              ),
            ],
            activeBody: const DetailMarkdownBody(
              data: '本文中の **強調** と箇条書きを確認するためのテキスト。',
            ),
            footer: DetailBookmarkFooter(
              isBookmarked: true,
              isBusy: false,
              bookmarkError: null,
              onToggleBookmark: () {},
              onClearBookmarkError: () {},
              trailing: DetailDoseCalcButton(
                label: l10n.detailDoseCalculatorLabel,
                onPressed: () {},
              ),
            ),
          ),
        ],
      );
    },
  );
}

@FddComponentPreview(group: 'Detail shared', name: 'Carousel and disclosure')
Widget previewDetailCarouselGallery() {
  return const SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DetailCarousel(
          children: [
            DetailCarouselCard(
              title: '本態性高血圧症',
              subtitle: 'disease_001',
              badges: ['慢性'],
            ),
            DetailCarouselCard(
              title: '市中肺炎',
              subtitle: 'disease_028',
              badges: ['急性', '感染性'],
            ),
          ],
        ),
        SizedBox(height: 16),
        DetailAccordion(
          title: '参考情報',
          child: Text('開閉できる詳細情報のプレビュー。'),
        ),
        DetailExpandTile(
          title: '架空添付文書 2026年5月改訂',
          body: '社内資料',
          initiallyExpanded: true,
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            DetailChip(label: '処方箋医薬品'),
            DetailChip(label: '経口'),
            DetailChip(label: '錠剤'),
          ],
        ),
      ],
    ),
  );
}

Widget _previewDrugDetail(DrugDetailScreenState state) {
  return previewProviderScope(
    overrides: [
      ...previewApiOverrides(),
      drugDetailHeroImageCacheManagerProvider.overrideWithValue(
        previewFailingCacheManager,
      ),
      drugDetailScreenProvider(previewDrug.id).overrideWithBuild(
        (ref, notifier) => state,
      ),
    ],
    child: DrugDetailView(id: previewDrug.id),
  );
}

Widget _previewDiseaseDetail(DiseaseDetailScreenState state) {
  return previewProviderScope(
    overrides: [
      ...previewApiOverrides(),
      drugCardImageCacheManagerProvider.overrideWithValue(
        previewFailingCacheManager,
      ),
      diseaseDetailScreenProvider(previewDisease.id).overrideWithBuild(
        (ref, notifier) => state,
      ),
    ],
    child: DiseaseDetailView(id: previewDisease.id),
  );
}
