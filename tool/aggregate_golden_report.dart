import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

Future<void> main(List<String> args) async {
  final cwd = Directory.current.path;
  final resultsRoot = p.join(cwd, 'build', 'test-results', 'golden');
  final reportRoot = p.join(cwd, 'build', 'reports', 'golden');

  final dir = Directory(resultsRoot);
  if (!dir.existsSync()) {
    stderr.writeln('No golden results at $resultsRoot. Skipping report.');
    exit(0);
  }

  final results = <Map<String, dynamic>>[];
  await for (final entity in dir.list()) {
    if (entity is File &&
        entity.path.endsWith('.json') &&
        !entity.path.endsWith('results-summary.json')) {
      final content = await entity.readAsString();
      results.add(jsonDecode(content) as Map<String, dynamic>);
    }
  }

  final summary = <String, int>{
    'total': results.length,
    'changed': 0,
    'added': 0,
    'unchanged': 0,
    'recorded': 0,
  };
  for (final result in results) {
    final type = result['type'] as String;
    summary[type] = (summary[type] ?? 0) + 1;
  }

  final summaryJson = <String, dynamic>{
    'summary': summary,
    'results': results,
    'generated_at': DateTime.now().toUtc().toIso8601String(),
  };

  final reportDir = Directory(reportRoot);
  if (!reportDir.existsSync()) {
    reportDir.createSync(recursive: true);
  }

  File(p.join(resultsRoot, 'results-summary.json')).writeAsStringSync(
    jsonEncode(summaryJson),
  );

  final html = _buildHtml(summary, results, reportRoot);
  final htmlFile = File(p.join(reportRoot, 'index.html'))
    ..writeAsStringSync(html);

  stdout
    ..writeln('Golden report generated:')
    ..writeln(
      '  Total: ${summary['total']}, '
      'Changed: ${summary['changed']}, '
      'Added: ${summary['added']}, '
      'Unchanged: ${summary['unchanged']}, '
      'Recorded: ${summary['recorded']}',
    )
    ..writeln('  HTML: ${htmlFile.path}');

  final hasFailures = (summary['changed']! + summary['added']!) > 0;
  exit(hasFailures ? 1 : 0);
}

String _buildHtml(
  Map<String, int> summary,
  List<Map<String, dynamic>> results,
  String reportRoot,
) {
  final changed = results.where((r) => r['type'] == 'changed').toList();
  final added = results.where((r) => r['type'] == 'added').toList();
  final rowsHtml = StringBuffer();
  for (final result in [...changed, ...added]) {
    final compareFile = result['compare_file_path'] as String;
    final goldenFile = result['golden_file_path'] as String;
    final type = result['type'] as String;
    final diffPct = result['diff_percentage'] as double?;
    final relCompare = p.relative(compareFile, from: reportRoot);
    final diffLabel = diffPct != null
        ? '${(diffPct * 100).toStringAsFixed(2)}%'
        : 'N/A';
    rowsHtml
      ..writeln('<tr>')
      ..writeln('<td>${type.toUpperCase()}</td>')
      ..writeln('<td>${p.basenameWithoutExtension(goldenFile)}</td>')
      ..writeln('<td>$diffLabel</td>')
      ..writeln(
        '<td><img src="$relCompare" '
        'class="materialboxed responsive-img" /></td>',
      )
      ..writeln('</tr>');
  }

  return '''
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Golden Test Report</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<style>
img.responsive-img { max-width: 100%; }
table { table-layout: fixed; }
</style>
</head>
<body>
<!--
Golden test report layout is inspired by Roborazzi (Apache-2.0).
See third_party/roborazzi/NOTICE.txt for attribution.
Materialize CSS (MIT) is loaded from CDN.
-->
<div class="container">
<h3>Golden Test Report</h3>
<p>Generated: ${DateTime.now().toUtc().toIso8601String()}</p>
<table class="striped">
<thead><tr>
<th>Total</th><th>Recorded</th><th>Added</th><th>Changed</th><th>Unchanged</th>
</tr></thead>
<tbody><tr>
<td>${summary['total']}</td>
<td>${summary['recorded']}</td>
<td>${summary['added']}</td>
<td>${summary['changed']}</td>
<td>${summary['unchanged']}</td>
</tr></tbody>
</table>
<h4>Diffs (${changed.length + added.length})</h4>
<table class="striped">
<thead><tr><th>Type</th><th>Test</th><th>Diff%</th><th>Compare image</th></tr></thead>
<tbody>$rowsHtml</tbody>
</table>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
<script>document.addEventListener('DOMContentLoaded', () => M.AutoInit());</script>
</body>
</html>
''';
}
