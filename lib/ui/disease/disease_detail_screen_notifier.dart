import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/view_disease_detail_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Disease detail screen notifier provider.
// ignore: specify_nonobvious_property_types
final diseaseDetailScreenProvider = NotifierProvider.autoDispose
    .family<DiseaseDetailScreenNotifier, DiseaseDetailScreenState, String>(
      DiseaseDetailScreenNotifier.new,
    );

/// ViewModel for the disease detail screen.
final class DiseaseDetailScreenNotifier
    extends Notifier<DiseaseDetailScreenState> {
  /// Creates a notifier for a disease detail id.
  DiseaseDetailScreenNotifier(this._id);

  final String _id;

  @override
  DiseaseDetailScreenState build() {
    ref.listen(streamBookmarkStateProvider(_id), (_, next) {
      if (next case AsyncData<bool>(:final value)) {
        state = state.copyWith(isBookmarked: value);
      }
    });
    unawaited(Future.microtask(load));
    return const DiseaseDetailScreenState.initial();
  }

  /// Loads the disease detail.
  Future<void> load() async {
    final result = await ref
        .read(viewDiseaseDetailUsecaseProvider)
        .execute(_id);
    if (!ref.mounted) {
      return;
    }
    if (result case DiseaseDetailLoaded(:final disease, :final isBookmarked)) {
      state = state.copyWith(
        phase: DiseaseDetailLoadedPhase(disease),
        isBookmarked: isBookmarked,
        clearBookmarkError: true,
      );
      return;
    }
    if (result case DiseaseDetailOfflineFallback(:final cause)) {
      state = state.copyWith(
        phase: DiseaseDetailErrorPhase(cause),
        clearBookmarkError: true,
      );
      return;
    }
    if (result case DiseaseDetailFailure(:final error)) {
      state = state.copyWith(
        phase: DiseaseDetailErrorPhase(error),
        isBookmarked: false,
        clearBookmarkError: true,
      );
    }
  }

  /// Selects the active detail tab.
  void selectTab(DiseaseDetailTab tab) {
    state = state.copyWith(activeTab: tab);
  }

  /// Clears the latest bookmark mutation error.
  void clearBookmarkError() {
    state = state.copyWith(clearBookmarkError: true);
  }

  /// Retries loading the disease detail.
  Future<void> retry() async {
    state = state.copyWith(
      phase: const DiseaseDetailLoadingPhase(),
      isBookmarkBusy: false,
      clearBookmarkError: true,
    );
    await load();
  }

  /// Toggles the bookmark state for the loaded disease.
  Future<void> toggleBookmark() async {
    final phase = state.phase;
    if (phase is! DiseaseDetailLoadedPhase || state.isBookmarkBusy) {
      return;
    }
    final nextBookmarked = !state.isBookmarked;
    state = state.copyWith(isBookmarkBusy: true, clearBookmarkError: true);
    final result = await ref
        .read(toggleBookmarkUsecaseProvider)
        .toggleDisease(
          disease: phase.disease,
          currentlyBookmarked: state.isBookmarked,
        );
    if (!ref.mounted) {
      return;
    }
    if (result is Ok<void>) {
      state = state.copyWith(
        isBookmarked: nextBookmarked,
        isBookmarkBusy: false,
        clearBookmarkError: true,
      );
      return;
    }
    if (result case Err<void>(:final error)) {
      state = state.copyWith(
        isBookmarkBusy: false,
        bookmarkError: error,
      );
    }
  }
}
