import 'package:fictional_drug_and_disease_ref/app.dart';
import 'package:fictional_drug_and_disease_ref/app_root.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('buildRootApp wraps App with ProviderScope', () {
    final root = buildRootApp();

    expect(root, isA<ProviderScope>());
    expect((root as ProviderScope).child, isA<App>());
  });
}
