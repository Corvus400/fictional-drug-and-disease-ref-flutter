part of '../search_view.dart';

const _drugCardImageCacheKeyVersion = 'v2';

String _drugCardImageUrl(String imageUrl) {
  final base = Uri.parse(ApiConfig.current.apiBaseUrl);
  final resolved = base.resolve(imageUrl);
  return resolved
      .replace(
        queryParameters: {
          ...resolved.queryParameters,
          'size': SearchConstants.searchDrugCardImageApiSize,
        },
      )
      .toString();
}

String _drugCardImageCacheKey(String imageUrl) {
  return 'drug-card-image-$_drugCardImageCacheKeyVersion::'
      '${_drugCardImageUrl(imageUrl)}';
}
