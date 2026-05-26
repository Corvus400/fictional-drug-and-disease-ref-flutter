import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('main AndroidManifest declares INTERNET for release APKs', () {
    final manifest = File('android/app/src/main/AndroidManifest.xml');

    expect(
      manifest.existsSync() ? manifest.readAsStringSync() : '',
      contains('android.permission.INTERNET'),
    );
  });
}
