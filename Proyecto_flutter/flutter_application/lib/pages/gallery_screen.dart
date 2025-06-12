import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<FileSystemEntity> _images = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory.listSync()
      ..sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));

    setState(() {
      _images = files.where((f) => f.path.endsWith(".jpg")).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Galeria")),
      body: _images.isEmpty
          ? const Center(child: Text("No hay capturas tomadas"))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Image.file(
                  File(_images[index].path),
                  fit: BoxFit.cover,
                );
              },
            ),
    );
  }
}
