// Exercise 1 — Dart Fundamentals Practice
// • Declares a Student class with name (String), gpa (double?), and
// year (int)
// • Includes a named constructor Student.unknown() that sets name to
// 'Unknown' and year to 1
// • Has a method status() that returns 'GPA: X' or 'GPA: Not
// Available' using nullaware operators
// • Create 3 student instances and print their status

class Student {
  String name;
  double? gpa;
  int year;
  Student(this.name, this.gpa, this.year);
  Student.unknown() : name = 'Unknown', gpa = null, year = 1;
  String status() {
    return gpa != null ? 'GPA: $gpa' : 'GPA: Not Available';
  }
}

void main() {
  var s1 = Student('Davin', 3.5, 3);
  var s2 = Student('Thyda', null, 2);
  var s3 = Student.unknown();
  print('NAME'.padRight(15) + 'STATUS');
  print(s1.name.padRight(15) + s1.status());
  print(s2.name.padRight(15) + s2.status());
  print(s3.name.padRight(15) + s3.status());
}
