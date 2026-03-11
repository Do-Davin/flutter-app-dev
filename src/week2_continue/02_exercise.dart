// Exercise 2 — OOP Design
// Create a Shape class hierarchy:

// Abstract class Shape with area() & describe()
// Subclasses: Circle(r), Rectangle(w,h), Triangle(b,h)
// Create list of mixed shapes, print each
// Expected Output
// Circle (r=5): area = 78.54
// Rectangle (4x6): area = 24.0
// Triangle (b=3, h=8): area = 12.0

import 'dart:math';

abstract class Shape {
  double area();
  void describe();
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);

  @override
  double area() => pi * pow(radius, 2);

  @override
  void describe() =>
      print('Circle (r=$radius): area = ${area().toStringAsFixed(2)}');
}

class Rectangle extends Shape {
  final double width, height;
  Rectangle(this.width, this.height);

  @override
  double area() => width * height;

  @override
  void describe() => print(
    'Rectangle (${width}x$height): area = ${area().toStringAsFixed(1)}',
  );
}

class Triangle extends Shape {
  final double base, height;
  Triangle(this.base, this.height);

  @override
  double area() => 0.5 * base * height;

  @override
  void describe() => print(
    'Triangle (b=$base, h=$height): area = ${area().toStringAsFixed(1)}',
  );
}

void main() {
  final List<Shape> shapes = [Circle(5), Rectangle(4, 6), Triangle(3, 8)];

  for (var shape in shapes) {
    shape.describe();
  }
}
