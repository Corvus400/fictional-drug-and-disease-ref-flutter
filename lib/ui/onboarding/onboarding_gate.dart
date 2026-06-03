import 'package:fictional_drug_and_disease_ref/application/providers/onboarding_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/onboarding/onboarding_state.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_carousel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Gates the app with the intro onboarding overlay until completion.
final class OnboardingGate extends ConsumerWidget {
  /// Creates an onboarding gate.
  const OnboardingGate({required this.child, super.key});

  /// The application content rendered below onboarding overlays.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarding = ref.watch(onboardingControllerProvider);

    return switch (onboarding) {
      AsyncLoading<OnboardingState>() => const _LoadingFallback(),
      AsyncData<OnboardingState>(:final value)
          when value.phase == OnboardingPhase.intro =>
        Stack(
          children: [
            child,
            const Positioned.fill(child: OnboardingCarouselView()),
          ],
        ),
      _ => child,
    };
  }
}

final class _LoadingFallback extends StatelessWidget {
  const _LoadingFallback();

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return ColoredBox(
      key: const ValueKey<String>('onboarding-loading-fallback'),
      color: palette.bg,
    );
  }
}
