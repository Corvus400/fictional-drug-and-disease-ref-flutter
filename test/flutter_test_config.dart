import 'dart:async';
import 'dart:io' show Directory, Platform, stderr;

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import 'golden/_comparator/diff_image_comparator.dart';
import 'golden/_helpers/font_loader.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  final suppressGoldenHostWarning =
      Platform.environment['SUPPRESS_GOLDEN_HOST_WARNING'] == 'true';
  if (!Platform.isMacOS && !suppressGoldenHostWarning) {
    stderr.writeln(
      'WARNING: Golden tests are designed for macOS only. '
      'Generated images on this host (${Platform.operatingSystem}) '
      'MUST NOT be committed.',
    );
  }

  TestWidgetsFlutterBinding.ensureInitialized();
  await loadAppFontsForTest();

  final cwd = Directory.current.path;
  final existingComparator = goldenFileComparator;
  final resolvedTestFile = existingComparator is LocalFileComparator
      ? existingComparator.basedir.resolve('_resolved.dart')
      : Uri.file(p.join(cwd, 'test', '_resolved.dart'));
  goldenFileComparator = DiffImageComparator(
    resolvedTestFile,
    outputRoot: p.join(cwd, 'build', 'outputs', 'golden'),
    resultsRoot: p.join(cwd, 'build', 'test-results', 'golden'),
  );

  await AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: Platform.isMacOS,
        platforms: {HostPlatform.macOS},
        // ignore: avoid_redundant_argument_values, explicit golden default
        renderShadows: true,
        // ignore: avoid_redundant_argument_values, explicit golden default
        obscureText: false,
      ),
      ciGoldensConfig: const CiGoldensConfig(enabled: false),
    ),
    run: testMain,
  );
}
