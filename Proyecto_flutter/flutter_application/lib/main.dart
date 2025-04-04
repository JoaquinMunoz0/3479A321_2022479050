import 'package:flutter/material.dart';

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
            const Text('Has apretado el boton:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: _incrementarContador,
          child: const Text('Aumentar'),
        ),
        ElevatedButton(
          onPressed: _disminuirContador,
          child: const Text('Disminuir'),
        ),
        ElevatedButton(
          onPressed: _reiniciarContador,
          child: const Text('Reiniciar'),
        ),
      ],
    );
  }
}