import 'package:drift/drift.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database_connection_unsupported.dart'
    if (dart.library.io) 'package:fictional_drug_and_disease_ref/data/local/app_database_connection_io.dart'
    as impl;

/// Opens the platform-specific Drift database connection.
QueryExecutor openConnection() {
  return impl.openConnection();
}
