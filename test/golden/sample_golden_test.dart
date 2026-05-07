import 'package:flutter/material.dart';

import 'golden_test_helpers.dart';

void main() {
  runGoldenMatrix(
    fileNamePrefix: 'sample_text',
    description: 'Material text widget renders consistently',
    builder: (theme, size, scaler) => MaterialApp(
      theme: theme,
      home: const Scaffold(body: Center(child: Text('hello'))),
    ),
  );
}
