import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';

/// Decides whether detail loading may fall back to a bookmark snapshot.
bool canUseBookmarkSnapshotFallback(AppException error) {
  return error is NetworkException || error is ServerException;
}
