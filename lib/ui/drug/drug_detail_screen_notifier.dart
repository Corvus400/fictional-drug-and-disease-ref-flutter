import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/view_drug_detail_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Drug detail screen notifier provider.
// ignore: specify_nonobvious_property_types
final drugDetailScreenProvider = NotifierProvider.autoDispose
    .family<DrugDetailScreenNotifier, DrugDetailScreenState, String>(
      DrugDetailScreenNotifier.new,
    );

/// ViewModel for the drug detail screen.
final class DrugDetailScreenNotifier extends Notifier<DrugDetailScreenState> {
  /// Creates a notifier for a drug detail id.
  DrugDetailScreenNotifier(this._id);

  final String _id;

  @override
  DrugDetailScreenState build() {
    ref.listen(streamBookmarkStateProvider(_id), (_, next) {
      if (next case AsyncData<bool>(:final value)) {
        state = state.copyWith(isBookmarked: value);
      }
    });
    unawaited(Future.microtask(load));
    return const DrugDetailScreenState.initial();
  }

  /// Loads the drug detail.
  Future<void> load() async {
    final result = await ref.read(viewDrugDetailUsecaseProvider).execute(_id);
    if (!ref.mounted) {
      return;
    }
    if (result case DrugDetailLoaded(:final drug, :final isBookmarked)) {
      state = state.copyWith(
        phase: DrugDetailLoadedPhase(drug),
        isBookmarked: isBookmarked,
        clearBookmarkError: true,
      );
      return;
    }
    if (result case DrugDetailOfflineFallback(:final cause)) {
      state = state.copyWith(
        phase: DrugDetailErrorPhase(cause),
        clearBookmarkError: true,
      );
      return;
    }
    if (result case DrugDetailFailure(:final error)) {
      state = state.copyWith(
        phase: DrugDetailErrorPhase(error),
        isBookmarked: false,
        clearBookmarkError: true,
      );
    }
  }

  /// Selects the active detail tab.
  void selectTab(DrugDetailTab tab) {
    state = state.copyWith(activeTab: tab);
  }

  /// Clears the latest bookmark mutation error.
  void clearBookmarkError() {
    state = state.copyWith(clearBookmarkError: true);
  }

  /// Retries loading the drug detail.
  Future<void> retry() async {
    state = state.copyWith(
      phase: const DrugDetailLoadingPhase(),
      isBookmarkBusy: false,
      clearBookmarkError: true,
    );
    await load();
  }

  /// Toggles the bookmark state for the loaded drug.
  Future<void> toggleBookmark() async {
    final phase = state.phase;
    if (phase is! DrugDetailLoadedPhase || state.isBookmarkBusy) {
      return;
    }
    final nextBookmarked = !state.isBookmarked;
    state = state.copyWith(isBookmarkBusy: true, clearBookmarkError: true);
    final result = await ref
        .read(toggleBookmarkUsecaseProvider)
        .toggleDrug(
          drug: phase.drug,
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
