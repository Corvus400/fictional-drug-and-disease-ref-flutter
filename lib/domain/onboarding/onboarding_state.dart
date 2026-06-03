/// Current onboarding flow phase.
enum OnboardingPhase {
  /// No onboarding UI is currently active.
  none,

  /// Intro carousel is active.
  intro,

  /// Spotlight tour is active.
  spotlight,
}

/// State for onboarding completion and active flow phase.
final class OnboardingState {
  /// Creates onboarding state.
  const OnboardingState({required this.completed, required this.phase});

  /// Whether onboarding has been completed at least once.
  final bool completed;

  /// Current onboarding phase.
  final OnboardingPhase phase;

  /// Returns a copy with selected fields changed.
  OnboardingState copyWith({bool? completed, OnboardingPhase? phase}) {
    return OnboardingState(
      completed: completed ?? this.completed,
      phase: phase ?? this.phase,
    );
  }
}
