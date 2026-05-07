import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
      tester.getSize(find.byKey(const ValueKey<String>('active-body'))).height,
      700,
    );
  });
}
