import 'dart:io';

import 'package:fictional_drug_and_disease_ref/ui/search/search_design_spec_coverage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('search design spec tracks all 74 representative frames', () {
    expect(searchDesignSpecFrameCoverage, hasLength(74));

    final labels = searchDesignSpecFrameCoverage.map((entry) => entry.label);
    expect(labels.toSet(), hasLength(74));

    final iPhonePortrait = searchDesignSpecFrameCoverage.where(
      (entry) => entry.device == 'iPhone',
    );
    expect(iPhonePortrait, hasLength(18));
    expect(
      iPhonePortrait.map((entry) => entry.state).toSet(),
      {
        'idle',
        'idle-empty-history',
        'loading',
        'results',
        'loading-more',
        'empty',
        'error',
        'filter-open',
        'sort-open',
      },
    );

    for (final device in const [
      'iPhone landscape',
      'iPad',
      'iPad landscape',
      'iPad Split View',
    ]) {
      final entries = searchDesignSpecFrameCoverage.where(
        (entry) => entry.device == device,
      );
      expect(entries, hasLength(14), reason: device);
      expect(
        entries.map((entry) => entry.state).toSet(),
        {
          'idle',
          'idle-empty-history',
          'loading',
          'results',
          'loading-more',
          'empty',
          'error',
        },
        reason: device,
      );
    }
  });

  test('search design spec coverage is source-backed', () {
    for (final entry in searchDesignSpecFrameCoverage) {
      expect(entry.coverage, isNotEmpty, reason: entry.label);
      expect(
        entry.coverage.every((coverage) => coverage.source.isNotEmpty),
        isTrue,
        reason: entry.label,
      );
      for (final coverage in entry.coverage) {
        final file = File(coverage.source);
        expect(
          file.existsSync(),
          isTrue,
          reason: coverage.source,
        );
        expect(
          file.readAsStringSync(),
          contains(coverage.sourceFragment),
          reason: '${entry.label} must be backed by ${coverage.source}',
        );
      }
    }
  });
}
