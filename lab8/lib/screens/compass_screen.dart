import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassState();
}

class _CompassState extends State<CompassScreen> {
  double _heading = 0;
  StreamSubscription? _sub;
  DateTime _lastUpdate = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();

    _sub =
        magnetometerEventStream(
          samplingPeriod: const Duration(milliseconds: 50),
        ).listen((event) {
          final now = DateTime.now();

          if (now.difference(_lastUpdate).inMilliseconds < 50) {
            return;
          }

          var heading = -math.atan2(event.x, event.y);

          if (heading < 0) {
            heading += math.pi * 2;
          }

          setState(() {
            _heading = heading;
            _lastUpdate = now;
          });
        });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final degrees = (_heading * 180 / math.pi).round() % 360;

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 4')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: -_heading,
              child: const Icon(
                Icons.navigation,
                size: 120,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 24),
            Text('$degrees°', style: Theme.of(context).textTheme.displaySmall),
          ],
        ),
      ),
    );
  }
}
