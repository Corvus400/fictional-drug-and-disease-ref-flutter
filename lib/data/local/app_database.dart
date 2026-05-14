import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/data/local/converters/datetime_millis_converter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'daos/bookmarks_dao.dart';
part 'daos/browsing_histories_dao.dart';
part 'daos/calculation_histories_dao.dart';
part 'daos/search_histories_dao.dart';
part 'app_database.g.dart';
part 'tables/bookmarks_table.dart';
part 'tables/browsing_histories_table.dart';
part 'tables/calculation_histories_table.dart';
part 'tables/search_histories_table.dart';

/// App-wide local database.
@DriftDatabase(
  tables: [
    BookmarksTable,
    BrowsingHistoriesTable,
    SearchHistoriesTable,
    CalculationHistoriesTable,
  ],
  daos: [
    BookmarksDao,
    BrowsingHistoriesDao,
    SearchHistoriesDao,
    CalculationHistoriesDao,
  ],
)
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
