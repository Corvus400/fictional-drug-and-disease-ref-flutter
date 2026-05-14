import 'dart:io' as io;

import 'package:flutter/widgets.dart';

/// Builds an image from a cache-manager file on dart:io platforms.
Widget buildCachedFileImage({
  required Object file,
  required Key imageKey,
  required BoxFit fit,
  required ImageErrorWidgetBuilder errorBuilder,
  int? cacheWidth,
  double? width,
  double? height,
}) {
  return Image.file(
    io.File((file as dynamic).path as String),
    key: imageKey,
    fit: fit,
    cacheWidth: cacheWidth,
    width: width,
    height: height,
    errorBuilder: errorBuilder,
  );
}
