import 'package:drift/drift.dart';

/// Throws on platforms where the production Drift connection is unavailable.
QueryExecutor openConnection() {
  throw UnsupportedError(
    'The production Drift connection is not available on this platform.',
  );
}
