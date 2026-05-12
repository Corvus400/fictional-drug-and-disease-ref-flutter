import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/browsing_history/name_resolution_cache.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_bmi_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_crcl_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_egfr_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/clear_browsing_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/delete_browsing_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/delete_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/list_browsing_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/list_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/observe_bookmark_state_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/observe_browsing_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/record_calculation_history_usecase.dart';
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

  test('detail usecase providers return typed instances', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      container.read(viewDrugDetailUsecaseProvider),
      isA<ViewDrugDetailUsecase>(),
    );
    expect(
      container.read(viewDiseaseDetailUsecaseProvider),
      isA<ViewDiseaseDetailUsecase>(),
    );
    expect(
      container.read(observeBookmarkStateUsecaseProvider),
      isA<ObserveBookmarkStateUsecase>(),
    );
    expect(
      container.read(toggleBookmarkUsecaseProvider),
      isA<ToggleBookmarkUsecase>(),
    );
    expect(
      container.read(calculateBmiUsecaseProvider),
      isA<CalculateBmiUsecase>(),
    );
    expect(
      container.read(calculateEgfrUsecaseProvider),
      isA<CalculateEgfrUsecase>(),
    );
    expect(
      container.read(calculateCrClUsecaseProvider),
      isA<CalculateCrClUsecase>(),
    );
    expect(
      container.read(recordCalculationHistoryUsecaseProvider),
      isA<RecordCalculationHistoryUsecase>(),
    );
    expect(
      container.read(listCalculationHistoryUsecaseProvider),
      isA<ListCalculationHistoryUsecase>(),
    );
    expect(
      container.read(deleteCalculationHistoryUsecaseProvider),
      isA<DeleteCalculationHistoryUsecase>(),
    );
    expect(
      container.read(listBrowsingHistoryUsecaseProvider),
      isA<ListBrowsingHistoryUsecase>(),
    );
    expect(
      container.read(deleteBrowsingHistoryUsecaseProvider),
      isA<DeleteBrowsingHistoryUsecase>(),
    );
    expect(
      container.read(clearBrowsingHistoryUsecaseProvider),
      isA<ClearBrowsingHistoryUsecase>(),
    );
    expect(
      container.read(observeBrowsingHistoryUsecaseProvider),
      isA<ObserveBrowsingHistoryUsecase>(),
    );
    expect(
      container.read(nameResolutionCacheProvider),
      isA<NameResolutionCache>(),
    );
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
}
