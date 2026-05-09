import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';

void main() {
  testWidgets(
    'Calc segmented control atom card matches spec reference',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(270, 524));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Material(
            child: RepaintBoundary(
              key: ValueKey<String>('segmented-control-reference-boundary'),
              child: SizedBox(
                width: 270,
                height: 524,
                child: _SegmentedControlAtomCard(),
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byKey(
          const ValueKey<String>('segmented-control-reference-boundary'),
        ),
        matchesGoldenFile(
          'goldens/macos/calc_segmented_control_atom_card_light.png',
        ),
      );
    },
    tags: const ['golden'],
  );
}

class _SegmentedControlAtomCard extends StatelessWidget {
  const _SegmentedControlAtomCard();

  @override
  Widget build(BuildContext context) {
    const pageCard = Color(0xFFFFFFFF);
    const pageRule = Color(0xFFD8DCE3);
    const pageFg = Color(0xFF15181D);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: pageCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: pageRule),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 18, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Segmented control',
              style: TextStyle(
                fontFamily: 'NotoSansJP',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                height: 1.20,
                color: pageFg,
              ),
            ),
            const SizedBox(height: 10),
            _AtomRow(
              label: 'tool\ndefault',
              child: SizedBox(
                width: 162,
                child: CalcSegmentedControl<String>.tool(
                  selectedValue: 'bmi',
                  items: const [
                    CalcSegmentedControlItem(value: 'bmi', label: 'BMI'),
                    CalcSegmentedControlItem(value: 'egfr', label: 'eGFR'),
                    CalcSegmentedControlItem(value: 'crcl', label: 'CrCl'),
                  ],
                  onChanged: (_) {},
                ),
              ),
            ),
            const SizedBox(height: 8),
            _AtomRow(
              label: 'sex ·\ndefault',
              child: SizedBox(
                width: 168,
                child: CalcSegmentedControl<String>.sex(
                  selectedValue: 'male',
                  items: const [
                    CalcSegmentedControlItem(
                      value: 'male',
                      label: '男性',
                      icon: Symbols.male,
                    ),
                    CalcSegmentedControlItem(
                      value: 'female',
                      label: '女性',
                      icon: Symbols.female,
                    ),
                  ],
                  onChanged: (_) {},
                ),
              ),
            ),
            const SizedBox(height: 8),
            _AtomRow(
              label: 'disabled',
              child: SizedBox(
                width: 168,
                child: CalcSegmentedControl<String>.sex(
                  selectedValue: 'male',
                  enabled: false,
                  items: const [
                    CalcSegmentedControlItem(
                      value: 'male',
                      label: '男性',
                      icon: Symbols.male,
                    ),
                    CalcSegmentedControlItem(
                      value: 'female',
                      label: '女性',
                      icon: Symbols.female,
                    ),
                  ],
                  onChanged: (_) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AtomRow extends StatelessWidget {
  const _AtomRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const pageMuted = Color(0xFF5C6370);

    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'JetBrainsMono',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.16,
              letterSpacing: 0.44,
            ).copyWith(color: pageMuted),
          ),
        ),
        const SizedBox(width: 8),
        child,
      ],
    );
  }
}
