// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../widgets/preview_picture_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({super.key, required this.camera});

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tomar una foto')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            //GUARDAR IMAGEN
            final directory = await getApplicationDocumentsDirectory();
            final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
            final imagePath = path.join(directory.path, fileName);
            await image.saveTo(imagePath);

            if (!mounted) return;

            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PreviewPictureScreen(imagePath: imagePath),
              ),
            );

            if (!mounted) return;

            Navigator.of(context).pop(result);
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}