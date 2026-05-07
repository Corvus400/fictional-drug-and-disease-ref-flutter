/// Roborazzi-compatible capture result JSON model.
sealed class CaptureResult {
  /// Creates a capture result.
  const CaptureResult();

  /// Golden file path.
  String get goldenPath;

  /// Capture timestamp in nanoseconds.
  int get timestampNs;

  /// Converts this result to JSON.
  Map<String, dynamic> toJson();
}

/// Changed golden result.
class CaptureResultChanged extends CaptureResult {
  /// Creates a changed result.
  const CaptureResultChanged({
    required this.compareFile,
    required this.actualFile,
    required this.goldenFile,
    required this.timestampNs,
    required this.diffPercentage,
    this.contextData = const {},
  });

  /// Compare image path.
  final String compareFile;

  /// Actual image path.
  final String actualFile;

  /// Golden image path.
  final String goldenFile;

  @override
  final int timestampNs;

  /// Changed pixel ratio.
  final double diffPercentage;

  /// Additional context data.
  final Map<String, dynamic> contextData;

  @override
  String get goldenPath => goldenFile;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': 'changed',
    'compare_file_path': compareFile,
    'actual_file_path': actualFile,
    'golden_file_path': goldenFile,
    'timestamp': timestampNs,
    'diff_percentage': diffPercentage,
    'context_data': contextData,
  };
}

/// Added golden result.
class CaptureResultAdded extends CaptureResult {
  /// Creates an added result.
  const CaptureResultAdded({
    required this.compareFile,
    required this.actualFile,
    required this.goldenFile,
    required this.timestampNs,
    this.contextData = const {},
  });

  /// Compare image path.
  final String compareFile;

  /// Actual image path.
  final String actualFile;

  /// Golden image path.
  final String goldenFile;

  @override
  final int timestampNs;

  /// Additional context data.
  final Map<String, dynamic> contextData;

  @override
  String get goldenPath => goldenFile;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': 'added',
    'compare_file_path': compareFile,
    'actual_file_path': actualFile,
    'golden_file_path': goldenFile,
    'timestamp': timestampNs,
    'context_data': contextData,
  };
}

/// Unchanged golden result.
class CaptureResultUnchanged extends CaptureResult {
  /// Creates an unchanged result.
  const CaptureResultUnchanged({
    required this.goldenFile,
    required this.timestampNs,
    this.contextData = const {},
  });

  /// Golden image path.
  final String goldenFile;

  @override
  final int timestampNs;

  /// Additional context data.
  final Map<String, dynamic> contextData;

  @override
  String get goldenPath => goldenFile;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': 'unchanged',
    'golden_file_path': goldenFile,
    'timestamp': timestampNs,
    'context_data': contextData,
  };
}

/// Recorded golden result.
class CaptureResultRecorded extends CaptureResult {
  /// Creates a recorded result.
  const CaptureResultRecorded({
    required this.goldenFile,
    required this.timestampNs,
    this.contextData = const {},
  });

  /// Golden image path.
  final String goldenFile;

  @override
  final int timestampNs;

  /// Additional context data.
  final Map<String, dynamic> contextData;

  @override
  String get goldenPath => goldenFile;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': 'recorded',
    'golden_file_path': goldenFile,
    'timestamp': timestampNs,
    'context_data': contextData,
  };
}
