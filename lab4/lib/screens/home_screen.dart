// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               onPressed: () => context.go('/profile'), // replaces stack
//               child: const Text('Go to Profile'),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton(
//               onPressed: () => context.push('/settings'), // pushes onto stack
//               child: const Text('Open Settings'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Shared mock data — single source of truth used by both screens
const List<Map<String, String>> kItems = [
  {
    'id': '1',
    'title': 'Flutter Basics',
    'description': 'Widgets, state, and layout fundamentals.',
  },
  {
    'id': '2',
    'title': 'go_router Deep Dive',
    'description': 'Declarative routing with path parameters and deep links.',
  },
  {
    'id': '3',
    'title': 'NestJS + GraphQL',
    'description': 'Building scalable APIs with decorators and resolvers.',
  },
  {
    'id': '42',
    'title': 'The Answer',
    'description':
        'To the ultimate question of life, the universe, and everything.',
  },
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: kItems.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = kItems[index];
          return ListTile(
            leading: CircleAvatar(child: Text(item['id']!)),
            title: Text(item['title']!),
            subtitle: Text(item['description']!),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/home/item/${item['id']}'),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'profile',
            onPressed: () => context.go('/profile'),
            label: const Text('Profile'),
            icon: const Icon(Icons.person),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'settings',
            onPressed: () => context.push('/settings'),
            label: const Text('Settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
