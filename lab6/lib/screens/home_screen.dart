import 'package:flutter/material.dart';

import 'crud_screen.dart';
import 'graphql_screen.dart';
import 'infinite_screen.dart';
import 'register_screen.dart';
import 'search_screen.dart';
import 'swipe_card_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }

  Widget _buildExerciseButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget screen,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: primaryColor),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          _openScreen(context, screen);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 6 Exercises')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Choose an exercise',
              style: TextStyle(
                color: primaryColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildExerciseButton(
              context: context,
              title: 'Exercise 1',
              subtitle: 'Registration Form',
              icon: Icons.app_registration,
              screen: const RegisterScreen(),
            ),
            _buildExerciseButton(
              context: context,
              title: 'Exercise 2',
              subtitle: 'CRUD Todos',
              icon: Icons.checklist,
              screen: const CrudScreen(),
            ),
            _buildExerciseButton(
              context: context,
              title: 'Exercise 3',
              subtitle: 'Search with Debounce',
              icon: Icons.search,
              screen: const SearchScreen(),
            ),
            _buildExerciseButton(
              context: context,
              title: 'Exercise 4',
              subtitle: 'Infinite Scroll List',
              icon: Icons.list_alt,
              screen: const InfiniteScreen(),
            ),
            _buildExerciseButton(
              context: context,
              title: 'Exercise 5',
              subtitle: 'GraphQL Character Browser',
              icon: Icons.people,
              screen: const GraphqlScreen(),
            ),
            _buildExerciseButton(
              context: context,
              title: 'Exercise 6',
              subtitle: 'Swipe Gesture Card',
              icon: Icons.swipe,
              screen: const SwipeCardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
