import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_carousel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('OnboardingCarouselView', () {
    late _MockOnboardingService service;

    setUp(() {
      service = _MockOnboardingService();
      when(
        () => service.read(),
      ).thenAnswer((_) async => const Result.ok(false));
    });

    testWidgets('shows first intro page with skip next and three dots', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      expect(
        find.byKey(const ValueKey<String>('onboarding-page-1')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('onboarding-skip')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('onboarding-next')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('onboarding-dot-1')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('onboarding-dot-2')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('onboarding-dot-3')),
        findsOneWidget,
      );
    });

    testWidgets('moves through pages and shows start on the last page', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      await tester.tap(find.byKey(const ValueKey<String>('onboarding-next')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('onboarding-page-2')),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const ValueKey<String>('onboarding-next')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('onboarding-page-3')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('onboarding-start')),
        findsOneWidget,
      );
    });

    testWidgets('skip marks onboarding completed', (tester) async {
      when(
        () => service.write(completed: true),
      ).thenAnswer((_) async => const Result.ok(null));

      await tester.pumpOnboardingCarousel(service);
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-skip')));
      await tester.pump();

      verify(() => service.write(completed: true)).called(1);
    });
  });
}

extension on WidgetTester {
  Future<void> pumpOnboardingCarousel(OnboardingService service) async {
    await pumpWidget(
      ProviderScope(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: OnboardingCarouselView()),
        ),
      ),
    );
    await pump();
  }
}

final class _MockOnboardingService extends Mock implements OnboardingService {}
