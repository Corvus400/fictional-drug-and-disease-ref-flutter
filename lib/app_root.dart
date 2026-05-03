import 'package:fictional_drug_and_disease_ref/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Builds the root widget tree with application-wide providers.
Widget buildRootApp() {
  return ProviderScope(child: App());
}
