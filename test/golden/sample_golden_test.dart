import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';

void main() {
  unawaited(
    goldenTest(
      'Material text widget renders consistently',
      fileName: 'sample_text_golden',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'default',
            child: const SizedBox(
              width: 320,
              height: 180,
              child: MaterialApp(
                home: Scaffold(body: Center(child: Text('hello'))),
              ),
            ),
          ),
        ],
      ),
      tags: ['golden'],
    ),
  );
}
