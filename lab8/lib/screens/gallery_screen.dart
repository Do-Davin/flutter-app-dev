import 'package:flutter/material.dart';

import 'detail_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: imageUrls.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final url = imageUrls[index];
          final tag = 'img-$index';

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailScreen(url: url, tag: tag),
                ),
              );
            },
            child: Hero(
              tag: tag,
              child: Image.network(url, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
