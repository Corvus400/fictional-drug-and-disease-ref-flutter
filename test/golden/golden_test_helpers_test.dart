import 'package:flutter_test/flutter_test.dart';

import 'golden_test_helpers.dart';

void main() {
  group('golden test host gating', () {
    test('registers platform golden tests only on macOS hosts', () {
      expect(shouldRegisterGoldenTestsForHost('macos'), isTrue);
      expect(shouldRegisterGoldenTestsForHost('linux'), isFalse);
      expect(shouldRegisterGoldenTestsForHost('windows'), isFalse);
    });
  });
}
