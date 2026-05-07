import 'package:flutter_test/flutter_test.dart';

/// Compile-time placeholder wired in Phase 2.
///
/// Phase 4 replaces this with the roborazzi-compatible implementation that
/// writes *_compare.png, *_actual.png, JSON, and HTML report inputs.
class DiffImageComparator extends LocalFileComparator {
  DiffImageComparator(
    super.testFile, {
    required this.outputRoot,
    required this.resultsRoot,
  });

  final String outputRoot;
  final String resultsRoot;
}
