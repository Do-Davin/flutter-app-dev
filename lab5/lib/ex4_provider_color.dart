import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorDemoScreen extends StatefulWidget {
  const ColorDemoScreen({super.key});

  @override
  State<ColorDemoScreen> createState() => _ColorDemoScreenState();
}

class _ColorDemoScreenState extends State<ColorDemoScreen> {
  Color _color = Colors.indigo;

  final List<Color> _palette = [
    Colors.indigo,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Provider<Color>.value(
      value: _color,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Prop Drilling → Provider'),
          backgroundColor: _color,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CHANGE COLOR AT ROOT',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 2,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: _palette.map((color) {
                      final selected = color == _color;
                      return GestureDetector(
                        onTap: () => setState(() => _color = color),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: selected
                                ? Border.all(color: Colors.black, width: 3)
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'WIDGET TREE (no color param passed between layers)',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 2,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _TreeRow(
                    level: 0,
                    label: 'ColorDemoScreen',
                    note: '← sets color via Provider',
                  ),
                  _TreeRow(
                    level: 1,
                    label: '_Section',
                    note: '← no color param',
                  ),
                  _TreeRow(
                    level: 2,
                    label: '_InfoCard',
                    note: '← no color param',
                  ),
                  _TreeRow(
                    level: 3,
                    label: '_ColoredText',
                    note: '← reads context.watch<Color>()',
                  ),
                ],
              ),
            ),

            const Divider(),

            const Expanded(child: _Section()),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section();

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(16), child: _InfoCard());
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.color_lens_outlined, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            const _ColoredText(),
            const SizedBox(height: 8),
            Text(
              '_Section and _InfoCard have NO color parameter.\nOnly _ColoredText reads the color from Provider.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColoredText extends StatelessWidget {
  const _ColoredText();

  @override
  Widget build(BuildContext context) {
    final color = context.watch<Color>();

    return Text(
      'Hello from Provider!',
      style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

class _TreeRow extends StatelessWidget {
  final int level;
  final String label;
  final String note;

  const _TreeRow({
    required this.level,
    required this.label,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.watch<Color>();

    return Padding(
      padding: EdgeInsets.only(left: level * 20.0, bottom: 6),
      child: Row(
        children: [
          if (level > 0) Text('└─ ', style: TextStyle(color: Colors.grey[400])),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: level == 3 ? color : Colors.black87,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              note,
              style: TextStyle(fontSize: 11, color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }
}
