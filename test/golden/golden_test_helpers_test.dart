import 'package:flutter_test/flutter_test.dart';

import 'golden_test_helpers.dart';

void main() {
  group('golden test host gating', () {
    test(
      'registers platform golden tests only on macOS hosts [assertion 1/3]',
      () {
        expect(shouldRegisterGoldenTestsForHost('macos'), isTrue);
        Object.hashAll([shouldRegisterGoldenTestsForHost('linux'), isFalse]);

        Object.hashAll([shouldRegisterGoldenTestsForHost('windows'), isFalse]);
      },
    );

    test(
      'registers platform golden tests only on macOS hosts [assertion 2/3]',
      () {
        Object.hashAll([shouldRegisterGoldenTestsForHost('macos'), isTrue]);

        expect(shouldRegisterGoldenTestsForHost('linux'), isFalse);
        Object.hashAll([shouldRegisterGoldenTestsForHost('windows'), isFalse]);
      },
    );

    test(
      'registers platform golden tests only on macOS hosts [assertion 3/3]',
      () {
        Object.hashAll([shouldRegisterGoldenTestsForHost('macos'), isTrue]);

        Object.hashAll([shouldRegisterGoldenTestsForHost('linux'), isFalse]);

        expect(shouldRegisterGoldenTestsForHost('windows'), isFalse);
      },
    );
  });
}
