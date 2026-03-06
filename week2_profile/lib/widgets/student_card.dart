import 'package:flutter/material.dart';
import 'package:dev_icons/dev_icons.dart';

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
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/davin.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DO DAVIN',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        'davin.do.kh@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 35,
                  ),
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            Divider(
              thickness: 0.3,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 10),

            Text(
              'Bio',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Software Engineering — Year 3',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 8),

            Divider(
              thickness: 0.3,
              color: Theme.of(context).colorScheme.primary,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 8),

                infoRow('Gender', 'Male'),
                infoRow('DOB', '2005'),
                infoRow('Country', 'Cambodia'),
                infoRow('University', 'Institute of Technology of Cambodia'),
              ],
            ),

            const SizedBox(height: 8),

            Divider(
              thickness: 0.3,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 8),

            Text(
              'Skills',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 16),

            IconTheme(
              data: IconThemeData(
                color: Theme.of(context).colorScheme.secondary,
                size: 32,
              ),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  Icon(Icons.code),
                  Icon(Icons.flutter_dash),
                  Icon(Icons.storage),
                  Icon(Icons.language),
                  Icon(Icons.data_object),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Divider(
              thickness: 0.3,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 8),

            Text(
              'Tech Stack',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 16),

            IconTheme(
              data: IconThemeData(
                color: Theme.of(context).colorScheme.secondary,
                size: 32,
              ),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  Icon(DevIcons.dartPlain),
                  Icon(DevIcons.flutterPlain),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
