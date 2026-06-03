import 'package:flutter/material.dart';

import 'screens/compass_screen.dart';
import 'screens/exercise1_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/placeholder_exercise_screen.dart';
import 'screens/selfie_screen.dart';

void main() {
  runApp(const Lab8App());
}

class Lab8App extends StatelessWidget {
  const Lab8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 8',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LabHomeScreen(),
    );
  }
}

class LabHomeScreen extends StatelessWidget {
  const LabHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 8')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ExerciseTile(
            title: 'Exercise 1',
            subtitle: 'Custom Expandable Card',
            screen: const Exercise1Screen(),
          ),
          ExerciseTile(
            title: 'Exercise 2',
            subtitle: 'Hero Image Detail',
            screen: const GalleryScreen(
              imageUrls: [
                'https://picsum.photos/id/10/600/600',
                'https://picsum.photos/id/11/600/600',
                'https://picsum.photos/id/12/600/600',
                'https://picsum.photos/id/13/600/600',
                'https://picsum.photos/id/14/600/600',
                'https://picsum.photos/id/15/600/600',
                'https://picsum.photos/id/16/600/600',
                'https://picsum.photos/id/17/600/600',
                'https://picsum.photos/id/18/600/600',
                'https://picsum.photos/id/19/600/600',
                'https://picsum.photos/id/20/600/600',
                'https://picsum.photos/id/21/600/600',
              ],
            ),
          ),
          ExerciseTile(
            title: 'Exercise 3',
            subtitle: 'Selfie Camera Mini-App',
            screen: const SelfieScreen(),
          ),
          ExerciseTile(
            title: 'Exercise 4',
            subtitle: 'Live Compass',
            screen: const CompassScreen(),
          ),
          ExerciseTile(
            title: 'Exercise 5',
            subtitle: 'Waiting for approval',
            screen: const PlaceholderExerciseScreen(number: 5),
          ),
        ],
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.screen,
  });

  final String title;
  final String subtitle;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => screen));
        },
      ),
    );
  }
}
