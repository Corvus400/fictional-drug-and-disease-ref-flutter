import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_carousel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../golden/golden_test_config.dart';
import '../../golden/golden_test_helpers.dart';

void main() {
  for (final page in _OnboardingGoldenPage.values) {
    final capturesWidePhoneLandscape = page == _OnboardingGoldenPage.page2;

    runGoldenMatrix(
      fileNamePrefix: 'onboarding_intro_${page.name}',
      description: 'Onboarding intro ${page.name}',
      devices: capturesWidePhoneLandscape
          ? [
              ...GoldenMatrix.devices.keys,
              'iphone_landscape_wide',
            ]
          : null,
      customDevices: capturesWidePhoneLandscape
          ? const {'iphone_landscape_wide': Size(1024, 474)}
          : null,
      builder: (theme, size, textScaler) {
        final service = _MockOnboardingService();
        when(service.read).thenAnswer((_) async => const Result.ok(false));

        return ProviderScope(
          overrides: [onboardingServiceProvider.overrideWithValue(service)],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: OnboardingCarouselView(initialPage: page.index),
          ),
        );
      },
    );
  }
}

enum _OnboardingGoldenPage {
  page1,
  page2,
  page3,
}

final class _MockOnboardingService extends Mock implements OnboardingService {}
