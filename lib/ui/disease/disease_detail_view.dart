import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/error_message_mapper.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_bookmark_footer.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_clinical_course_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_diagnosis_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_overview_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_related_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_treatment_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Disease detail placeholder.
class DiseaseDetailView extends ConsumerWidget {
  /// Creates a disease detail view.
  const DiseaseDetailView({required this.id, super.key});

  /// Disease identifier.
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(diseaseDetailScreenProvider(id));
    final notifier = ref.read(diseaseDetailScreenProvider(id).notifier);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.diseaseDetailTitle)),
      body: switch (state.phase) {
        DiseaseDetailLoadingPhase() => const Center(
          child: CircularProgressIndicator(),
        ),
        DiseaseDetailErrorPhase(:final error) => _DetailErrorView(
          error: error,
          onRetry: notifier.retry,
        ),
        DiseaseDetailLoadedPhase(:final disease) => _DiseaseLoadedView(
          state: state,
          disease: disease,
          onSelectTab: notifier.selectTab,
          onToggleBookmark: notifier.toggleBookmark,
          onClearBookmarkError: notifier.clearBookmarkError,
        ),
      },
    );
  }
}

class _DiseaseLoadedView extends StatelessWidget {
  const _DiseaseLoadedView({
    required this.state,
    required this.disease,
    required this.onSelectTab,
    required this.onToggleBookmark,
    required this.onClearBookmarkError,
  });

  final DiseaseDetailScreenState state;
  final Disease disease;
  final ValueChanged<DiseaseDetailTab> onSelectTab;
  final VoidCallback onToggleBookmark;
  final VoidCallback onClearBookmarkError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(DetailConstants.contentPadding),
            children: [
              Text(disease.id),
              Text(
                disease.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(disease.nameKana),
              const SizedBox(height: DetailConstants.gapM),
              Wrap(
                spacing: DetailConstants.gapS,
                runSpacing: DetailConstants.gapS,
                children: [
                  for (final tab in DiseaseDetailTab.values)
                    ChoiceChip(
                      label: Text(_diseaseTabLabel(l10n, tab)),
                      selected: state.activeTab == tab,
                      onSelected: (_) => onSelectTab(tab),
                    ),
                ],
              ),
              const SizedBox(height: DetailConstants.gapM),
              AnimatedSwitcher(
                key: const ValueKey('disease-detail-active-tab-switcher'),
                duration: DetailConstants.tabSwitchDuration,
                child: _activeDiseaseTabBody(l10n, disease, state.activeTab),
              ),
            ],
          ),
        ),
        DetailBookmarkFooter(
          isBookmarked: state.isBookmarked,
          isBusy: state.isBookmarkBusy,
          bookmarkError: state.bookmarkError,
          onToggleBookmark: onToggleBookmark,
          onClearBookmarkError: onClearBookmarkError,
        ),
      ],
    );
  }
}

class _DetailErrorView extends StatelessWidget {
  const _DetailErrorView({
    required this.error,
    required this.onRetry,
  });

  final AppException error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            size: DetailConstants.errorIconSize,
          ),
          const SizedBox(height: DetailConstants.gapM),
          Text(_detailErrorMessage(l10n, error), textAlign: TextAlign.center),
          const SizedBox(height: DetailConstants.gapL),
          SizedBox(
            width: DetailConstants.retryButtonWidth,
            child: FilledButton(
              onPressed: onRetry,
              child: Text(l10n.detailRetry),
            ),
          ),
        ],
      ),
    );
  }
}

String _detailErrorMessage(AppLocalizations l10n, AppException error) {
  return switch (errorKeyFor(error)) {
    'errNetwork' => l10n.errNetwork,
    'errServer' => l10n.errServer,
    'errApiNotFound' => l10n.errApiNotFound,
    'errApiBadRequest' => l10n.errApiBadRequest,
    'errApiInvalidCategory' => l10n.errApiInvalidCategory,
    'errParse' => l10n.errParse,
    'errStorageUnique' => l10n.errStorageUnique,
    'errStorageCheck' => l10n.errStorageCheck,
    'errStorageGeneric' => l10n.errStorageGeneric,
    'errApi4xx' => l10n.errApi4xx(error is ApiException ? error.message : ''),
    _ => l10n.errUnknown,
  };
}

String _diseaseTabLabel(AppLocalizations l10n, DiseaseDetailTab tab) {
  return switch (tab) {
    DiseaseDetailTab.overview => l10n.detailDiseaseTabOverview,
    DiseaseDetailTab.diagnosis => l10n.detailDiseaseTabDiagnosis,
    DiseaseDetailTab.treatment => l10n.detailDiseaseTabTreatment,
    DiseaseDetailTab.clinicalCourse => l10n.detailDiseaseTabClinicalCourse,
    DiseaseDetailTab.related => l10n.detailDiseaseTabRelated,
  };
}

Widget _activeDiseaseTabBody(
  AppLocalizations l10n,
  Disease disease,
  DiseaseDetailTab activeTab,
) {
  return switch (activeTab) {
    DiseaseDetailTab.overview => DiseaseDetailOverviewTab(
      key: const ValueKey('disease-detail-active-tab-body'),
      disease: disease,
    ),
    DiseaseDetailTab.diagnosis => DiseaseDetailDiagnosisTab(
      key: const ValueKey('disease-detail-active-tab-body'),
      disease: disease,
    ),
    DiseaseDetailTab.treatment => DiseaseDetailTreatmentTab(
      key: const ValueKey('disease-detail-active-tab-body'),
      disease: disease,
    ),
    DiseaseDetailTab.clinicalCourse => DiseaseDetailClinicalCourseTab(
      key: const ValueKey('disease-detail-active-tab-body'),
      disease: disease,
    ),
    DiseaseDetailTab.related => DiseaseDetailRelatedTab(
      key: const ValueKey('disease-detail-active-tab-body'),
      disease: disease,
    ),
  };
}
