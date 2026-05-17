import 'dart:async';
import 'dart:io';

import 'package:file/file.dart' as file;
import 'package:file/local.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/cache/resized_image_cache_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp(
      'resized_image_cache_manager_test',
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async {
            return switch (call.method) {
              'getTemporaryDirectory' => tempDir.path,
              'getApplicationSupportDirectory' => tempDir.path,
              _ => null,
            };
          },
        );
  });

  tearDownAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          null,
        );
    await tempDir.delete(recursive: true);
  });

  test('resizedFile requests one resized image stream', () async {
    final manager = _TestResizedImageCacheManager(
      cachedFile: _writeTestFile('todo1.png'),
    );

    await manager.resizedFile(
      url: 'https://api.example.test/image.png?size=M',
      originalKey: 'image-key',
      maxWidth: 168,
      maxHeight: 252,
    );

    expect(manager.getImageFileCalls, 1);
  });

  test(
    'resizedFile removes the original cache key after image retrieval',
    () async {
      final manager = _TestResizedImageCacheManager(
        cachedFile: _writeTestFile('todo2.png'),
      );

      await manager.resizedFile(
        url: 'https://api.example.test/image.png?size=M',
        originalKey: 'image-key',
        maxWidth: 168,
        maxHeight: 252,
      );

      expect(manager.removedOriginalKeys, ['image-key']);
    },
  );

  test(
    'resizedFile keeps the original cache key when image retrieval fails',
    () async {
      final manager = _TestResizedImageCacheManager(
        cachedFile: _writeTestFile('todo3.png'),
        imageResponseError: StateError('download failed'),
      );

      try {
        await manager.resizedFile(
          url: 'https://api.example.test/image.png?size=M',
          originalKey: 'image-key',
          maxWidth: 168,
          maxHeight: 252,
        );
      } on StateError {
        // Expected in this test; the assertion is that removal did not run.
      }

      expect(manager.removedOriginalKeys, isEmpty);
    },
  );
}

final class _TestResizedImageCacheManager extends ResizedImageCacheManager {
  _TestResizedImageCacheManager({
    required this.cachedFile,
    this.imageResponseError,
  }) : super.testing(
         Config(
           'test-resized-image-cache',
           repo: NonStoringObjectProvider(),
         ),
       );

  final file.File cachedFile;
  final Object? imageResponseError;
  int getImageFileCalls = 0;
  final List<String> removedOriginalKeys = [];

  @override
  Stream<FileResponse> imageFileResponses({
    required String url,
    required String key,
    required int maxWidth,
    required int maxHeight,
  }) {
    getImageFileCalls += 1;
    final imageResponseError = this.imageResponseError;
    if (imageResponseError != null) {
      return Stream<FileResponse>.error(imageResponseError);
    }
    return Stream<FileResponse>.value(
      FileInfo(cachedFile, FileSource.Online, DateTime(2099), url),
    );
  }

  @override
  Future<void> removeOriginalFile(String key) async {
    removedOriginalKeys.add(key);
  }
}

file.File _writeTestFile(String name) {
  const fileSystem = LocalFileSystem();
  final ioFile = File('${Directory.systemTemp.path}/$name')
    ..writeAsBytesSync([1, 2, 3]);
  return fileSystem.file(ioFile.path);
}
