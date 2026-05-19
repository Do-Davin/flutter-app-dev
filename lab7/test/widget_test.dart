import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab7/main.dart';

void main() {
  testWidgets('shows lab menu and settings screen', (tester) async {
    await tester.pumpWidget(const MyApp(theme: 'system', language: 'en'));

    expect(find.text('Lab 7'), findsOneWidget);
    expect(find.text('Exercise 1: Settings'), findsOneWidget);
    expect(find.text('Exercise 2: Notes'), findsOneWidget);
    expect(find.text('Exercise 3: Cart'), findsOneWidget);
    expect(find.text('Exercise 4: Posts Cache'), findsOneWidget);
    expect(find.text('Exercise 5: Infinite Posts'), findsOneWidget);

    await tester.tap(find.text('Exercise 1: Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsNWidgets(2));
  });
}
