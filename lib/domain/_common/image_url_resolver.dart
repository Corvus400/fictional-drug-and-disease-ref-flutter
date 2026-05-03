/// Resolves an API-relative image URL against the configured base URL.
Uri resolveImageUrl({required String baseUrl, required String imageUrl}) {
  final base = Uri.parse(baseUrl);
  return base.resolve(imageUrl);
}
