import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/take_picture_screen.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../provider/app_data.dart';
import 'gallery_screen.dart';

var logger = Logger();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int _imageIndex = 3;
String _imageUrl = 'https://picsum.photos/250?image=$_imageIndex';

class _MyHomePageState extends State<MyHomePage> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    logger.i("initState ejecutado");
  }

  Widget _construirBotones(BuildContext context) {
    final enableReset = context.watch<AppData>().enableReset;
    final colorScheme = Theme.of(context).colorScheme;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    );

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            context.read<AppData>().incrementCounter();
            logger.i("setState ejecutado (incrementar)");
          },
          icon: const Icon(Icons.add),
          label: const Text('Aumentar'),
          style: buttonStyle,
        ),
        ElevatedButton.icon(
          onPressed: () {
            context.read<AppData>().decrementCounter();
            logger.i("setState ejecutado (disminuir)");
          },
          icon: const Icon(Icons.remove),
          label: const Text('Disminuir'),
          style: buttonStyle,
        ),
        ElevatedButton.icon(
          onPressed: enableReset
              ? () {
                  context.read<AppData>().resetCounter();
                  logger.i("setState ejecutado (reiniciar)");
                }
              : null,
          icon: const Icon(Icons.refresh),
          label: const Text('Reiniciar'),
          style: buttonStyle,
        ),
        ElevatedButton.icon(
          onPressed: getNewImage,
          icon: const Icon(Icons.image),
          label: const Text('Imagen desde internet'),
          style: buttonStyle,
        ),
        ElevatedButton.icon(
          onPressed: _tomarFoto,
          icon: const Icon(Icons.camera_alt),
          label: const Text('Tomar captura'),
          style: buttonStyle,
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GalleryScreen()),
            );
          },
          icon: const Icon(Icons.photo_library),
          label: const Text('Galería'),
          style: buttonStyle,
        ),
      ],
    );
  }

  Future<void> _tomarFoto() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: firstCamera),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _imagePath = result as String;
        logger.i("Imagen tomada: $_imagePath");
      });
    }
  }

  Future<void> getNewImage() async {
    final nextIndex = _imageIndex + 1;
    final newImageUrl = 'https://picsum.photos/250?image=$nextIndex';
    try {
      final response = await http.get(Uri.parse(newImageUrl));
      if (response.statusCode == 200) {
        setState(() {
          _imageIndex = nextIndex;
          _imageUrl = newImageUrl;
          logger.i("Imagen actualizada desde internet");
        });
      } else {
        setState(() {
          _imageUrl = '';
          logger.w("La imagen no está disponible");
        });
      }
    } catch (e) {
      setState(() {
        _imageUrl = '';
        logger.e("Error al obtener imagen desde internet");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.i("build ejecutado");

    final appData = context.watch<AppData>();
    final counter = appData.counter;
    final username = appData.username;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: Text(
          widget.title,
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimaryContainer),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: colorScheme.surface,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Framework Flutter',
                      style: textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: _imagePath != null
                          ? Image.file(
                              File(_imagePath!),
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              _imageUrl.isNotEmpty ? _imageUrl : '',
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    'Error al cargar imagen',
                                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Has apretado el botón:',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '$counter',
                      style: textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bienvenido, $username',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    _construirBotones(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
