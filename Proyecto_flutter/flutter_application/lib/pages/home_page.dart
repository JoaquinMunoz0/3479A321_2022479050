import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    logger.i("MyHomePage se está ejecutando...");
  }

  void _incrementarContador() {
    setState(() {
      _counter++;
    });
  }

  void _disminuirContador() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _reiniciarContador() {
    setState(() {
      _counter = 0;
    });
  }

  Widget _construirBotones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: _incrementarContador,
          icon: const Icon(Icons.add),
          label: const Text('Aumentar'),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: _disminuirContador,
          icon: const Icon(Icons.remove),
          label: const Text('Disminuir'),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: _reiniciarContador,
          icon: const Icon(Icons.refresh),
          label: const Text('Reiniciar'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/icono.svg',
                  semanticsLabel: 'Dart Logo',
                  height: 100,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Flutter es un framework de código abierto, que permite desarrollar aplicaciones multiplataforma con una sola base de codigo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Has apretado el boton:'),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                _construirBotones(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: null,
    );
  }
}
