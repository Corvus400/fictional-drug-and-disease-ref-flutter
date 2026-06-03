import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';

/// Repository for onboarding completion state.
final class OnboardingRepository {
  /// Creates an onboarding repository.
  const OnboardingRepository(this._service);

  final OnboardingService _service;

  /// Reads whether onboarding has been completed.
  Future<Result<bool>> read() {
    return _service.read();
  }

  /// Writes whether onboarding has been completed.
  Future<Result<void>> write({required bool completed}) {
    return _service.write(completed: completed);
  }
}
