import 'package:fictional_drug_and_disease_ref/application/providers/onboarding_providers.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_spotlight.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_target_keys.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
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
      'starts coachmark with skip action in spotlight phase',
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

        expect(
          find.byKey(const ValueKey<String>('onboarding-spotlight-skip')),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'starts coachmark with search target title in spotlight phase',
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

        expect(find.text('検索フィールド'), findsOneWidget);
      },
    );

    testWidgets(
      'starts coachmark with next action in spotlight phase',
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

        expect(find.text('次へ'), findsOneWidget);
      },
    );

    testWidgets(
      'starts from MaterialApp builder by using target overlay',
      (tester) async {
        final container = ProviderContainer(
          overrides: [onboardingServiceProvider.overrideWithValue(service)],
        );
        addTearDown(container.dispose);
        await container.read(onboardingControllerProvider.future);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) => OnboardingSpotlight(child: child!),
              home: _SpotlightTargetsFixture(),
            ),
          ),
        );
        container.read(onboardingControllerProvider.notifier).startSpotlight();
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(milliseconds: 301));

        expect(
          find.byKey(const ValueKey<String>('onboarding-spotlight-skip')),
          findsOneWidget,
        );
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
      await tester.tap(
        find.byKey(const ValueKey<String>('onboarding-spotlight-skip')),
      );
      await tester.pump();

      verify(() => service.write(completed: true)).called(1);
      expect(
        find.byKey(const ValueKey<String>('onboarding-spotlight-skip')),
        findsNothing,
      );
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

      await tester.tap(find.text('完了'));
      await tester.pump();

      verify(() => service.write(completed: true)).called(1);
      expect(
        find.byKey(const ValueKey<String>('onboarding-spotlight-skip')),
        findsNothing,
      );
    });

    testWidgets(
      'keeps the navigation step action hit-testable on phone portrait',
      (tester) async {
        tester.view
          ..physicalSize = const Size(393, 852)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final container = ProviderContainer(
          overrides: [onboardingServiceProvider.overrideWithValue(service)],
        );
        addTearDown(container.dispose);
        await container.read(onboardingControllerProvider.future);
        container.read(onboardingControllerProvider.notifier).startSpotlight();

        await tester.pumpOnboardingSpotlight(container);
        await tester.tap(
          find.byKey(
            const ValueKey<String>(
              'onboarding-spotlight-action-search-field',
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 301));

        expect(
          find
              .byKey(
                const ValueKey<String>(
                  'onboarding-spotlight-action-navigation-tabs',
                ),
              )
              .hitTestable(),
          findsOneWidget,
        );
      },
    );

    testWidgets('uses design spec coach card width on phone', (tester) async {
      tester.view
        ..physicalSize = const Size(393, 852)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final container = ProviderContainer(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);
      await container.read(onboardingControllerProvider.future);
      container.read(onboardingControllerProvider.notifier).startSpotlight();

      await tester.pumpOnboardingSpotlight(container);

      expect(
        tester
            .getSize(
              find.byKey(
                const ValueKey<String>('onboarding-spotlight-card'),
              ),
            )
            .width,
        268,
      );
    });

    testWidgets('uses design spec coach card width on tablet', (tester) async {
      tester.view
        ..physicalSize = const Size(834, 1194)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final container = ProviderContainer(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);
      await container.read(onboardingControllerProvider.future);
      container.read(onboardingControllerProvider.notifier).startSpotlight();

      await tester.pumpOnboardingSpotlight(container);

      expect(
        tester
            .getSize(
              find.byKey(
                const ValueKey<String>('onboarding-spotlight-card'),
              ),
            )
            .width,
        320,
      );
    });

    testWidgets(
      'keeps the navigation spotlight step when rotating to rail layout',
      (tester) async {
        tester.view
          ..physicalSize = const Size(393, 852)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final container = ProviderContainer(
          overrides: [onboardingServiceProvider.overrideWithValue(service)],
        );
        addTearDown(container.dispose);
        await container.read(onboardingControllerProvider.future);
        container.read(onboardingControllerProvider.notifier).startSpotlight();

        await tester.pumpOnboardingSpotlight(container);
        await tester.tap(
          find.byKey(
            const ValueKey<String>(
              'onboarding-spotlight-action-search-field',
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 301));

        tester.view.physicalSize = const Size(852, 393);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(milliseconds: 1));

        expect(find.text('主ナビゲーション'), findsOneWidget);
      },
    );

    testWidgets(
      'places the reflowed navigation card after the rail gutter',
      (tester) async {
        tester.view
          ..physicalSize = const Size(393, 852)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final container = ProviderContainer(
          overrides: [onboardingServiceProvider.overrideWithValue(service)],
        );
        addTearDown(container.dispose);
        await container.read(onboardingControllerProvider.future);
        container.read(onboardingControllerProvider.notifier).startSpotlight();

        await tester.pumpOnboardingSpotlight(container);
        await tester.tap(
          find.byKey(
            const ValueKey<String>(
              'onboarding-spotlight-action-search-field',
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 301));

        tester.view.physicalSize = const Size(852, 393);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(milliseconds: 1));

        final cardRect = tester.getRect(
          find.byKey(const ValueKey<String>('onboarding-spotlight-card')),
        );

        expect(cardRect.left, greaterThan(appShellCompactRailWidth + 16));
      },
    );

    testWidgets(
      'keeps the reflowed navigation card inside the landscape width',
      (tester) async {
        tester.view
          ..physicalSize = const Size(393, 852)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final container = ProviderContainer(
          overrides: [onboardingServiceProvider.overrideWithValue(service)],
        );
        addTearDown(container.dispose);
        await container.read(onboardingControllerProvider.future);
        container.read(onboardingControllerProvider.notifier).startSpotlight();

        await tester.pumpOnboardingSpotlight(container);
        await tester.tap(
          find.byKey(
            const ValueKey<String>(
              'onboarding-spotlight-action-search-field',
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 301));

        tester.view.physicalSize = const Size(852, 393);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(milliseconds: 1));

        final cardRect = tester.getRect(
          find.byKey(const ValueKey<String>('onboarding-spotlight-card')),
        );

        expect(cardRect.right, lessThanOrEqualTo(852 - 16));
      },
    );

    testWidgets(
      'does not mark onboarding complete while reflowing after rotation',
      (tester) async {
        tester.view
          ..physicalSize = const Size(393, 852)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final container = ProviderContainer(
          overrides: [onboardingServiceProvider.overrideWithValue(service)],
        );
        addTearDown(container.dispose);
        await container.read(onboardingControllerProvider.future);
        container.read(onboardingControllerProvider.notifier).startSpotlight();

        await tester.pumpOnboardingSpotlight(container);
        await tester.tap(
          find.byKey(
            const ValueKey<String>(
              'onboarding-spotlight-action-search-field',
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 301));

        tester.view.physicalSize = const Size(852, 393);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(milliseconds: 1));
        await tester.pump(const Duration(milliseconds: 1));

        verifyNever(() => service.write(completed: true));
      },
    );

    for (final scenario in _RailSpotlightScenario.landscapeScenarios) {
      testWidgets(
        'targets the full rail without using the package invalid origin '
        'on ${scenario.name}',
        (tester) async {
          tester.view
            ..physicalSize = scenario.size
            ..devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          final container = ProviderContainer(
            overrides: [onboardingServiceProvider.overrideWithValue(service)],
          );
          addTearDown(container.dispose);
          await container.read(onboardingControllerProvider.future);
          container
              .read(onboardingControllerProvider.notifier)
              .startSpotlight();

          await tester.pumpWidget(
            UncontrolledProviderScope(
              container: container,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light(),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: OnboardingSpotlight(
                  child: _AppShellSpotlightTargetsFixture(),
                ),
              ),
            ),
          );
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 1));
          await tester.pump(const Duration(milliseconds: 1));
          await tester.pump(const Duration(milliseconds: 1));
          await tester.tap(
            find.byKey(
              const ValueKey<String>(
                'onboarding-spotlight-action-search-field',
              ),
            ),
          );
          await tester.pump(const Duration(milliseconds: 301));

          final position = resolveNavigationRailSpotlightTargetPosition(
            targetContext: tester.element(
              find.byKey(OnboardingTargetKeys.navigationTabs),
            ),
            spotlightContext: tester.element(find.byType(OnboardingSpotlight)),
            rootOverlay: true,
          );
          final cardRect = tester.getRect(
            find.byKey(const ValueKey<String>('onboarding-spotlight-card')),
          );

          final actual = (
            origin:
                (position?.offset.dx ?? 0) > 0 && (position?.offset.dy ?? 0) > 0
                ? 'package-renderable'
                : 'invalid-origin',
            width: position?.size.width,
            height:
                ((position?.size.height ?? 0) - scenario.size.height).abs() <
                    0.01
                ? 'full-screen'
                : 'short',
            cardLeft: cardRect.left,
            cardTop: cardRect.top,
          );

          expect(
            actual,
            (
              origin: 'package-renderable',
              width: scenario.railWidth,
              height: 'full-screen',
              cardLeft: 96.0,
              cardTop: 90.0,
            ),
          );
        },
      );
    }
  });
}

final class _RailSpotlightScenario {
  const _RailSpotlightScenario({
    required this.name,
    required this.size,
    required this.railWidth,
  });

  final String name;
  final Size size;
  final double railWidth;

  static const landscapeScenarios = [
    _RailSpotlightScenario(
      name: 'iPad landscape',
      size: Size(1194, 834),
      railWidth: appShellRegularRailWidth,
    ),
    _RailSpotlightScenario(
      name: 'phone landscape',
      size: Size(844, 390),
      railWidth: appShellCompactRailWidth,
    ),
  ];
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
    final size = MediaQuery.sizeOf(context);
    final usesRail = size.width > size.height;
    final navigation = KeyedSubtree(
      key: OnboardingTargetKeys.navigationTabs,
      child: usesRail
          ? SizedBox(
              width: appShellCompactRailWidth,
              child: NavigationRail(
                selectedIndex: 0,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.search),
                    label: Text('検索'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.bookmark_outline),
                    label: Text('保存'),
                  ),
                ],
              ),
            )
          : NavigationBar(
              destinations: const [
                NavigationDestination(icon: Icon(Icons.search), label: '検索'),
                NavigationDestination(
                  icon: Icon(Icons.bookmark_outline),
                  label: '保存',
                ),
              ],
            ),
    );

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
      body: usesRail
          ? Row(
              children: [
                navigation,
                const _SpotlightMainTargets(),
              ],
            )
          : Column(
              children: [
                const _SpotlightMainTargets(),
                navigation,
              ],
            ),
    );
  }
}

final class _SpotlightMainTargets extends StatelessWidget {
  const _SpotlightMainTargets();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          KeyedSubtree(
            key: OnboardingTargetKeys.searchField,
            child: const TextField(),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

final class _AppShellSpotlightTargetsFixture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppShellAdaptiveNavigation(
            selectedIndex: 0,
            onDestinationSelected: (_) {},
          ),
          const Expanded(child: _AppShellSpotlightContentFixture()),
        ],
      ),
    );
  }
}

final class _AppShellSpotlightContentFixture extends StatelessWidget {
  const _AppShellSpotlightContentFixture();

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
        ],
      ),
    );
  }
}

final class _MockOnboardingService extends Mock implements OnboardingService {}
