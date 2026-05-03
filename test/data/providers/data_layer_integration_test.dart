import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/usecases/view_drug_detail_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('viewDrugDetailUsecaseProvider records browsing history', () async {
    SharedPreferences.setMockInitialValues({});
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final apiClient = _MockDrugApiClient();
    final dto = _drugFixture();
    when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        drugApiClientProvider.overrideWithValue(apiClient),
      ],
    );
    addTearDown(container.dispose);

    final result = await container
        .read(viewDrugDetailUsecaseProvider)
        .execute(dto.id);

    expect(result, isA<DrugDetailLoaded>());
    final histories = await container
        .read(browsingHistoryRepositoryProvider)
        .findAll();
    final entries = (histories as Ok<List<BrowsingHistoryEntry>>).value;
    expect(entries.map((entry) => entry.id), [dto.id]);
  });
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

DrugDto _drugFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs__id_.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugDto.fromJson(json);
}
