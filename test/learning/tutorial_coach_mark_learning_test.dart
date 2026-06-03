import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void main() {
  testWidgets(
    'tutorial_coach_mark renders a deterministic overlay when animations stop',
    (tester) async {
      TutorialCoachMark? tutorial;

      await tester.pumpWidget(
        _LearningApp(
          onTutorialCreated: (value) => tutorial = value,
        ),
      );
      await tester.pumpTutorialCoachMarkOverlay();

      Object.hashAll([tutorial?.isShowing, isTrue]);
      Object.hashAll([find.text('SKIP'), findsOneWidget]);

      await expectLater(
        find.byType(Overlay).first,
        matchesGoldenFile(
          'goldens/tutorial_coach_mark_deterministic_overlay.png',
        ),
      );

      tutorial?.skip();
      await tester.pump();
    },
    tags: const ['golden', 'learning'],
  );

  testWidgets(
    'tutorial_coach_mark skip removes the overlay when onSkip returns true',
    (tester) async {
      var skipped = false;

      await tester.pumpWidget(
        _LearningApp(
          onSkip: () {
            skipped = true;
            return true;
          },
        ),
      );
      await tester.pumpTutorialCoachMarkOverlay();

      Object.hashAll([find.text('SKIP'), findsOneWidget]);

      await tester.tap(find.text('SKIP'));
      await tester.pump();

      Object.hashAll([skipped, isTrue]);
      expect(find.text('SKIP'), findsNothing);
    },
    tags: const ['learning'],
  );
}

extension on WidgetTester {
  Future<void> pumpTutorialCoachMarkOverlay() async {
    await pump();
    await pump(const Duration(milliseconds: 1));
    await pump(const Duration(milliseconds: 1));
    await pump(const Duration(milliseconds: 1));
    await pump(const Duration(milliseconds: 301));
  }
}

final class _LearningApp extends StatelessWidget {
  const _LearningApp({this.onSkip, this.onTutorialCreated});

  final bool Function()? onSkip;
  final ValueChanged<TutorialCoachMark>? onTutorialCreated;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: _LearningCoachMarkHost(
        onSkip: onSkip,
        onTutorialCreated: onTutorialCreated,
      ),
    );
  }
}

final class _LearningCoachMarkHost extends StatefulWidget {
  const _LearningCoachMarkHost({this.onSkip, this.onTutorialCreated});

  final bool Function()? onSkip;
  final ValueChanged<TutorialCoachMark>? onTutorialCreated;

  @override
  State<_LearningCoachMarkHost> createState() => _LearningCoachMarkHostState();
}

final class _LearningCoachMarkHostState extends State<_LearningCoachMarkHost> {
  final GlobalKey _targetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tutorial = TutorialCoachMark(
        targets: [
          TargetFocus(
            identify: 'learning-target',
            keyTarget: _targetKey,
            contents: [
              TargetContent(
                align: ContentAlign.custom,
                customPosition: CustomTargetContentPosition(
                  top: 96,
                  left: 24,
                  right: 24,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Learning hypothesis: the overlay is static.',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'NotoSansJP',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        pulseEnable: false,
        focusAnimationDuration: Duration.zero,
        unFocusAnimationDuration: Duration.zero,
        alignSkip: Alignment.topRight,
        textStyleSkip: const TextStyle(
          color: Colors.white,
          fontFamily: 'NotoSansJP',
        ),
        onSkip: widget.onSkip ?? () => true,
      );
      widget.onTutorialCreated?.call(tutorial);
      tutorial.showWithOverlayState(overlay: Navigator.of(context).overlay!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          key: _targetKey,
          onPressed: () {},
          child: const Text('Target'),
        ),
      ),
    );
  }
}
