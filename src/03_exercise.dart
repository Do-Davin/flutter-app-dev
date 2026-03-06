// Exercise 3 — Async Practice
// Write an async Dart function fetchGrades() that:
// • Simulates a 2-second network delay using Future.delayed
// • Returns a List of grades: [85, 92, 78, 95, 88]
// • Call it from main() using async/await and print the average grade
// • Wrap the call in try/catch

import 'dart:io';

Future<List<int>> fetchGrades() async {
  for (int i = 1; i <= 2; i++) {
    await Future.delayed(const Duration(seconds: 1));
    stdout.write(i == 2 ? '$i' : '$i, ');
  }
  return [85, 92, 78, 95, 88];
}

void main() async {
  try {
    print('Loading...');
    List<int> grades = await fetchGrades();
    double average = grades.reduce((a, b) => a + b) / grades.length;

    print('\nGrades: ${grades.join(', ')}');
    print('Average: ${average.toStringAsFixed(2)}');
  } catch (e) {
    print('Error: $e');
  }
}
