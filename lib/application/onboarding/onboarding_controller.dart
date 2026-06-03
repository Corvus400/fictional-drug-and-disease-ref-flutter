import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/onboarding/onboarding_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controls onboarding completion and flow phase.
final class OnboardingController extends AsyncNotifier<OnboardingState> {
  @override
  Future<OnboardingState> build() async {
    final result = await ref.watch(onboardingRepositoryProvider).read();
    final completed = switch (result) {
      Ok<bool>(:final value) => value,
      Err<bool>() => false,
    };
    return OnboardingState(
      completed: completed,
      phase: completed ? OnboardingPhase.none : OnboardingPhase.intro,
    );
  }

  /// Skips the full onboarding flow.
  Future<void> skip() async {
    await _markCompleted();
  }

  /// Completes the full onboarding flow.
  Future<void> complete() async {
    await _markCompleted();
  }

  Future<void> _markCompleted() async {
    await ref.read(onboardingRepositoryProvider).write(completed: true);
    state = const AsyncData(
      OnboardingState(completed: true, phase: OnboardingPhase.none),
    );
  }

  /// Starts the spotlight tour after the intro carousel.
  void startSpotlight() {
    final current = state.value;
    if (current == null) {
      return;
    }
    state = AsyncData(current.copyWith(phase: OnboardingPhase.spotlight));
  }

  /// Replays onboarding from the intro carousel.
  void replay() {
    final current = state.value;
    if (current == null) {
      return;
    }
    state = AsyncData(current.copyWith(phase: OnboardingPhase.intro));
  }
}
