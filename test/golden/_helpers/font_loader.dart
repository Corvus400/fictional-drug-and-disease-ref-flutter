import 'dart:convert';

import 'package:flutter/services.dart' show FontLoader, rootBundle;

/// Loads fonts declared in FontManifest.json into the Flutter test runner.
///
/// Flutter tests default to Ahem, which renders glyphs as black boxes. Golden
/// tests must load the app fonts explicitly to make Japanese text readable.
Future<void> loadAppFontsForTest() async {
  final manifestRaw = await rootBundle.loadString('FontManifest.json');
  final manifestList = json.decode(manifestRaw) as List<dynamic>;
  if (manifestList.isEmpty) {
    throw StateError(
      'FontManifest.json is empty. Ensure pubspec.yaml has '
      "'uses-material-design: true' and 'fonts:' declarations.",
    );
  }

  for (final entry in manifestList) {
    final entryMap = entry as Map<String, dynamic>;
    final family = entryMap['family'] as String;
    final fonts = entryMap['fonts'] as List<dynamic>;
    final loader = FontLoader(family);
    for (final font in fonts) {
      final fontMap = font as Map<String, dynamic>;
      final asset = fontMap['asset'] as String;
      final byteData = await rootBundle.load(asset);
      loader.addFont(Future.value(byteData));
    }
    await loader.load();
  }

  final familyNames = manifestList
      .map((entry) => (entry as Map<String, dynamic>)['family'] as String)
      .toSet();
  if (!familyNames.contains('NotoSansJP')) {
    throw StateError(
      'NotoSansJP is not registered in FontManifest.json. '
      'Bundled families: $familyNames. '
      "Check pubspec.yaml's 'flutter > fonts' section.",
    );
  }
}
