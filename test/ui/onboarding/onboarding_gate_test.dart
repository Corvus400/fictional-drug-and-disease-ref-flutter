import 'dart:async';

import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_carousel_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('OnboardingGate', () {
    late _MockOnboardingService service;

    setUp(() {
      service = _MockOnboardingService();
    });

    testWidgets('keeps the routed child when onboarding is not completed', (
      tester,
    ) async {
      when(
        () => service.read(),
      ).thenAnswer((_) async => const Result.ok(false));

      await tester.pumpOnboardingGate(service);

      expect(
        find.byKey(const ValueKey<String>('gate-child')),
        findsOneWidget,
      );
    });

    testWidgets('shows carousel overlay when onboarding is not completed', (
      tester,
    ) async {
      when(
        () => service.read(),
      ).thenAnswer((_) async => const Result.ok(false));

      await tester.pumpOnboardingGate(service);

      expect(find.byType(OnboardingCarouselView), findsOneWidget);
    });

    testWidgets('keeps the routed child when onboarding is completed', (
      tester,
    ) async {
      when(() => service.read()).thenAnswer((_) async => const Result.ok(true));

      await tester.pumpOnboardingGate(service);

      expect(
        find.byKey(const ValueKey<String>('gate-child')),
        findsOneWidget,
      );
    });

    testWidgets('does not show carousel when onboarding is completed', (
      tester,
    ) async {
      when(() => service.read()).thenAnswer((_) async => const Result.ok(true));

      await tester.pumpOnboardingGate(service);

      expect(find.byType(OnboardingCarouselView), findsNothing);
    });

    testWidgets('uses a background fallback while onboarding state loads', (
      tester,
    ) async {
      final completer = Completer<Result<bool>>();
      when(() => service.read()).thenAnswer((_) => completer.future);

      await tester.pumpOnboardingGate(service);

      expect(
        find.byKey(const ValueKey<String>('onboarding-loading-fallback')),
        findsOneWidget,
      );
    });

    testWidgets('hides the routed child while onboarding state loads', (
      tester,
    ) async {
      final completer = Completer<Result<bool>>();
      when(() => service.read()).thenAnswer((_) => completer.future);

      await tester.pumpOnboardingGate(service);

      expect(
        find.byKey(const ValueKey<String>('gate-child')),
        findsNothing,
      );
    });

    testWidgets('restores the routed child after onboarding state loads', (
      tester,
    ) async {
      final completer = Completer<Result<bool>>();
      when(() => service.read()).thenAnswer((_) => completer.future);

      await tester.pumpOnboardingGate(service);

      completer.complete(const Result.ok(true));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey<String>('gate-child')), findsOneWidget);
    });

    testWidgets('removes intro overlay when the carousel starts spotlight', (
      tester,
    ) async {
      when(
        () => service.read(),
      ).thenAnswer((_) async => const Result.ok(false));

      await tester.pumpOnboardingGate(service);
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-next')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-next')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-start')));
      await tester.pump();

      expect(
        find.byKey(const ValueKey<String>('gate-child')),
        findsOneWidget,
      );
    });

    testWidgets('removes intro overlay after the carousel starts spotlight', (
      tester,
    ) async {
      when(
        () => service.read(),
      ).thenAnswer((_) async => const Result.ok(false));

      await tester.pumpOnboardingGate(service);
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-next')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-next')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-start')));
      await tester.pump();

      expect(find.byType(OnboardingCarouselView), findsNothing);
    });
  });
}

extension on WidgetTester {
  Future<void> pumpOnboardingGate(OnboardingService service) async {
    await pumpWidget(
      ProviderScope(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const OnboardingGate(
            child: SizedBox(key: ValueKey<String>('gate-child')),
          ),
        ),
      ),
    );
    await pump();
  }
}

final class _MockOnboardingService extends Mock implements OnboardingService {}
