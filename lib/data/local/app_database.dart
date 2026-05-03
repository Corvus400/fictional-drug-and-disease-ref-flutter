import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// App-wide local database.
// Keep the empty table list explicit until Phase 4 registers drift tables.
// ignore: avoid_redundant_argument_values
@DriftDatabase(tables: [])
class AppDatabase extends _$AppDatabase {
  /// Creates the database with an optional executor for tests.
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'app.db'));
    return NativeDatabase(file);
  });
}
