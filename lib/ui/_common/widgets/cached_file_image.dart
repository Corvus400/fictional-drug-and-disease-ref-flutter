import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/cached_file_image_unsupported.dart'
    if (dart.library.io) 'package:fictional_drug_and_disease_ref/ui/_common/widgets/cached_file_image_io.dart'
    if (dart.library.js_interop) 'package:fictional_drug_and_disease_ref/ui/_common/widgets/cached_file_image_web.dart'
    as impl;
import 'package:flutter/widgets.dart';

/// Builds an image from a cache-manager file when the platform supports it.
Widget buildCachedFileImage({
  required Object file,
  required Key imageKey,
  required BoxFit fit,
  required ImageErrorWidgetBuilder errorBuilder,
  int? cacheWidth,
  double? width,
  double? height,
}) {
  return impl.buildCachedFileImage(
    file: file,
    imageKey: imageKey,
    fit: fit,
    errorBuilder: errorBuilder,
    cacheWidth: cacheWidth,
    width: width,
    height: height,
  );
}
