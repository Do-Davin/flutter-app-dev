import 'package:flutter/material.dart';

class PlaceholderExerciseScreen extends StatelessWidget {
  const PlaceholderExerciseScreen({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise $number')),
      body: Center(
        child: Text(
          'Exercise $number is waiting for approval.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
