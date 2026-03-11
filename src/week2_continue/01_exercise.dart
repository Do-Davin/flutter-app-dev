// Exercise 1 — Control Flow
// Write classifyScores(List<int> scores) that:

// Loops each score, classifies as A/B/C/D/F via switch expression
// Returns a Map<String, int> counting each grade
// Test: [95, 82, 67, 91, 73, 58, 88, 45, 76, 99]
// Expected Output
// {A: 3, B: 2, C: 2, D: 1, F: 2}

Map<String, int> classifyScores(List<int> scores) {
  final Map<String, int> counts = {'A': 0, 'B': 0, 'C': 0, 'D': 0, 'F': 0};

  for (var score in scores) {
    final grade = switch (score) {
      >= 90 => 'A',
      >= 80 => 'B',
      >= 70 => 'C',
      >= 60 => 'D',
      _ => 'F',
    };
    counts[grade] = counts[grade]! + 1;
  }
  return counts;
}

void main() {
  final testScores = [95, 82, 67, 91, 73, 58, 88, 45, 76, 99];
  print(classifyScores(testScores));
}
