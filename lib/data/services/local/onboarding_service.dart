import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _onboardingCompletedKey = 'onboarding_completed';

/// Local service for persisted onboarding completion state.
class OnboardingService {
  /// Creates an onboarding service.
  const OnboardingService(this._prefsFuture);

  final Future<SharedPreferences> _prefsFuture;

  /// Reads whether onboarding has been completed.
  Future<Result<bool>> read() async {
    final prefs = await _prefsFuture;
    return Result.ok(prefs.getBool(_onboardingCompletedKey) ?? false);
  }

  /// Writes whether onboarding has been completed.
  Future<Result<void>> write({required bool completed}) async {
    try {
      final prefs = await _prefsFuture;
      await prefs.setBool(_onboardingCompletedKey, completed);
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }
}
