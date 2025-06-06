import 'dart:io';
import 'package:flutter/material.dart';

class PreviewPictureScreen extends StatelessWidget {
  final String imagePath;

  const PreviewPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista previa')),
      body: Image.file(File(imagePath)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(imagePath);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
