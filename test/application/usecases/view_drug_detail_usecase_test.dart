import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/view_drug_detail_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/drug_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('ViewDrugDetailUsecase', () {
    late AppDatabase db;
    late _MockDrugApiClient apiClient;
    late DrugRepository drugRepository;
    late BookmarkRepository bookmarkRepository;
    late BrowsingHistoryRepository browsingHistoryRepository;
    late ViewDrugDetailUsecase usecase;
    const snapshotCodec = DrugBookmarkSnapshotCodec();

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      apiClient = _MockDrugApiClient();
      drugRepository = DrugRepository(apiClient);
      bookmarkRepository = BookmarkRepository(db.bookmarksDao);
      browsingHistoryRepository = BrowsingHistoryRepository(
        db.browsingHistoriesDao,
      );
      usecase = ViewDrugDetailUsecase(
        drugRepository: drugRepository,
        browsingHistoryRepository: browsingHistoryRepository,
        bookmarkRepository: bookmarkRepository,
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('execute returns loaded and records browsing history', () async {
      final dto = _drugFixture();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);

      final result = await usecase.execute(dto.id);

      expect(result, isA<DrugDetailLoaded>());
      final loaded = result as DrugDetailLoaded;
      expect(loaded.drug.id, dto.id);
      expect(loaded.isBookmarked, isFalse);
      final histories = await browsingHistoryRepository.findAll();
      expect((histories as Ok).value, isNotEmpty);
    });

    test('execute updates bookmark snapshot when bookmarked', () async {
      final dto = _drugFixture();
      final drug = dto.toDomain();
      when(() => apiClient.getDrug(dto.id)).thenAnswer((_) async => dto);
      await bookmarkRepository.insert(
        id: dto.id,
        snapshotJson: snapshotCodec.encode(snapshotCodec.fromDrug(drug)),
        bookmarkedAt: DateTime.utc(2026, 5, 4),
      );

      final result = await usecase.execute(dto.id);

      expect(result, isA<DrugDetailLoaded>());
      expect((result as DrugDetailLoaded).isBookmarked, isTrue);
      final bookmark = await bookmarkRepository.findById(dto.id);
      final snapshot = snapshotCodec.decode(
        (bookmark as Ok<BookmarkEntry?>).value!.snapshotJson,
      );
      expect(snapshot.brandName, drug.brandName);
    });

    test(
      'network failure with bookmark snapshot returns offline fallback',
      () async {
        final dto = _drugFixture();
        final snapshot = snapshotCodec.fromDrug(dto.toDomain());
        when(() => apiClient.getDrug(dto.id)).thenThrow(_connectionError());
        await bookmarkRepository.insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(snapshot),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );

        final result = await usecase.execute(dto.id);

        expect(result, isA<DrugDetailOfflineFallback>());
        final fallback = result as DrugDetailOfflineFallback;
        expect(fallback.snapshot.id, dto.id);
        expect(fallback.cause, isA<NetworkException>());
      },
    );

    test('404 failure does not use bookmark fallback', () async {
      when(() => apiClient.getDrug('missing')).thenThrow(_badResponse(404));

      final result = await usecase.execute('missing');

      expect(result, isA<DrugDetailFailure>());
      expect((result as DrugDetailFailure).error, isA<ApiException>());
    });
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

DioException _connectionError() {
  return DioException(
    requestOptions: RequestOptions(path: '/v1/drugs/drug_001'),
    type: DioExceptionType.connectionError,
  );
}

DioException _badResponse(int statusCode) {
  final requestOptions = RequestOptions(path: '/v1/drugs/missing');
  return DioException(
    requestOptions: requestOptions,
    response: Response<Object?>(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: {
        'code': 'NOT_FOUND',
        'message': 'missing',
      },
    ),
    type: DioExceptionType.badResponse,
  );
}
