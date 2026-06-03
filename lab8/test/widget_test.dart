import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab8/main.dart';
import 'package:lab8/widgets/expandable_card.dart';

void main() {
  testWidgets('lab home shows five exercises', (tester) async {
    await tester.pumpWidget(const Lab8App());

    expect(find.text('Exercise 1'), findsOneWidget);
    expect(find.text('Exercise 2'), findsOneWidget);
    expect(find.text('Exercise 3'), findsOneWidget);
    expect(find.text('Exercise 4'), findsOneWidget);
    expect(find.text('Exercise 5'), findsOneWidget);
  });

  testWidgets('expandable card opens and closes', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ExpandableCard(
            title: 'Details',
            content: Text('Hidden content'),
          ),
        ),
      ),
    );

    var crossFade = tester.widget<AnimatedCrossFade>(
      find.byType(AnimatedCrossFade),
    );
    expect(crossFade.crossFadeState, CrossFadeState.showFirst);

    await tester.tap(find.text('Details'));
    await tester.pumpAndSettle();

    crossFade = tester.widget<AnimatedCrossFade>(
      find.byType(AnimatedCrossFade),
    );
    expect(crossFade.crossFadeState, CrossFadeState.showSecond);

    await tester.tap(find.text('Details'));
    await tester.pumpAndSettle();

    crossFade = tester.widget<AnimatedCrossFade>(
      find.byType(AnimatedCrossFade),
    );
    expect(crossFade.crossFadeState, CrossFadeState.showFirst);
  });
}
