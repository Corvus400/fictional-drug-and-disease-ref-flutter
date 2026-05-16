import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

import 'diff_image_comparator.dart';

void main() {
  late Directory tempDir;
  late Directory outputDir;
  late Directory resultsDir;
  late DiffImageComparator comparator;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync(
      'diff_image_comparator_test_',
    );
    outputDir = Directory(p.join(tempDir.path, 'outputs'));
    resultsDir = Directory(p.join(tempDir.path, 'results'));
    comparator = DiffImageComparator(
      Uri.file(p.join(tempDir.path, '_resolved.dart')),
      outputRoot: outputDir.path,
      resultsRoot: resultsDir.path,
    );
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  test('passes sparse runner noise without writing diff artifacts', () async {
    final golden = _solidPng(width: 100, height: 100, r: 255, g: 255, b: 255);
    final actual = _solidImage(width: 100, height: 100, r: 255, g: 255, b: 255)
      ..setPixelRgb(0, 0, 0, 0, 0);
    File(p.join(tempDir.path, 'noise.png')).writeAsBytesSync(golden);

    final passed = await comparator.compare(
      img.encodePng(actual),
      Uri.parse('noise.png'),
    );

    expect(passed, isTrue);
    expect(
      File(p.join(outputDir.path, 'noise_compare.png')).existsSync(),
      isFalse,
    );
    expect(
      File(p.join(outputDir.path, 'noise_actual.png')).existsSync(),
      isFalse,
    );
  });

  test(
    'fails meaningful visual differences and writes diff artifacts',
    () async {
      final golden = _solidPng(width: 20, height: 20, r: 255, g: 255, b: 255);
      final actual = _solidImage(width: 20, height: 20, r: 255, g: 255, b: 255);
      for (var y = 0; y < 20; y++) {
        for (var x = 0; x < 20; x++) {
          if (x < 10) {
            actual.setPixelRgb(x, y, 0, 0, 0);
          }
        }
      }
      File(p.join(tempDir.path, 'changed.png')).writeAsBytesSync(golden);

      final passed = await comparator.compare(
        img.encodePng(actual),
        Uri.parse('changed.png'),
      );

      expect(passed, isFalse);
      expect(
        File(p.join(outputDir.path, 'changed_compare.png')).existsSync(),
        isTrue,
      );
      expect(
        File(p.join(outputDir.path, 'changed_actual.png')).existsSync(),
        isTrue,
      );
    },
  );

  test(
    'writes compare image in Reference Diff New pane order',
    () async {
      final golden = _solidPng(width: 4, height: 4, r: 0, g: 0, b: 255);
      final actual = _solidImage(width: 4, height: 4, r: 0, g: 255, b: 0);
      File(p.join(tempDir.path, 'pane_order.png')).writeAsBytesSync(golden);

      await comparator.compare(
        img.encodePng(actual),
        Uri.parse('pane_order.png'),
      );

      final compareBytes = File(
        p.join(outputDir.path, 'pane_order_compare.png'),
      ).readAsBytesSync();
      final compare = img.decodePng(compareBytes)!;

      expect(_rgbAt(compare, 0, 20), (0, 0, 255));
      expect(_rgbAt(compare, 20, 20), (255, 0, 0));
      expect(_rgbAt(compare, 40, 20), (0, 255, 0));
    },
  );

  test(
    'shows only out-of-bounds area as red when image sizes differ',
    () async {
      final golden = _solidPng(width: 4, height: 4, r: 0, g: 0, b: 255);
      final actual = _solidImage(width: 6, height: 4, r: 0, g: 0, b: 255);
      for (var y = 0; y < 4; y++) {
        for (var x = 4; x < 6; x++) {
          actual.setPixelRgb(x, y, 0, 255, 0);
        }
      }
      File(p.join(tempDir.path, 'size_changed.png')).writeAsBytesSync(golden);

      await comparator.compare(
        img.encodePng(actual),
        Uri.parse('size_changed.png'),
      );

      final compareBytes = File(
        p.join(outputDir.path, 'size_changed_compare.png'),
      ).readAsBytesSync();
      final compare = img.decodePng(compareBytes)!;

      expect(_rgbAt(compare, 0, 20), (0, 0, 255));
      expect(_rgbAt(compare, 22, 20), (255, 255, 255));
      expect(_rgbAt(compare, 26, 20), (255, 0, 0));
      expect(_rgbAt(compare, 48, 20), (0, 255, 0));
    },
  );
}

List<int> _solidPng({
  required int width,
  required int height,
  required int r,
  required int g,
  required int b,
}) =>
    img.encodePng(_solidImage(width: width, height: height, r: r, g: g, b: b));

img.Image _solidImage({
  required int width,
  required int height,
  required int r,
  required int g,
  required int b,
}) {
  final image = img.Image(width: width, height: height);
  img.fill(image, color: img.ColorRgb8(r, g, b));
  return image;
}

(int, int, int) _rgbAt(img.Image image, int x, int y) {
  final pixel = image.getPixel(x, y);
  return (pixel.r.toInt(), pixel.g.toInt(), pixel.b.toInt());
}
