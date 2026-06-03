import 'package:fictional_drug_and_disease_ref/application/providers/onboarding_providers.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _pageCount = 3;
// Design SSOT: Onboarding Spec.html `.ob-skip { padding: 0 10px; }`.
const _onboardingSkipHorizontalPadding = 10.0;
const _onboardingSkipGlyphSize = 16.0;

/// Full-screen intro carousel for onboarding.
class OnboardingCarouselView extends ConsumerStatefulWidget {
  /// Creates an onboarding carousel.
  const OnboardingCarouselView({this.initialPage = 0, super.key});

  /// Initial page used by deterministic tests and golden captures.
  final int initialPage;

  @override
  ConsumerState<OnboardingCarouselView> createState() =>
      _OnboardingCarouselViewState();
}

final class _OnboardingCarouselViewState
    extends ConsumerState<OnboardingCarouselView> {
  late final PageController _pageController;
  late int _pageIndex = widget.initialPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final spacing = theme.extension<AppSpacing>()!;
    final radii = theme.extension<AppRadii>()!;
    final typography = theme.extension<AppTypography>()!;
    final isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;
    final isLast = _pageIndex == _pageCount - 1;
    final skipTextStyle = typography.labelM
        .copyWith(
          color: palette.muted,
          fontSize: _onboardingSkipGlyphSize,
          height: 1,
          decoration: TextDecoration.none,
        )
        .withVariableWeight(FontWeight.w600);

    return Material(
      color: palette.bg,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? spacing.s10 : spacing.s4,
            vertical: isTablet ? spacing.s8 : spacing.s4,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 44,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Semantics(
                    button: true,
                    label: l10n.onboardingSkip,
                    child: GestureDetector(
                      key: const ValueKey<String>('onboarding-skip'),
                      behavior: HitTestBehavior.opaque,
                      onTap: () => ref
                          .read(onboardingControllerProvider.notifier)
                          .skip(),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 44),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: _onboardingSkipHorizontalPadding,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                l10n.onboardingSkip,
                                style: skipTextStyle,
                              ),
                              SizedBox(width: spacing.s1),
                              ExcludeSemantics(
                                child: Text(
                                  '×',
                                  style: skipTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _pageIndex = index),
                  children: _pages(l10n),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: spacing.s4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pageCount, (index) {
                        return _Dot(
                          key: ValueKey<String>(
                            'onboarding-dot-${index + 1}',
                          ),
                          active: index == _pageIndex,
                        );
                      }),
                    ),
                    SizedBox(height: spacing.s4),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        key: ValueKey<String>(
                          isLast ? 'onboarding-start' : 'onboarding-next',
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: palette.primary,
                          foregroundColor: palette.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radii.pill),
                          ),
                        ),
                        onPressed: isLast ? _startSpotlight : _goNext,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isLast
                                  ? l10n.onboardingStart
                                  : l10n.onboardingNext,
                              style: typography.titleM.copyWith(
                                color: palette.onPrimary,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            if (!isLast) ...[
                              SizedBox(width: spacing.s1),
                              const Icon(Icons.chevron_right, size: 18),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _pages(AppLocalizations l10n) {
    return [
      OnboardingPage(
        pageNumber: 1,
        icon: Icons.medical_services_outlined,
        title: l10n.onboardingIntroP1Title,
        body: l10n.onboardingIntroP1Body,
        showDisclaimer: true,
      ),
      OnboardingPage(
        pageNumber: 2,
        icon: Icons.menu_book_outlined,
        title: l10n.onboardingIntroP2Title,
        body: l10n.onboardingIntroP2Body,
        features: [
          OnboardingFeature(
            icon: Icons.search,
            label: l10n.onboardingFeatureSearch,
          ),
          OnboardingFeature(
            icon: Icons.medication_outlined,
            label: l10n.onboardingFeatureDetail,
          ),
          OnboardingFeature(
            icon: Icons.calculate_outlined,
            label: l10n.onboardingFeatureCalc,
          ),
          OnboardingFeature(
            icon: Icons.bookmark_outline,
            label: l10n.onboardingFeatureBookmark,
          ),
          OnboardingFeature(
            icon: Icons.history,
            label: l10n.onboardingFeatureHistory,
          ),
        ],
      ),
      OnboardingPage(
        pageNumber: 3,
        icon: Icons.touch_app_outlined,
        title: l10n.onboardingIntroP3Title,
        body: l10n.onboardingIntroP3Body,
      ),
    ];
  }

  Future<void> _goNext() async {
    await _pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void _startSpotlight() {
    ref.read(onboardingControllerProvider.notifier).startSpotlight();
  }
}

final class _Dot extends StatelessWidget {
  const _Dot({required this.active, super.key});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    return Container(
      width: active ? 22 : spacing.s2,
      height: spacing.s2,
      margin: EdgeInsets.symmetric(horizontal: spacing.s1),
      decoration: BoxDecoration(
        color: active ? palette.primary : palette.surface4,
        borderRadius: BorderRadius.circular(active ? 5 : spacing.s2),
      ),
    );
  }
}
