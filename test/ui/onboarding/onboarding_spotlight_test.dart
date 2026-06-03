import 'package:fictional_drug_and_disease_ref/application/providers/onboarding_providers.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_spotlight.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_target_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('OnboardingSpotlight', () {
    late _MockOnboardingService service;

    setUp(() {
      service = _MockOnboardingService();
      when(
        () => service.read(),
      ).thenAnswer((_) async => const Result.ok(false));
      when(
        () => service.write(completed: true),
      ).thenAnswer((_) async => const Result.ok(null));
    });

    testWidgets(
      'starts coachmark for shell chrome targets in spotlight phase',
      (
        tester,
      ) async {
        final container = ProviderContainer(
          overrides: [onboardingServiceProvider.overrideWithValue(service)],
        );
        addTearDown(container.dispose);
        await container.read(onboardingControllerProvider.future);
        container.read(onboardingControllerProvider.notifier).startSpotlight();

        await tester.pumpOnboardingSpotlight(container);

        Object.hashAll([find.text('スキップ'), findsOneWidget]);
        Object.hashAll([find.text('検索フィールド'), findsOneWidget]);
        expect(find.text('次へ'), findsOneWidget);
      },
    );

    testWidgets('skip marks onboarding completed and removes the coachmark', (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);
      await container.read(onboardingControllerProvider.future);
      container.read(onboardingControllerProvider.notifier).startSpotlight();

      await tester.pumpOnboardingSpotlight(container);
      await tester.tap(find.text('スキップ'));
      await tester.pump();

      verify(() => service.write(completed: true)).called(1);
      expect(find.text('スキップ'), findsNothing);
    });

    testWidgets('done marks onboarding completed at the end of the tour', (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);
      await container.read(onboardingControllerProvider.future);
      container.read(onboardingControllerProvider.notifier).startSpotlight();

      await tester.pumpOnboardingSpotlight(container);
      await tester.tap(find.text('次へ'));
      await tester.pump(const Duration(milliseconds: 301));
      await tester.tap(find.text('次へ'));
      await tester.pump(const Duration(milliseconds: 301));

      Object.hashAll([find.text('完了'), findsOneWidget]);

      await tester.tap(find.text('完了'));
      await tester.pump();

      verify(() => service.write(completed: true)).called(1);
      expect(find.text('スキップ'), findsNothing);
    });
  });
}

extension on WidgetTester {
  Future<void> pumpOnboardingSpotlight(ProviderContainer container) async {
    await pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: OnboardingSpotlight(child: _SpotlightTargetsFixture()),
        ),
      ),
    );
    await pump();
    await pump(const Duration(milliseconds: 1));
    await pump(const Duration(milliseconds: 1));
    await pump(const Duration(milliseconds: 1));
  }
}

final class _SpotlightTargetsFixture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          KeyedSubtree(
            key: OnboardingTargetKeys.aboutButton,
            child: const IconButton(
              onPressed: null,
              icon: Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          KeyedSubtree(
            key: OnboardingTargetKeys.searchField,
            child: const TextField(),
          ),
          const Spacer(),
          KeyedSubtree(
            key: OnboardingTargetKeys.navigationTabs,
            child: NavigationBar(
              destinations: const [
                NavigationDestination(icon: Icon(Icons.search), label: '検索'),
                NavigationDestination(
                  icon: Icon(Icons.bookmark_outline),
                  label: '保存',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _MockOnboardingService extends Mock implements OnboardingService {}
