import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailResponsiveLayout switches to tablet at 600dp', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 599,
            child: DetailResponsiveLayout(
              tabs: [Text('tab')],
              activeBody: Text('body'),
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(const ValueKey<String>('detail-phone-layout')), findsOne);
    expect(
      find.byKey(const ValueKey<String>('detail-tablet-layout')),
      findsNothing,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 600,
            child: DetailResponsiveLayout(
              tabs: [Text('tab')],
              activeBody: Text('body'),
            ),
          ),
        ),
      ),
    );

    expect(
      find.byKey(const ValueKey<String>('detail-tablet-layout')),
      findsOne,
    );
    expect(
      find.byKey(const ValueKey<String>('detail-phone-layout')),
      findsNothing,
    );
  });

  testWidgets('DetailResponsiveLayout reserves phone chrome outside body', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 390,
            height: 844,
            child: DetailResponsiveLayout(
              appBar: Text('appbar'),
              tabs: [Text('tab')],
              activeBody: ColoredBox(
                key: ValueKey<String>('active-body'),
                color: Colors.blue,
              ),
              footer: Text('footer'),
            ),
          ),
        ),
      ),
    );

    expect(
      tester
          .getSize(
            find.byKey(const ValueKey<String>('detail-phone-content-scroll')),
          )
          .height,
      700,
    );
  });

  testWidgets('DetailResponsiveLayout matches tablet shell base spec', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(834, 1194));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 834,
            height: 1194,
            child: DetailResponsiveLayout(
              appBar: Text('appbar'),
              tabs: [Text('tab 1'), Text('tab 2')],
              activeBody: SizedBox(
                key: ValueKey<String>('active-body'),
                height: 600,
                child: Text('body'),
              ),
              footer: Text('footer'),
            ),
          ),
        ),
      ),
    );

    final navPane = tester.widget<SizedBox>(
      find.byKey(const ValueKey<String>('detail-tablet-nav-pane')),
    );
    final shell = tester.widget<Row>(
      find.byKey(const ValueKey<String>('detail-tablet-shell')),
    );
    final navPadding = tester.widget<Padding>(
      find.byKey(const ValueKey<String>('detail-tablet-nav-padding')),
    );
    final contentScroll = tester.widget<SingleChildScrollView>(
      find.byKey(const ValueKey<String>('detail-tablet-content-scroll')),
    );

    expect(
      find.byKey(const ValueKey<String>('detail-tablet-layout')),
      findsOne,
    );
    expect(find.text('appbar'), findsOneWidget);
    expect(find.text('footer'), findsOneWidget);
    expect(shell.crossAxisAlignment, CrossAxisAlignment.stretch);
    expect(navPane.width, 240);
    expect(navPadding.padding, const EdgeInsets.symmetric(vertical: 14));
    expect(
      contentScroll.padding,
      const EdgeInsets.only(bottom: 80),
    );
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_responsive_layout',
    description: 'DetailResponsiveLayout follows Detail Spec tablet base',
    sizes: const ['tablet'],
    textScalers: const ['normal'],
    builder: (theme, size, textScaler) {
      return MaterialApp(
        theme: theme,
        home: const Scaffold(
          body: DetailResponsiveLayout(
            appBar: Center(child: Text('詳細')),
            tabs: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Text('概要'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Text('用法・用量'),
              ),
            ],
            activeBody: Padding(
              padding: EdgeInsets.all(16),
              child: Text('本文'),
            ),
            footer: Center(child: Text('ブックマーク')),
          ),
        ),
      );
    },
  );
}
