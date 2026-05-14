import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab6/main.dart';

void main() {
  testWidgets('home screen shows exercises', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Choose an exercise'), findsOneWidget);
    expect(find.text('Exercise 1'), findsOneWidget);
    expect(find.text('Registration Form'), findsOneWidget);
    expect(find.text('Exercise 2'), findsOneWidget);
    expect(find.text('CRUD Todos'), findsOneWidget);
    expect(find.text('Exercise 3'), findsOneWidget);
    expect(find.text('Search with Debounce'), findsOneWidget);
    expect(find.text('Exercise 4'), findsOneWidget);
    expect(find.text('Infinite Scroll List'), findsOneWidget);
    expect(find.text('Exercise 5'), findsOneWidget);
    expect(find.text('GraphQL Character Browser'), findsOneWidget);
    expect(find.text('Exercise 6'), findsOneWidget);
    expect(find.text('Swipe Gesture Card'), findsOneWidget);
  });

  testWidgets('registration form shows required fields', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Registration Form'));
    await tester.pumpAndSettle();

    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Beginner'), findsOneWidget);
    expect(find.text('Intermediate'), findsOneWidget);
    expect(find.text('Advanced'), findsOneWidget);
    expect(find.text('I agree to the terms and conditions'), findsOneWidget);
  });

  testWidgets('valid form opens success screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Registration Form'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Davin');
    await tester.enterText(find.byType(TextFormField).at(1), 'davin@test.com');
    await tester.enterText(find.byType(TextFormField).at(2), '123456');
    await tester.tap(find.byType(CheckboxListTile));
    await tester.ensureVisible(find.text('Register'));
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text('Registration Successful!'), findsOneWidget);
    expect(find.text('Welcome, Davin.'), findsOneWidget);
  });

  testWidgets('empty form shows validation messages', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Registration Form'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Register'));
    await tester.tap(find.text('Register'));
    await tester.pump();

    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('search screen shows search field', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Search with Debounce'));
    await tester.pumpAndSettle();

    expect(find.text('Search posts...'), findsOneWidget);
    expect(find.text('Search posts by typing above.'), findsOneWidget);
  });
}
