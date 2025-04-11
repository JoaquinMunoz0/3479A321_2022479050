import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicacion en Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 87, 227)),
      ),
      home: const MyHomePage(title: 'Demo de la aplicacion en Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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

  //  Metodo refactorizado para construir los botones
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'Proyecto_flutter/flutter_application/assets/icons/icono.svg',
              semanticsLabel: 'Dart Logo',
            ),
            const Text('Has apretado el boton:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        _construirBotones(),
      ],
    );
  }
}

