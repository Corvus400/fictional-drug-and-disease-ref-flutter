import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import 'capture_result_json.dart';
import 'compare_image_writer.dart';

/// Local golden comparator that writes roborazzi-compatible diff artifacts.
class DiffImageComparator extends LocalFileComparator {
  /// Creates a comparator.
  DiffImageComparator(
    super.testFile, {
    required this.outputRoot,
    required this.resultsRoot,
    bool? compareOnly,
  }) : compareOnly =
           compareOnly ??
           Platform.environment['GOLDEN_VRT_COMPARE_ONLY'] == 'true';

  final String outputRoot;
  final String resultsRoot;
  final bool compareOnly;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final goldenName = p.basenameWithoutExtension(golden.path);
    if (goldenName.endsWith('_compare') || goldenName.endsWith('_actual')) {
      throw ArgumentError(
        'Golden file name must not end with _compare or _actual; '
        'these suffixes are reserved for diff artifacts.',
      );
    }

    final goldenFile = _goldenFile(golden);
    final goldenExists = goldenFile.existsSync();
    final goldenBytes = goldenExists ? goldenFile.readAsBytesSync() : null;
    final timestampNs = DateTime.now().microsecondsSinceEpoch * 1000;

    if (goldenExists) {
      final result = await GoldenFileComparator.compareLists(
        imageBytes,
        goldenBytes!,
      );
      if (result.passed) {
        result.dispose();
        await _writeJson(
          CaptureResultUnchanged(
            goldenFile: goldenFile.absolute.path,
            timestampNs: timestampNs,
          ),
        );
        return true;
      }
      result.dispose();
    }

    final writer = CompareImageWriter(outputRoot: outputRoot);
    final result = await writer.writeAll(
      goldenName: goldenName,
      goldenBytes: goldenBytes,
      actualBytes: imageBytes,
      goldenPath: goldenFile.absolute.path,
      timestampNs: timestampNs,
      changedPixelRatioTolerance:
          CompareImageWriter.defaultChangedPixelRatioTolerance,
    );

    await _writeJson(result);
    if (compareOnly) {
      return true;
    }
    return result is CaptureResultUnchanged;
  }

  @override
  Future<void> update(Uri golden, Uint8List imageBytes) async {
    await super.update(golden, imageBytes);
    await _writeJson(
      CaptureResultRecorded(
        goldenFile: _goldenFile(golden).absolute.path,
        timestampNs: DateTime.now().microsecondsSinceEpoch * 1000,
      ),
    );
  }

  Future<void> _writeJson(CaptureResult result) async {
    final dir = Directory(resultsRoot);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    final goldenBaseName = p.basenameWithoutExtension(result.goldenPath);
    final fileName = '${goldenBaseName}_${result.timestampNs}.json';
    await File(p.join(dir.path, fileName)).writeAsString(
      jsonEncode(result.toJson()),
    );
  }

  File _goldenFile(Uri golden) {
    return File(p.join(p.fromUri(basedir), p.fromUri(golden.path)));
  }
}
