import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lab4/screens/home_screen.dart'; // imports kItems

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    // Lookup item from shared mock data
    final item = kItems.firstWhere(
      (e) => e['id'] == id,
      orElse: () => {
        'id': id,
        'title': 'Unknown Item',
        'description': 'No item found with id "$id".',
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Item #$id'),
        leading: BackButton(onPressed: () => context.go('/home')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ID badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ID: ${item['id']}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              item['title']!,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Description
            Text(
              item['description']!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            // Deep link hint
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Deep link: /home/item/$id',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
