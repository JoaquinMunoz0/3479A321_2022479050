import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'list_content.dart';
import 'about.dart';

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

  void _navegarSegunContador() {
    if (_counter % 2 == 0) {
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

  Widget _construirBotones() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 8,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        automaticallyImplyLeading: false,
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
                  'Framework Flutter',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Has apretado el boton:'),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
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
