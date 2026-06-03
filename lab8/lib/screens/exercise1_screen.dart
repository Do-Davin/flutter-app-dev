import 'package:flutter/material.dart';

import '../widgets/expandable_card.dart';

class Exercise1Screen extends StatelessWidget {
  const Exercise1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ExpandableCard(
            title: 'About Flutter',
            content: Text(
              'Flutter is a toolkit for building apps from one codebase.',
            ),
          ),
          ExpandableCard(
            title: 'About Widgets',
            content: Text('Widgets describe what should appear on the screen.'),
          ),
          ExpandableCard(
            title: 'About Animation',
            content: Text(
              'Animated widgets help the interface change smoothly.',
            ),
          ),
        ],
      ),
    );
  }
}
