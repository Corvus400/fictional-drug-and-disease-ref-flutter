import 'package:fictional_drug_and_disease_ref/application/providers/onboarding_providers.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/disclaimer_ribbon.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_spotlight.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_target_keys.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_tab_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../golden/golden_test_helpers.dart';

void main() {
  for (final target in _SpotlightGoldenTarget.values) {
    runGoldenMatrix(
      fileNamePrefix: 'onboarding_spotlight_${target.fileName}',
      description: 'Onboarding spotlight ${target.fileName} target',
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
        await _showSpotlightTarget(tester, target);
        return null;
      },
    );
  }
}

Future<Result<bool>> _readIncomplete(_) async => const Result.ok(false);

Future<Result<void>> _writeCompleted(_) async => const Result.ok(null);

Future<void> _showSpotlightTarget(
  WidgetTester tester,
  _SpotlightGoldenTarget target,
) async {
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

  for (final actionKey in target.advanceActionKeys) {
    await tester.tap(find.byKey(ValueKey<String>(actionKey)));
    await tester.pump(const Duration(milliseconds: 301));
  }
}

enum _SpotlightGoldenTarget {
  search('search', []),
  navigation('navigation', ['onboarding-spotlight-action-search-field']),
  about('about', [
    'onboarding-spotlight-action-search-field',
    'onboarding-spotlight-action-navigation-tabs',
  ])
  ;

  const _SpotlightGoldenTarget(this.fileName, this.advanceActionKeys);

  final String fileName;
  final List<String> advanceActionKeys;
}

final class _SpotlightGoldenFixture extends StatelessWidget {
  const _SpotlightGoldenFixture();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final size = MediaQuery.sizeOf(context);
    final usesRail = size.width > size.height;
    final navigation = AppShellAdaptiveNavigation(
      selectedIndex: 0,
      onDestinationSelected: (_) {},
    );
    final body = _SpotlightGoldenBody(l10n: l10n, palette: palette);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppTabHeader(tab: AppShellTab.search),
      body: usesRail
          ? Row(
              children: [
                navigation,
                Expanded(child: body),
              ],
            )
          : body,
      bottomNavigationBar: usesRail
          ? const DisclaimerRibbon()
          : AppShellBottomNavigation(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
            ),
    );
  }
}

final class _SpotlightGoldenBody extends StatelessWidget {
  const _SpotlightGoldenBody({required this.l10n, required this.palette});

  final AppLocalizations l10n;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: palette.background,
      child: Column(
        children: [
          Material(
            color: palette.surface,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: palette.hairline)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Column(
                  children: [
                    _SearchModeSwitch(l10n: l10n, palette: palette),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: KeyedSubtree(
                              key: OnboardingTargetKeys.searchField,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: l10n.searchHintDrugs,
                                  prefixIcon: const Icon(Icons.search),
                                  filled: true,
                                  fillColor: palette.searchFieldBg,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 44,
                          child: FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: palette.searchPrimaryActionBg,
                              foregroundColor: palette.searchPrimaryActionFg,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(l10n.searchActionSearch),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: _SpotlightResultCards(palette: palette)),
        ],
      ),
    );
  }
}

final class _SearchModeSwitch extends StatelessWidget {
  const _SearchModeSwitch({required this.l10n, required this.palette});

  final AppLocalizations l10n;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.surface3,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: _ModeLabel(text: l10n.searchTabDrugs, color: palette.ink),
            ),
          ),
          Expanded(
            child: _ModeLabel(
              text: l10n.searchTabDiseases,
              color: palette.ink2,
            ),
          ),
        ],
      ),
    );
  }
}

final class _ModeLabel extends StatelessWidget {
  const _ModeLabel({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

final class _SpotlightResultCards extends StatelessWidget {
  const _SpotlightResultCards({required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    final cards = [
      ('処方箋医薬品', 'アムロジピン錠', '仮想プレガバ', 'ATC: A02BC03 ・ 改訂 2024-06-30'),
      ('処方箋医薬品', 'ニュー口フィクトカプセル', '仮想プレガバ', 'ATC: N03AX16 ・ 改訂 2024-05-18'),
      ('要注意', 'セファメディック注', '仮想抗菌薬', 'ATC: J01DD04 ・ 改訂 2024-04-20'),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      itemCount: cards.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final card = cards[index];
        return DecoratedBox(
          decoration: BoxDecoration(
            color: palette.surface,
            border: Border.all(color: palette.hairline, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: palette.surface3,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SizedBox.square(
                    dimension: 56,
                    child: Icon(
                      Icons.medication_outlined,
                      color: palette.muted,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.$1,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: palette.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        card.$2,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: palette.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        card.$3,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: palette.ink2),
                      ),
                      Text(
                        card.$4,
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(color: palette.muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final class _MockOnboardingService extends Mock implements OnboardingService {}
