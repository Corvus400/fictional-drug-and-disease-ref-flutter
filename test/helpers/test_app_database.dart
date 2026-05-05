import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';

AppDatabase createTestAppDatabase() {
  return AppDatabase(NativeDatabase.memory());
}

Future<void> clearTestAppDatabase(AppDatabase db) async {
  for (final table in db.allTables) {
    await db.delete(table).go();
  }
}
