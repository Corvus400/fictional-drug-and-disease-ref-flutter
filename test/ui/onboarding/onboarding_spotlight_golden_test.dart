import 'package:fictional_drug_and_disease_ref/application/providers/onboarding_providers.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_spotlight.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_target_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../golden/golden_test_helpers.dart';

void main() {
  runGoldenMatrix(
    fileNamePrefix: 'onboarding_spotlight_search',
    description: 'Onboarding spotlight search target',
    builder: (theme, size, textScaler) {
      final service = _MockOnboardingService();
      when(service.read).thenAnswer(_readIncomplete);
      when(
        () => service.write(completed: true),
      ).thenAnswer(_writeCompleted);

      return ProviderScope(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const OnboardingSpotlight(child: _SpotlightGoldenFixture()),
        ),
      );
    },
    whilePerforming: (tester) async {
      await tester.pump();
      await tester.pump();
      final container = ProviderScope.containerOf(
        tester.element(find.byType(_SpotlightGoldenFixture)),
      );
      container.read(onboardingControllerProvider.notifier).startSpotlight();
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pump(const Duration(milliseconds: 301));
      return null;
    },
  );
}

Future<Result<bool>> _readIncomplete(_) async => const Result.ok(false);

Future<Result<void>> _writeCompleted(_) async => const Result.ok(null);

final class _SpotlightGoldenFixture extends StatelessWidget {
  const _SpotlightGoldenFixture();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabSearch),
        actions: [
          KeyedSubtree(
            key: OnboardingTargetKeys.aboutButton,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: KeyedSubtree(
              key: OnboardingTargetKeys.searchField,
              child: TextField(
                decoration: InputDecoration(
                  hintText: l10n.searchHintDrugs,
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                ),
              ),
            ),
          ),
          const Spacer(),
          KeyedSubtree(
            key: OnboardingTargetKeys.navigationTabs,
            child: NavigationBar(
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.search),
                  label: l10n.tabSearch,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.bookmark_outline),
                  label: l10n.tabBookmarks,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.history),
                  label: l10n.tabHistory,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.calculate_outlined),
                  label: l10n.tabCalc,
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
