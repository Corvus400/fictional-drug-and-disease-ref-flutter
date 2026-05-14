import 'dart:typed_data';

import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/categories_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/disease_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/drug_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/preview_api_clients.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/scoped_dialog_host.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

/// Cache manager shared by previews that should never perform live fetches.
const previewFailingCacheManager = PreviewFailingCacheManager();

/// Common app preview theme.
PreviewThemeData previewTheme() {
  return PreviewThemeData(
    materialLight: AppTheme.light(),
    materialDark: AppTheme.dark(),
  );
}

/// Common Japanese localization setup for app previews.
PreviewLocalizationsData previewLocalizations() {
  return const PreviewLocalizationsData(
    locale: Locale('ja'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
  );
}

/// Wraps a full-screen preview in deterministic app bootstrap.
Widget previewScreenWrapper(Widget child) {
  ensurePreviewBootstrap();
  return ProviderScope(child: child);
}

/// Wraps a component preview in deterministic app bootstrap.
Widget previewComponentWrapper(Widget child) {
  ensurePreviewBootstrap();
  return ProviderScope(
    child: Material(
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    ),
  );
}

/// Wraps a bottom-sheet or dialog-body preview.
Widget previewSheetWrapper(Widget child) {
  ensurePreviewBootstrap();
  return ProviderScope(
    child: Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: child,
        ),
      ),
    ),
  );
}

/// Builds a ProviderScope with preview bootstrap already applied.
Widget previewProviderScope({
  required Widget child,
  List<Override> overrides = const [],
}) {
  ensurePreviewBootstrap();
  return ProviderScope(
    overrides: overrides,
    child: ScopedDialogHost(child: child),
  );
}

/// Provider overrides that keep previews away from live API calls.
List<Override> previewApiOverrides() {
  const drugClient = PreviewDrugApiClient();
  const diseaseClient = PreviewDiseaseApiClient();
  const categoryClient = PreviewCategoryApiClient();
  return [
    drugApiClientProvider.overrideWithValue(drugClient),
    diseaseApiClientProvider.overrideWithValue(diseaseClient),
    categoryApiClientProvider.overrideWithValue(categoryClient),
    drugRepositoryProvider.overrideWithValue(const DrugRepository(drugClient)),
    diseaseRepositoryProvider.overrideWithValue(
      const DiseaseRepository(diseaseClient),
    ),
    categoriesRepositoryProvider.overrideWithValue(
      CategoriesRepository(categoryClient),
    ),
  ];
}

/// Ensures static app configuration exists before preview widgets build.
void ensurePreviewBootstrap() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiConfig.initialize(
    const FlavorConfig(
      flavor: Flavor.dev,
      apiBaseUrl: 'https://preview.invalid',
    ),
  );
}

/// Phone-sized light/dark previews for full screens.
base class FddScreenPreview extends MultiPreview {
  /// Creates a phone-sized screen preview pair.
  const FddScreenPreview({required this.group, required this.name});

  /// Preview group.
  final String group;

  /// Preview name prefix.
  final String name;

  @override
  List<Preview> get previews => [
    Preview(
      group: group,
      name: '$name / Light',
      size: const Size(390, 844),
      brightness: Brightness.light,
      wrapper: previewScreenWrapper,
      theme: previewTheme,
      localizations: previewLocalizations,
    ),
    Preview(
      group: group,
      name: '$name / Dark',
      size: const Size(390, 844),
      brightness: Brightness.dark,
      wrapper: previewScreenWrapper,
      theme: previewTheme,
      localizations: previewLocalizations,
    ),
  ];
}

/// Tablet-sized preview for responsive layouts.
base class FddTabletPreview extends MultiPreview {
  /// Creates a tablet-sized preview.
  const FddTabletPreview({required this.group, required this.name});

  /// Preview group.
  final String group;

  /// Preview name.
  final String name;

  @override
  List<Preview> get previews => [
    Preview(
      group: group,
      name: name,
      size: const Size(834, 1112),
      brightness: Brightness.light,
      wrapper: previewScreenWrapper,
      theme: previewTheme,
      localizations: previewLocalizations,
    ),
  ];
}

/// Component-sized light/dark previews.
base class FddComponentPreview extends MultiPreview {
  /// Creates a component preview pair.
  const FddComponentPreview({required this.group, required this.name});

  /// Preview group.
  final String group;

  /// Preview name prefix.
  final String name;

  @override
  List<Preview> get previews => [
    Preview(
      group: group,
      name: '$name / Light',
      size: const Size(430, 360),
      brightness: Brightness.light,
      wrapper: previewComponentWrapper,
      theme: previewTheme,
      localizations: previewLocalizations,
    ),
    Preview(
      group: group,
      name: '$name / Dark',
      size: const Size(430, 360),
      brightness: Brightness.dark,
      wrapper: previewComponentWrapper,
      theme: previewTheme,
      localizations: previewLocalizations,
    ),
  ];
}

/// Bottom-sheet sized preview pair.
base class FddSheetPreview extends MultiPreview {
  /// Creates a sheet preview pair.
  const FddSheetPreview({required this.group, required this.name});

  /// Preview group.
  final String group;

  /// Preview name prefix.
  final String name;

  @override
  List<Preview> get previews => [
    Preview(
      group: group,
      name: '$name / Light',
      size: const Size(430, 760),
      brightness: Brightness.light,
      wrapper: previewSheetWrapper,
      theme: previewTheme,
      localizations: previewLocalizations,
    ),
    Preview(
      group: group,
      name: '$name / Dark',
      size: const Size(430, 760),
      brightness: Brightness.dark,
      wrapper: previewSheetWrapper,
      theme: previewTheme,
      localizations: previewLocalizations,
    ),
  ];
}

/// Deterministic cache manager that always renders image fallbacks.
final class PreviewFailingCacheManager implements BaseCacheManager {
  /// Creates a failing preview cache manager.
  const PreviewFailingCacheManager();

  @override
  Future<FileInfo> downloadFile(
    String url, {
    String? key,
    Map<String, String>? authHeaders,
    bool force = false,
  }) {
    return Future<FileInfo>.error(_error(url));
  }

  @override
  Future<void> emptyCache() async {}

  @override
  Future<void> dispose() async {}

  @override
  Stream<FileInfo> getFile(
    String url, {
    String? key,
    Map<String, String>? headers,
  }) {
    return Stream<FileInfo>.error(_error(url));
  }

  @override
  Future<FileInfo?> getFileFromCache(
    String key, {
    bool ignoreMemCache = false,
  }) async {
    return null;
  }

  @override
  Future<FileInfo?> getFileFromMemory(String key) async {
    return null;
  }

  @override
  Stream<FileResponse> getFileStream(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool withProgress = false,
  }) {
    return Stream<FileResponse>.error(_error(url));
  }

  @override
  Future<Never> getSingleFile(
    String url, {
    String? key,
    Map<String, String>? headers,
  }) {
    return Future<Never>.error(_error(url));
  }

  @override
  Future<Never> putFile(
    String url,
    Uint8List fileBytes, {
    String? key,
    String? eTag,
    Duration maxAge = const Duration(days: 30),
    String fileExtension = 'file',
  }) {
    return Future<Never>.error(_error(url));
  }

  @override
  Future<Never> putFileStream(
    String url,
    Stream<List<int>> source, {
    String? key,
    String? eTag,
    Duration maxAge = const Duration(days: 30),
    String fileExtension = 'file',
  }) {
    return Future<Never>.error(_error(url));
  }

  @override
  Future<void> removeFile(String key) async {}

  StateError _error(String value) {
    return StateError('Preview cache manager does not fetch files: $value');
  }
}
