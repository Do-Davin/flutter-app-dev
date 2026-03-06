// Exercise 2 — Collections & Functions
// Write a Dart function that takes a List and returns a Map with keys
// 'sum', 'min', 'max'. Use arrow functions where appropriate.

Map<String, int> analyzeNumbers(List<int> numbers) {
  int sum = numbers.reduce((a, b) => a + b);
  int min = numbers.reduce((a, b) => a < b ? a : b);
  int max = numbers.reduce((a, b) => a > b ? a : b);
  return {'sum': sum, 'min': min, 'max': max};
}

void main() {
  List<int> data = [5, 8, 2, 10, 3];
  var result = analyzeNumbers(data);
  print(result);
}
