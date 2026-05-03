import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

// Drift table columns are read by generated code, not directly from this test.
// ignore_for_file: unreachable_from_main

part 'sample_drift_test.g.dart';

class SampleTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get value => text()();
}

@DriftDatabase(tables: [SampleTable])
class SampleDb extends _$SampleDb {
  SampleDb(super.e);

  @override
  int get schemaVersion => 1;
}

void main() {
  late SampleDb db;

  setUp(() {
    db = SampleDb(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('insert and read sample row', () async {
    await db
        .into(db.sampleTable)
        .insert(
          SampleTableCompanion.insert(value: 'hello'),
        );
    final rows = await db.select(db.sampleTable).get();
    expect(rows, hasLength(1));
    expect(rows.first.value, 'hello');
  });
}
