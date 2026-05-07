import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/toggle_bookmark_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('ToggleBookmarkUsecase', () {
    late AppDatabase db;
    late BookmarkRepository bookmarkRepository;
    late ToggleBookmarkUsecase usecase;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      bookmarkRepository = BookmarkRepository(db.bookmarksDao);
      usecase = ToggleBookmarkUsecase(
        bookmarkRepository: bookmarkRepository,
        drugCodec: const DrugBookmarkSnapshotCodec(),
        diseaseCodec: const DiseaseBookmarkSnapshotCodec(),
      );
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test(
      'toggleDrug adds a bookmark snapshot when it is not bookmarked',
      () async {
        final drug = _drugFixture().toDomain();

        final result = await usecase.toggleDrug(
          drug: drug,
          currentlyBookmarked: false,
        );

        expect(result, isA<Ok<void>>());
        final bookmark = await bookmarkRepository.findById(drug.id);
        final entry = (bookmark as Ok<BookmarkEntry?>).value;
        expect(entry, isNotNull);
        expect(entry!.id, drug.id);
        expect(
          const DrugBookmarkSnapshotCodec()
              .decode(entry.snapshotJson)
              .brandName,
          drug.brandName,
        );
      },
    );

    test(
      'toggleDrug deletes the bookmark when it is already bookmarked',
      () async {
        final drug = _drugFixture().toDomain();
        await bookmarkRepository.insert(
          id: drug.id,
          snapshotJson: const DrugBookmarkSnapshotCodec().encode(
            const DrugBookmarkSnapshotCodec().fromDrug(drug),
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 7),
        );

        final result = await usecase.toggleDrug(
          drug: drug,
          currentlyBookmarked: true,
        );

        expect(result, isA<Ok<void>>());
        final bookmark = await bookmarkRepository.findById(drug.id);
        expect((bookmark as Ok<BookmarkEntry?>).value, isNull);
      },
    );

    test(
      'toggleDisease adds a disease bookmark snapshot when it is not bookmarked',
      () async {
        final disease = _diseaseFixture().toDomain();

        final result = await usecase.toggleDisease(
          disease: disease,
          currentlyBookmarked: false,
        );

        expect(result, isA<Ok<void>>());
        final bookmark = await bookmarkRepository.findById(disease.id);
        final entry = (bookmark as Ok<BookmarkEntry?>).value;
        expect(entry, isNotNull);
        expect(
          const DiseaseBookmarkSnapshotCodec().decode(entry!.snapshotJson).name,
          disease.name,
        );
      },
    );

    test('toggleDrug returns a storage error when insert fails', () async {
      final drug = _drugFixture().toDomain();
      await bookmarkRepository.insert(
        id: drug.id,
        snapshotJson: const DrugBookmarkSnapshotCodec().encode(
          const DrugBookmarkSnapshotCodec().fromDrug(drug),
        ),
        bookmarkedAt: DateTime.utc(2026, 5, 7),
      );

      final result = await usecase.toggleDrug(
        drug: drug,
        currentlyBookmarked: false,
      );

      expect(result, isA<Err<void>>());
      expect((result as Err<void>).error, isA<StorageException>());
    });
  });
}

DrugDto _drugFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_drugs__id_.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DrugDto.fromJson(json);
}

DiseaseDto _diseaseFixture() {
  final fixture = File(
    'test/fixtures/swagger/get_v1_diseases__id_.json',
  ).readAsStringSync();
  final json = jsonDecode(fixture) as Map<String, dynamic>;
  return DiseaseDto.fromJson(json);
}
