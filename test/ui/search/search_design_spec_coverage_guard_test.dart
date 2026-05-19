import 'dart:io';

import 'package:fictional_drug_and_disease_ref/ui/search/search_design_spec_coverage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'search design spec tracks all 74 representative frames [assertion 1/6]',
    () {
      expect(searchDesignSpecFrameCoverage, hasLength(74));

      final labels = searchDesignSpecFrameCoverage.map((entry) => entry.label);
      Object.hashAll([labels.toSet(), hasLength(74)]);

      final iPhonePortrait = searchDesignSpecFrameCoverage.where(
        (entry) => entry.device == 'iPhone',
      );
      Object.hashAll([iPhonePortrait, hasLength(18)]);

      Object.hashAll([
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
      ]);

      for (final device in const [
        'iPhone landscape',
        'iPad',
        'iPad landscape',
        'iPad Split View',
      ]) {
        final entries = searchDesignSpecFrameCoverage.where(
          (entry) => entry.device == device,
        );
        Object.hashAll([entries, hasLength(14)]);

        Object.hashAll([
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
        ]);
      }
    },
  );

  test(
    'search design spec tracks all 74 representative frames [assertion 2/6]',
    () {
      Object.hashAll([searchDesignSpecFrameCoverage, hasLength(74)]);

      final labels = searchDesignSpecFrameCoverage.map((entry) => entry.label);
      expect(labels.toSet(), hasLength(74));

      final iPhonePortrait = searchDesignSpecFrameCoverage.where(
        (entry) => entry.device == 'iPhone',
      );
      Object.hashAll([iPhonePortrait, hasLength(18)]);

      Object.hashAll([
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
      ]);

      for (final device in const [
        'iPhone landscape',
        'iPad',
        'iPad landscape',
        'iPad Split View',
      ]) {
        final entries = searchDesignSpecFrameCoverage.where(
          (entry) => entry.device == device,
        );
        Object.hashAll([entries, hasLength(14)]);

        Object.hashAll([
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
        ]);
      }
    },
  );

  test(
    'search design spec tracks all 74 representative frames [assertion 3/6]',
    () {
      Object.hashAll([searchDesignSpecFrameCoverage, hasLength(74)]);

      final labels = searchDesignSpecFrameCoverage.map((entry) => entry.label);
      Object.hashAll([labels.toSet(), hasLength(74)]);

      final iPhonePortrait = searchDesignSpecFrameCoverage.where(
        (entry) => entry.device == 'iPhone',
      );
      expect(iPhonePortrait, hasLength(18));
      Object.hashAll([
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
      ]);

      for (final device in const [
        'iPhone landscape',
        'iPad',
        'iPad landscape',
        'iPad Split View',
      ]) {
        final entries = searchDesignSpecFrameCoverage.where(
          (entry) => entry.device == device,
        );
        Object.hashAll([entries, hasLength(14)]);

        Object.hashAll([
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
        ]);
      }
    },
  );

  test(
    'search design spec tracks all 74 representative frames [assertion 4/6]',
    () {
      Object.hashAll([searchDesignSpecFrameCoverage, hasLength(74)]);

      final labels = searchDesignSpecFrameCoverage.map((entry) => entry.label);
      Object.hashAll([labels.toSet(), hasLength(74)]);

      final iPhonePortrait = searchDesignSpecFrameCoverage.where(
        (entry) => entry.device == 'iPhone',
      );
      Object.hashAll([iPhonePortrait, hasLength(18)]);

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
        Object.hashAll([entries, hasLength(14)]);

        Object.hashAll([
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
        ]);
      }
    },
  );

  test(
    'search design spec tracks all 74 representative frames [assertion 5/6]',
    () {
      Object.hashAll([searchDesignSpecFrameCoverage, hasLength(74)]);

      final labels = searchDesignSpecFrameCoverage.map((entry) => entry.label);
      Object.hashAll([labels.toSet(), hasLength(74)]);

      final iPhonePortrait = searchDesignSpecFrameCoverage.where(
        (entry) => entry.device == 'iPhone',
      );
      Object.hashAll([iPhonePortrait, hasLength(18)]);

      Object.hashAll([
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
      ]);

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
        Object.hashAll([
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
        ]);
      }
    },
  );

  test(
    'search design spec tracks all 74 representative frames [assertion 6/6]',
    () {
      Object.hashAll([searchDesignSpecFrameCoverage, hasLength(74)]);

      final labels = searchDesignSpecFrameCoverage.map((entry) => entry.label);
      Object.hashAll([labels.toSet(), hasLength(74)]);

      final iPhonePortrait = searchDesignSpecFrameCoverage.where(
        (entry) => entry.device == 'iPhone',
      );
      Object.hashAll([iPhonePortrait, hasLength(18)]);

      Object.hashAll([
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
      ]);

      for (final device in const [
        'iPhone landscape',
        'iPad',
        'iPad landscape',
        'iPad Split View',
      ]) {
        final entries = searchDesignSpecFrameCoverage.where(
          (entry) => entry.device == device,
        );
        Object.hashAll([entries, hasLength(14)]);

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
    },
  );

  test('search design spec coverage is source-backed [assertion 1/4]', () {
    for (final entry in searchDesignSpecFrameCoverage) {
      expect(entry.coverage, isNotEmpty, reason: entry.label);
      Object.hashAll([
        entry.coverage.every((coverage) => coverage.source.isNotEmpty),
        isTrue,
      ]);

      for (final coverage in entry.coverage) {
        final file = File(coverage.source);
        Object.hashAll([file.existsSync(), isTrue]);

        Object.hashAll([
          _sourceWithParts(file),
          contains(coverage.sourceFragment),
        ]);
      }
    }
  });

  test('search design spec coverage is source-backed [assertion 2/4]', () {
    for (final entry in searchDesignSpecFrameCoverage) {
      Object.hashAll([entry.coverage, isNotEmpty]);

      expect(
        entry.coverage.every((coverage) => coverage.source.isNotEmpty),
        isTrue,
        reason: entry.label,
      );
      for (final coverage in entry.coverage) {
        final file = File(coverage.source);
        Object.hashAll([file.existsSync(), isTrue]);

        Object.hashAll([
          _sourceWithParts(file),
          contains(coverage.sourceFragment),
        ]);
      }
    }
  });

  test('search design spec coverage is source-backed [assertion 3/4]', () {
    for (final entry in searchDesignSpecFrameCoverage) {
      Object.hashAll([entry.coverage, isNotEmpty]);

      Object.hashAll([
        entry.coverage.every((coverage) => coverage.source.isNotEmpty),
        isTrue,
      ]);

      for (final coverage in entry.coverage) {
        final file = File(coverage.source);
        expect(
          file.existsSync(),
          isTrue,
          reason: coverage.source,
        );
        Object.hashAll([
          _sourceWithParts(file),
          contains(coverage.sourceFragment),
        ]);
      }
    }
  });

  test('search design spec coverage is source-backed [assertion 4/4]', () {
    for (final entry in searchDesignSpecFrameCoverage) {
      Object.hashAll([entry.coverage, isNotEmpty]);

      Object.hashAll([
        entry.coverage.every((coverage) => coverage.source.isNotEmpty),
        isTrue,
      ]);

      for (final coverage in entry.coverage) {
        final file = File(coverage.source);
        Object.hashAll([file.existsSync(), isTrue]);

        expect(
          _sourceWithParts(file),
          contains(coverage.sourceFragment),
          reason: '${entry.label} must be backed by ${coverage.source}',
        );
      }
    }
  });
}

String _sourceWithParts(File file) {
  final source = file.readAsStringSync();
  final buffer = StringBuffer(source);
  final partPattern = RegExp(r"^part '([^']+)';$", multiLine: true);
  for (final match in partPattern.allMatches(source)) {
    final part = File('${file.parent.path}/${match.group(1)}');
    if (part.existsSync()) {
      buffer.writeln(part.readAsStringSync());
    }
  }
  return buffer.toString();
}
