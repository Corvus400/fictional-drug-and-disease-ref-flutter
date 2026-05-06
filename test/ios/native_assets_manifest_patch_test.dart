import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('patches bundled iOS native asset paths to Runner.app Frameworks', () {
    final script = File('ios/scripts/patch_native_assets_manifest.sh');
    expect(script.existsSync(), isTrue);

    final temp = Directory.systemTemp.createTempSync(
      'native-assets-manifest-test-',
    );
    addTearDown(() => temp.deleteSync(recursive: true));

    final app = Directory('${temp.path}/Runner.app')..createSync();
    Directory(
      '${app.path}/Frameworks/App.framework/flutter_assets',
    ).createSync(recursive: true);
    Directory(
      '${app.path}/Frameworks/objective_c.framework',
    ).createSync(recursive: true);
    Directory('${app.path}/Frameworks/sqlite3.framework').createSync(
      recursive: true,
    );
    File(
      '${app.path}/Frameworks/objective_c.framework/objective_c',
    ).writeAsStringSync('');
    File('${app.path}/Frameworks/sqlite3.framework/sqlite3').writeAsStringSync(
      '',
    );

    final manifest =
        File(
          '${app.path}/Frameworks/App.framework/flutter_assets/'
          'NativeAssetsManifest.json',
        )..writeAsStringSync(
          '{"format-version":[1,0,0],"native-assets":{"ios_arm64":{'
          '"package:objective_c/objective_c.dylib":["absolute",'
          '"objective_c.framework/objective_c"],'
          '"package:sqlite3/src/ffi/libsqlite3.g.dart":["absolute",'
          '"sqlite3.framework/sqlite3"]}}}',
        );

    final result = Process.runSync(
      script.path,
      const [],
      environment: {
        'TARGET_BUILD_DIR': temp.path,
        'WRAPPER_NAME': 'Runner.app',
      },
    );

    expect(result.exitCode, 0, reason: '${result.stdout}\n${result.stderr}');
    final patched = manifest.readAsStringSync();
    expect(
      patched,
      contains(
        '"@executable_path/Frameworks/objective_c.framework/objective_c"',
      ),
    );
    expect(
      patched,
      contains('"@executable_path/Frameworks/sqlite3.framework/sqlite3"'),
    );
  });
}
