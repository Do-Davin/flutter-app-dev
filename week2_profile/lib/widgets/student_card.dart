import 'package:flutter/material.dart';

class InteractiveStudentCard extends StatefulWidget {
  const InteractiveStudentCard({super.key});

  @override
  State<InteractiveStudentCard> createState() => _InteractiveStudentCardState();
}

class _InteractiveStudentCardState extends State<InteractiveStudentCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/images/davin.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Do Davin',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              'Software Engineering — Year 3',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              icon: Icon(
                _isFavorite ? Icons.star : Icons.star_border,
                color: Colors.white,
              ),
              label: Text(
                _isFavorite ? "Favorited" : "Add to Favorites",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
