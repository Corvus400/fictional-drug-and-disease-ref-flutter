import 'dart:async';
import 'dart:io';

import 'package:file/file.dart' as file;
import 'package:file/local.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/cache/resized_image_cache_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
}

final class _TestResizedImageCacheManager extends ResizedImageCacheManager {
  _TestResizedImageCacheManager({required this.cachedFile})
    : super.testing(Config('test-resized-image-cache'));

  final file.File cachedFile;
  int getImageFileCalls = 0;

  @override
  Stream<FileResponse> imageFileResponses({
    required String url,
    required String key,
    required int maxWidth,
    required int maxHeight,
  }) {
    getImageFileCalls += 1;
    return Stream<FileResponse>.value(
      FileInfo(cachedFile, FileSource.Online, DateTime(2099), url),
    );
  }

  @override
  Future<void> removeOriginalFile(String key) async {}
}

file.File _writeTestFile(String name) {
  const fileSystem = LocalFileSystem();
  final ioFile = File('${Directory.systemTemp.path}/$name')
    ..writeAsBytesSync([1, 2, 3]);
  return fileSystem.file(ioFile.path);
}
