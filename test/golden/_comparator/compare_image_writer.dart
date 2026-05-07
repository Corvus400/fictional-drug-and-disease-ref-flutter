import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

import 'capture_result_json.dart';

/// Writes roborazzi-compatible compare and actual PNG artifacts.
class CompareImageWriter {
  /// Creates a writer rooted at [outputRoot].
  CompareImageWriter({required this.outputRoot});

  /// Output directory for compare and actual PNGs.
  final String outputRoot;

  static const double _maxDistance = 0.007;
  static const int _paneSpacing = 16;
  static const int _labelHeight = 20;

  /// Writes compare, actual, and returns the capture result.
  Future<CaptureResult> writeAll({
    required String goldenName,
    required Uint8List? goldenBytes,
    required Uint8List actualBytes,
    required String goldenPath,
    required int timestampNs,
  }) async {
    final outDir = Directory(outputRoot);
    if (!outDir.existsSync()) {
      outDir.createSync(recursive: true);
    }

    final actualImage = img.decodePng(actualBytes);
    if (actualImage == null) {
      throw StateError('Failed to decode actual PNG bytes for $goldenName');
    }
    final goldenImage = goldenBytes != null ? img.decodePng(goldenBytes) : null;
    final diffResult = _computeDiff(goldenImage, actualImage);
    final compareImage = _buildComparePane(
      golden: goldenImage,
      actual: actualImage,
      diff: diffResult.diffImage,
      goldenLabel: goldenImage != null ? 'GOLDEN' : 'MISSING',
    );

    final compareFile = File(p.join(outputRoot, '${goldenName}_compare.png'))
      ..writeAsBytesSync(img.encodePng(compareImage));

    final actualFile = File(p.join(outputRoot, '${goldenName}_actual.png'))
      ..writeAsBytesSync(actualBytes);

    if (goldenImage != null) {
      return CaptureResultChanged(
        compareFile: compareFile.absolute.path,
        actualFile: actualFile.absolute.path,
        goldenFile: goldenPath,
        timestampNs: timestampNs,
        diffPercentage: diffResult.diffPercentage,
      );
    }

    return CaptureResultAdded(
      compareFile: compareFile.absolute.path,
      actualFile: actualFile.absolute.path,
      goldenFile: goldenPath,
      timestampNs: timestampNs,
    );
  }

  _DiffResult _computeDiff(img.Image? golden, img.Image actual) {
    if (golden == null ||
        golden.width != actual.width ||
        golden.height != actual.height) {
      final diff = img.Image(width: actual.width, height: actual.height);
      img.fill(diff, color: img.ColorRgb8(255, 0, 0));
      return _DiffResult(diff, 1);
    }

    final diff = img.Image(width: actual.width, height: actual.height);
    var changedCount = 0;
    final totalPx = actual.width * actual.height;

    for (var y = 0; y < actual.height; y++) {
      for (var x = 0; x < actual.width; x++) {
        final actualPixel = actual.getPixel(x, y);
        final goldenPixel = golden.getPixel(x, y);
        final dr = (actualPixel.r - goldenPixel.r) / 255.0;
        final dg = (actualPixel.g - goldenPixel.g) / 255.0;
        final db = (actualPixel.b - goldenPixel.b) / 255.0;
        final distSq = dr * dr + dg * dg + db * db;
        if (distSq > _maxDistance * _maxDistance) {
          diff.setPixelRgb(x, y, 255, 0, 0);
          changedCount++;
        } else {
          diff.setPixelRgb(x, y, 255, 255, 255);
        }
      }
    }

    return _DiffResult(diff, changedCount / totalPx);
  }

  img.Image _buildComparePane({
    required img.Image? golden,
    required img.Image actual,
    required img.Image diff,
    required String goldenLabel,
  }) {
    final paneW = actual.width;
    final paneH = actual.height;
    final totalW = paneW * 3 + _paneSpacing * 2;
    final totalH = paneH + _labelHeight;

    final canvas = img.Image(width: totalW, height: totalH);
    img.fill(canvas, color: img.ColorRgb8(245, 245, 245));

    if (golden != null) {
      img.compositeImage(canvas, golden, dstX: 0, dstY: _labelHeight);
    } else {
      img.fillRect(
        canvas,
        x1: 0,
        y1: _labelHeight,
        x2: paneW - 1,
        y2: _labelHeight + paneH - 1,
        color: img.ColorRgb8(0, 0, 0),
      );
    }

    img.compositeImage(
      canvas,
      actual,
      dstX: paneW + _paneSpacing,
      dstY: _labelHeight,
    );
    img.compositeImage(
      canvas,
      diff,
      dstX: (paneW + _paneSpacing) * 2,
      dstY: _labelHeight,
    );

    final font = img.arial14;
    final labelColor = img.ColorRgb8(0, 0, 0);
    img.drawString(
      canvas,
      goldenLabel,
      font: font,
      x: 4,
      y: 2,
      color: labelColor,
    );
    img.drawString(
      canvas,
      'ACTUAL',
      font: font,
      x: paneW + _paneSpacing + 4,
      y: 2,
      color: labelColor,
    );
    img.drawString(
      canvas,
      'DIFF',
      font: font,
      x: (paneW + _paneSpacing) * 2 + 4,
      y: 2,
      color: labelColor,
    );

    return canvas;
  }
}

class _DiffResult {
  _DiffResult(this.diffImage, this.diffPercentage);

  final img.Image diffImage;
  final double diffPercentage;
}
