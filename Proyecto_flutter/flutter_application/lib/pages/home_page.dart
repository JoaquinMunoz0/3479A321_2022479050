// ignore_for_file: use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/take_picture_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../provider/app_data.dart';
import 'list_content.dart';
import 'about.dart';
import 'dart:async';


var logger = Logger();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int _imageIndex = 3;
String _imageUrl = 'https://picsum.photos/250?image=$_imageIndex';
String? _imagePath;

class _MyHomePageState extends State<MyHomePage>{
  _MyHomePageState() {
    logger.i("Constructor ejecutado. mounted: $mounted");
  }

  @override
  void initState() {
    super.initState();
    logger.i("initState ejecutado");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.i("didChangeDependencies ejecutado");
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.i("didUpdateWidget ejecutado");
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.i("deactivate ejecutado");
  }

  @override
  void dispose() {
    logger.i("dispose ejecutado");
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.i("reassemble ejecutado (hot reload)");
  }

  void _navegarSegunContador() {
    final counter = context.read<AppData>().counter;
    if (counter % 2 == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ListContent()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const About()),
      );
    }
  }

  Widget _construirBotones(BuildContext context) {
    final enableReset = context.watch<AppData>().enableReset;

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
        ),
        ElevatedButton.icon(
          onPressed: () {
            context.read<AppData>().decrementCounter();
            logger.i("setState ejecutado (disminuir)");
          },
          icon: const Icon(Icons.remove),
          label: const Text('Disminuir'),
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
        ),
        ElevatedButton.icon(
          onPressed: _navegarSegunContador,
          icon: const Icon(Icons.navigation),
          label: const Text('Navegar según contador'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListContent()),
            );
          },
          icon: const Icon(Icons.list),
          label: const Text('Ver Lista'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const About()),
            );
          },
          icon: const Icon(Icons.info),
          label: const Text('Sobre la App'),
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
        logger.i("Imagen actualizada");
      });
    } else {
      setState(() {
        _imageUrl = '';
        logger.w("La imagen no esta disponible");
      });
    }
  } catch (e) {
      setState(() {
        _imageUrl = '';
        logger.e("Error al obtener imagen");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.i("build ejecutado");

    final appData = context.watch<AppData>();
    final counter = appData.counter;
    final username = appData.username;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/icono.svg',
                      semanticsLabel: 'Dart Logo',
                      height: 100,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Framework Flutter',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text('Has apretado el boton:'),
                    Text(
                      '$counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('Bienvenido, $username'),
                    const SizedBox(height: 20),
                    _construirBotones(context),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: getNewImage,
                      icon: const Icon(Icons.image),
                      label: const Text('Cambiar imagen'),
                    ),
                    const SizedBox(height: 10),
                    Image.network(
                      _imageUrl.isNotEmpty ? _imageUrl : '',
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            'Error al cargar imagen',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                    ),
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
