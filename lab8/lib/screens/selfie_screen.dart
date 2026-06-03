import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SelfieScreen extends StatefulWidget {
  const SelfieScreen({super.key});

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  CameraController? _controller;
  String? _capturedPath;
  String _message = 'Loading camera...';

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        if (!mounted) {
          return;
        }

        setState(() {
          _message = 'No camera found.';
        });
        return;
      }

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller.initialize();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        _controller = controller;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _message = 'Camera is not available.';
      });
    }
  }

  Future<void> _takePicture() async {
    final controller = _controller;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    final photo = await controller.takePicture();

    setState(() {
      _capturedPath = photo.path;
    });
  }

  Future<void> _savePicture() async {
    final capturedPath = _capturedPath;

    if (capturedPath == null) {
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'selfie-${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedFile = await File(
      capturedPath,
    ).copy('${directory.path}/$fileName');

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop(savedFile.path);
  }

  void _retakePicture() {
    setState(() {
      _capturedPath = null;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final capturedPath = _capturedPath;

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3')),
      body: capturedPath == null
          ? _buildCameraView(controller)
          : _buildCapturedView(capturedPath),
    );
  }

  Widget _buildCameraView(CameraController? controller) {
    if (controller == null || !controller.value.isInitialized) {
      return Center(child: Text(_message));
    }

    return Column(
      children: [
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera_alt),
            label: const Text('Take Selfie'),
          ),
        ),
      ],
    );
  }

  Widget _buildCapturedView(String path) {
    return Column(
      children: [
        Expanded(child: Image.file(File(path), fit: BoxFit.contain)),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: _retakePicture,
                icon: const Icon(Icons.refresh),
                label: const Text('Retake'),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: _savePicture,
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
