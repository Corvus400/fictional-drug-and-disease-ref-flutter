part of '../search_view.dart';

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
