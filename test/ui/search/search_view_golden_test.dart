import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alchemist/alchemist.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  _searchGolden(
    description: 'S1 idle light',
    fileName: 'search_s1_idle_light',
    theme: AppTheme.light(),
  );

  _searchGolden(
    description: 'S1 idle dark',
    fileName: 'search_s1_idle_dark',
    theme: AppTheme.dark(),
  );

  _searchGolden(
    description: 'S5 drug results light',
    fileName: 'search_s5_drug_results_light',
    theme: AppTheme.light(),
    response: _drugListFixture(),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'S5 drug results dark',
    fileName: 'search_s5_drug_results_dark',
    theme: AppTheme.dark(),
    response: _drugListFixture(),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'S6 empty light',
    fileName: 'search_s6_empty_light',
    theme: AppTheme.light(),
    response: _drugListFixture().copyWith(items: [], totalCount: 0),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'S6 empty dark',
    fileName: 'search_s6_empty_dark',
    theme: AppTheme.dark(),
    response: _drugListFixture().copyWith(items: [], totalCount: 0),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'S7 error light',
    fileName: 'search_s7_error_light',
    theme: AppTheme.light(),
    error: DioException(
      requestOptions: RequestOptions(path: '/v1/drugs'),
      type: DioExceptionType.connectionError,
    ),
    whilePerforming: _performSearch,
  );

  _searchGolden(
    description: 'S7 error dark',
    fileName: 'search_s7_error_dark',
    theme: AppTheme.dark(),
    error: DioException(
      requestOptions: RequestOptions(path: '/v1/drugs'),
      type: DioExceptionType.connectionError,
    ),
    whilePerforming: _performSearch,
  );
}

void _searchGolden({
  required String description,
  required String fileName,
  required ThemeData theme,
  DrugListResponseDto? response,
  Object? error,
  Interaction? whilePerforming,
}) {
  unawaited(
    goldenTest(
      description,
      fileName: fileName,
      constraints: const BoxConstraints.tightFor(width: 390, height: 844),
      builder: () {
        final db = AppDatabase(NativeDatabase.memory());
        final drugApiClient = _MockDrugApiClient();
        if (error != null) {
          when(
            () => drugApiClient.getDrugs(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
              keyword: any(named: 'keyword'),
            ),
          ).thenThrow(error);
        } else {
          when(
            () => drugApiClient.getDrugs(
              page: any(named: 'page'),
              pageSize: any(named: 'pageSize'),
              keyword: any(named: 'keyword'),
            ),
          ).thenAnswer((_) async => response ?? _drugListFixture());
        }
        return ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            drugApiClientProvider.overrideWithValue(drugApiClient),
          ],
          child: MaterialApp(
            theme: theme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchView(),
          ),
        );
      },
      whilePerforming: whilePerforming,
    ),
  );
}

Future<Future<void> Function()?> _performSearch(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const ValueKey('search-field')),
    'golden keyword',
  );
  await tester.tap(find.byType(FilledButton).first);
  await tester.pumpAndSettle();
  return null;
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

DrugListResponseDto _drugListFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugListResponseDto.fromJson(json);
}
