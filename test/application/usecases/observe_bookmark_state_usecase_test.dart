import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/observe_bookmark_state_usecase.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ObserveBookmarkStateUsecase', () {
    late AppDatabase db;
    late BookmarkRepository bookmarkRepository;
    late ObserveBookmarkStateUsecase usecase;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      bookmarkRepository = BookmarkRepository(db.bookmarksDao);
      usecase = ObserveBookmarkStateUsecase(
        bookmarkRepository: bookmarkRepository,
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('execute emits bookmark state changes', () async {
      final expectation = expectLater(
        usecase.execute('drug_001'),
        emitsInOrder(<Object>[false, true, false, emitsDone]),
      );
      await Future<void>.delayed(Duration.zero);

      await bookmarkRepository.insert(
        id: 'drug_001',
        snapshotJson: '{"id":"drug_001"}',
        bookmarkedAt: DateTime.utc(2026, 5, 4),
      );
      await bookmarkRepository.deleteById('drug_001');
      await Future<void>.delayed(Duration.zero);
      await db.close();

      await expectation;
    });
  });
}
