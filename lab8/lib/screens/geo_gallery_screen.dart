import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/geo_photo.dart';
import 'selfie_screen.dart';

class GeoGalleryScreen extends StatelessWidget {
  const GeoGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<GeoPhoto>('photos');

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _capturePhoto(context, box),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_a_photo),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<GeoPhoto> photos, child) {
          if (photos.isEmpty) {
            return const Center(
              child: Text('No photos yet — tap + to capture'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos.getAt(index);

              if (photo == null) {
                return const SizedBox.shrink();
              }

              return GeoPhotoCard(photo: photo, index: index);
            },
          );
        },
      ),
    );
  }

  Future<void> _capturePhoto(BuildContext context, Box<GeoPhoto> box) async {
    final imagePath = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (context) => const SelfieScreen()),
    );

    if (imagePath == null) {
      return;
    }

    if (!context.mounted) {
      return;
    }

    final position = await _getPosition(context);

    if (position == null) {
      return;
    }

    await box.add(
      GeoPhoto(
        imagePath: imagePath,
        latitude: position.latitude,
        longitude: position.longitude,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<Position?> _getPosition(BuildContext context) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      if (context.mounted) {
        _showMessage(context, 'Location service is off.');
      }
      return null;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        _showMessage(context, 'Location permission is needed.');
      }
      return null;
    }

    return Geolocator.getCurrentPosition();
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class GeoPhotoCard extends StatelessWidget {
  const GeoPhotoCard({super.key, required this.photo, required this.index});

  final GeoPhoto photo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 250 + (index * 80)),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(bottom: 16),
        child: InkWell(
          onLongPress: () => _confirmDelete(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(photo.imagePath),
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_pin, color: Colors.indigo),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${photo.latitude.toStringAsFixed(4)}, ${photo.longitude.toStringAsFixed(4)}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_formatDate(photo.createdAt)),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: _openMap,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.map),
                      label: const Text('View on Map'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openMap() async {
    final uri = Uri.parse(
      'https://maps.google.com/?q=${photo.latitude},${photo.longitude}',
    );

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete this photo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await photo.delete();
    }
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '${date.year}-$month-$day $hour:$minute';
  }
}
