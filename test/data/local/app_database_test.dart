import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  late AppDatabase db;
  var dbClosedByTest = false;

  setUpAll(() {
    db = createTestAppDatabase();
  });

  tearDown(() async {
    if (dbClosedByTest) {
      return;
    }
    await clearTestAppDatabase(db);
  });

  tearDownAll(() async {
    await db.close();
  });

  test('AppDatabase can be instantiated with in-memory executor', () async {
    expect(db, isA<AppDatabase>());
  });

  test('schemaVersion is 1', () async {
    expect(db.schemaVersion, 1);
  });

  test('close is idempotent', () async {
    await db.close();
    await db.close();
    dbClosedByTest = true;
  });
}
