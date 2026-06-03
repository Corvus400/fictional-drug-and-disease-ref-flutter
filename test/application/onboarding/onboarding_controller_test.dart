import 'package:fictional_drug_and_disease_ref/application/providers/onboarding_providers.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:fictional_drug_and_disease_ref/domain/onboarding/onboarding_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('OnboardingController', () {
    late _MockOnboardingService service;

    setUp(() {
      service = _MockOnboardingService();
    });

    test('build returns none phase when onboarding is completed', () async {
      when(() => service.read()).thenAnswer((_) async => const Result.ok(true));
      final container = ProviderContainer(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);

      final state = await container.read(onboardingControllerProvider.future);

      expect(
        state,
        isA<OnboardingState>()
            .having((state) => state.completed, 'completed', isTrue)
            .having((state) => state.phase, 'phase', OnboardingPhase.none),
      );
    });

    test(
      'build returns intro phase when onboarding is not completed',
      () async {
        when(
          () => service.read(),
        ).thenAnswer((_) async => const Result.ok(false));
        final container = ProviderContainer(
          overrides: [onboardingServiceProvider.overrideWithValue(service)],
        );
        addTearDown(container.dispose);

        final state = await container.read(onboardingControllerProvider.future);

        expect(
          state,
          isA<OnboardingState>()
              .having((state) => state.completed, 'completed', isFalse)
              .having((state) => state.phase, 'phase', OnboardingPhase.intro),
        );
      },
    );

    test('skip persists completion and clears active phase', () async {
      when(
        () => service.read(),
      ).thenAnswer((_) async => const Result.ok(false));
      when(() => service.write(completed: true)).thenAnswer(
        (_) async => const Result.ok(null),
      );
      final container = ProviderContainer(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);
      await container.read(onboardingControllerProvider.future);

      await container.read(onboardingControllerProvider.notifier).skip();
      final state = container.read(onboardingControllerProvider).value;

      expect(
        state,
        isA<OnboardingState>()
            .having((state) => state.completed, 'completed', isTrue)
            .having((state) => state.phase, 'phase', OnboardingPhase.none),
      );
      verify(() => service.write(completed: true)).called(1);
    });

    test(
      'startSpotlight moves from intro to spotlight without persisting',
      () async {
        when(
          () => service.read(),
        ).thenAnswer((_) async => const Result.ok(false));
        final container = ProviderContainer(
          overrides: [onboardingServiceProvider.overrideWithValue(service)],
        );
        addTearDown(container.dispose);
        await container.read(onboardingControllerProvider.future);

        container.read(onboardingControllerProvider.notifier).startSpotlight();
        final state = container.read(onboardingControllerProvider).value;

        expect(
          state,
          isA<OnboardingState>()
              .having((state) => state.completed, 'completed', isFalse)
              .having(
                (state) => state.phase,
                'phase',
                OnboardingPhase.spotlight,
              ),
        );
        verifyNever(() => service.write(completed: any(named: 'completed')));
      },
    );

    test('complete persists completion and clears active phase', () async {
      when(
        () => service.read(),
      ).thenAnswer((_) async => const Result.ok(false));
      when(() => service.write(completed: true)).thenAnswer(
        (_) async => const Result.ok(null),
      );
      final container = ProviderContainer(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);
      await container.read(onboardingControllerProvider.future);
      container.read(onboardingControllerProvider.notifier).startSpotlight();

      await container.read(onboardingControllerProvider.notifier).complete();
      final state = container.read(onboardingControllerProvider).value;

      expect(
        state,
        isA<OnboardingState>()
            .having((state) => state.completed, 'completed', isTrue)
            .having((state) => state.phase, 'phase', OnboardingPhase.none),
      );
      verify(() => service.write(completed: true)).called(1);
    });

    test('replay keeps completion flag and returns to intro phase', () async {
      when(() => service.read()).thenAnswer((_) async => const Result.ok(true));
      final container = ProviderContainer(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);
      await container.read(onboardingControllerProvider.future);

      container.read(onboardingControllerProvider.notifier).replay();
      final state = container.read(onboardingControllerProvider).value;

      expect(
        state,
        isA<OnboardingState>()
            .having((state) => state.completed, 'completed', isTrue)
            .having((state) => state.phase, 'phase', OnboardingPhase.intro),
      );
      verifyNever(() => service.write(completed: any(named: 'completed')));
    });
  });
}

final class _MockOnboardingService extends Mock implements OnboardingService {}
