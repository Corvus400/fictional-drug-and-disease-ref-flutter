import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/browsing_history/name_resolution_cache.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_bmi_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_crcl_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_egfr_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/clear_browsing_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/delete_bookmark_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/delete_browsing_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/delete_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/list_browsing_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/list_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/observe_bookmark_state_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/observe_bookmarks_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/observe_browsing_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/record_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/resolve_bookmark_rows_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/resolve_browsing_history_names_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/toggle_bookmark_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/view_disease_detail_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/view_drug_detail_usecase.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp(
      'usecase_providers_test',
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async {
            if (call.method == 'getApplicationDocumentsDirectory') {
              return tempDir.path;
            }
            return null;
          },
        );
  });

  tearDownAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          null,
        );
    await tempDir.delete(recursive: true);
  });

  setUp(() {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
    SharedPreferences.setMockInitialValues({});
  });

  test('detail usecase providers return typed instances [assertion 1/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    );
    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 2/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    expect(
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    );
    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 3/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    expect(
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    );
    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 4/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    expect(
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    );
    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 5/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    expect(
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    );
    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 6/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    expect(
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    );
    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 7/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    expect(
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    );
    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 8/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    expect(
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    );
    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 9/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    expect(
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    );
    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 10/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    expect(
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    );
    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 11/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    expect(
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    );
    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 12/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    expect(
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    );
    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 13/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    expect(
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    );
    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 14/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    expect(
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    );
    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 15/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    expect(
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    );
    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 16/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    expect(
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    );
    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 17/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    expect(
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    );
    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 18/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    expect(
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    );
    Object.hashAll([
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    ]);
  });

  test('detail usecase providers return typed instances [assertion 19/19]', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBookmarksUsecaseProvider),
      isA<ObserveBookmarksUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBookmarkUsecaseProvider),
      isA<DeleteBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(resolveBookmarkRowsUsecaseProvider),
      isA<ResolveBookmarkRowsUsecase>(),
    ]);

    Object.hashAll([
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    ]);

    Object.hashAll([
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    ]);

    Object.hashAll([
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    ]);

    Object.hashAll([
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    ]);

    expect(
      container.read(resolveBrowsingHistoryNamesUsecaseProvider),
      isA<ResolveBrowsingHistoryNamesUsecase>(),
    );
  });

  test('streamBookmarkStateProvider exposes bookmark state by id', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final subscription = container.listen(
      streamBookmarkStateProvider('drug_001'),
      (_, _) {},
    );
    addTearDown(subscription.close);

    await expectLater(
      container.read(streamBookmarkStateProvider('drug_001').future),
      completion(isFalse),
    );
  });

  test('streamBookmarkStateProvider reuses the provider for the same id', () {
    expect(
      streamBookmarkStateProvider('drug_001'),
      streamBookmarkStateProvider('drug_001'),
    );
  });

  test('browsingHistoryStreamProvider exposes observed history rows', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final subscription = container.listen(
      browsingHistoryStreamProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);

    await expectLater(
      container.read(browsingHistoryStreamProvider.future),
      completion(isEmpty),
    );
  });

  test('bookmarksStreamProvider exposes observed bookmark rows', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final subscription = container.listen(
      bookmarksStreamProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);

    await expectLater(
      container.read(bookmarksStreamProvider.future),
      completion(isEmpty),
    );
  });
}
