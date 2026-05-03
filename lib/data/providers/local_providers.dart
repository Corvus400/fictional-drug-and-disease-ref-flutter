import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App database provider.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
