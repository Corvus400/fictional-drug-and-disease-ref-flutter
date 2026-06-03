import 'package:fictional_drug_and_disease_ref/application/onboarding/onboarding_controller.dart';
import 'package:fictional_drug_and_disease_ref/domain/onboarding/onboarding_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Onboarding state controller provider.
final onboardingControllerProvider =
    AsyncNotifierProvider<OnboardingController, OnboardingState>(
      OnboardingController.new,
    );
