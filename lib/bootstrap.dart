import 'package:flutter/widgets.dart';

/// Starts the Flutter application.
void bootstrap(Widget Function() builder) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(builder());
}
