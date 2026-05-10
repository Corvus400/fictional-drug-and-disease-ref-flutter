import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/theme/theme_mode_setting.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Root application widget.
class App extends ConsumerWidget {
  /// Creates the application widget.
  App({super.key}) : _router = buildRouter();

  final GoRouter _router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeSetting = ref.watch(themeModeSettingProvider).value;

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeModeFor(themeModeSetting),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}

ThemeMode _themeModeFor(ThemeModeSetting? setting) {
  return switch (setting ?? ThemeModeSetting.system) {
    ThemeModeSetting.system => ThemeMode.system,
    ThemeModeSetting.light => ThemeMode.light,
    ThemeModeSetting.dark => ThemeMode.dark,
  };
}
