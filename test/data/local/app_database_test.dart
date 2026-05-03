import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppDatabase can be instantiated with in-memory executor', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    expect(db, isA<AppDatabase>());
  });

  test('schemaVersion is 1', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    expect(db.schemaVersion, 1);
  });

  test('close is idempotent', () async {
    final db = AppDatabase(NativeDatabase.memory());

    await db.close();
    await db.close();
  });
}
