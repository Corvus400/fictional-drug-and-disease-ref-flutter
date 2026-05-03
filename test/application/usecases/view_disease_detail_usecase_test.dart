import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/view_disease_detail_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/disease_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('ViewDiseaseDetailUsecase', () {
    late AppDatabase db;
    late _MockDiseaseApiClient apiClient;
    late DiseaseRepository diseaseRepository;
    late BookmarkRepository bookmarkRepository;
    late BrowsingHistoryRepository browsingHistoryRepository;
    late ViewDiseaseDetailUsecase usecase;
    const snapshotCodec = DiseaseBookmarkSnapshotCodec();

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      apiClient = _MockDiseaseApiClient();
      diseaseRepository = DiseaseRepository(apiClient);
      bookmarkRepository = BookmarkRepository(db.bookmarksDao);
      browsingHistoryRepository = BrowsingHistoryRepository(
        db.browsingHistoriesDao,
      );
      usecase = ViewDiseaseDetailUsecase(
        diseaseRepository: diseaseRepository,
        browsingHistoryRepository: browsingHistoryRepository,
        bookmarkRepository: bookmarkRepository,
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('execute returns loaded and records browsing history', () async {
      final dto = _diseaseFixture();
      when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);

      final result = await usecase.execute(dto.id);

      expect(result, isA<DiseaseDetailLoaded>());
      final loaded = result as DiseaseDetailLoaded;
      expect(loaded.disease.id, dto.id);
      expect(loaded.isBookmarked, isFalse);
      final histories = await browsingHistoryRepository.findAll();
      expect((histories as Ok).value, isNotEmpty);
    });

    test('execute updates bookmark snapshot when bookmarked', () async {
      final dto = _diseaseFixture();
      final disease = dto.toDomain();
      when(() => apiClient.getDisease(dto.id)).thenAnswer((_) async => dto);
      await bookmarkRepository.insert(
        id: dto.id,
        snapshotJson: snapshotCodec.encode(
          snapshotCodec.fromDisease(disease),
        ),
        bookmarkedAt: DateTime.utc(2026, 5, 4),
      );

      final result = await usecase.execute(dto.id);

      expect(result, isA<DiseaseDetailLoaded>());
      expect((result as DiseaseDetailLoaded).isBookmarked, isTrue);
      final bookmark = await bookmarkRepository.findById(dto.id);
      final snapshot = snapshotCodec.decode(
        (bookmark as Ok<BookmarkEntry?>).value!.snapshotJson,
      );
      expect(snapshot.name, disease.name);
    });

    test(
      'network failure with bookmark snapshot returns offline fallback',
      () async {
        final dto = _diseaseFixture();
        final snapshot = snapshotCodec.fromDisease(dto.toDomain());
        when(() => apiClient.getDisease(dto.id)).thenThrow(_connectionError());
        await bookmarkRepository.insert(
          id: dto.id,
          snapshotJson: snapshotCodec.encode(snapshot),
          bookmarkedAt: DateTime.utc(2026, 5, 4),
        );

        final result = await usecase.execute(dto.id);

        expect(result, isA<DiseaseDetailOfflineFallback>());
        final fallback = result as DiseaseDetailOfflineFallback;
        expect(fallback.snapshot.id, dto.id);
        expect(fallback.cause, isA<NetworkException>());
      },
    );

    test('404 failure does not use bookmark fallback', () async {
      when(() => apiClient.getDisease('missing')).thenThrow(_badResponse(404));

      final result = await usecase.execute('missing');

      expect(result, isA<DiseaseDetailFailure>());
      expect((result as DiseaseDetailFailure).error, isA<ApiException>());
    });
  });
}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

DiseaseDto _diseaseFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_diseases__id_.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DiseaseDto.fromJson(json);
}

DioException _connectionError() {
  return DioException(
    requestOptions: RequestOptions(path: '/v1/diseases/disease_001'),
    type: DioExceptionType.connectionError,
  );
}

DioException _badResponse(int statusCode) {
  final requestOptions = RequestOptions(path: '/v1/diseases/missing');
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
