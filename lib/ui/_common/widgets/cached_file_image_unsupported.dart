import 'package:flutter/widgets.dart';

/// Builds the fallback on platforms that cannot decode file-backed images.
Widget buildCachedFileImage({
  required Object file,
  required Key imageKey,
  required BoxFit fit,
  required ImageErrorWidgetBuilder errorBuilder,
  int? cacheWidth,
  double? width,
  double? height,
}) {
  return Builder(
    key: imageKey,
    builder: (context) => errorBuilder(
      context,
      UnsupportedError('File images are not supported on this platform.'),
      StackTrace.current,
    ),
  );
}
