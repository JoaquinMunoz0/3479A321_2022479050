import 'package:flutter/material.dart';
import 'list_content.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  AboutState createState() => AboutState();  // Cambio aquí
}

class AboutState extends State<About> {  // Cambio aquí
  bool isDiddyDancing = false;

  void _toggleDiddyKong() {
    setState(() {
      isDiddyDancing = !isDiddyDancing;
    });

    if (isDiddyDancing) {
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          isDiddyDancing = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Donkey Kong Country'),
        automaticallyImplyLeading: false, // Quita el botón de regresar
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Donkey Kong Country​ es un videojuego de plataformas desarrollado por la compañía británica Rare y publicado por Nintendo para la consola Super Nintendo en 1994.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          
          GestureDetector(
            onTap: _toggleDiddyKong,
            child: Image.asset(
              isDiddyDancing
                  ? 'assets/diddy_kong_dancing.gif'
                  : 'assets/diddy_kong_quieto.gif',
              width: isDiddyDancing ? 180 : 200,
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 40),
              child: SizedBox(
                width: 180,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ListContent()),
                    );
                  },
                  label: const Text('Volver a la lista'),
                  icon: const Icon(Icons.list),
                  heroTag: 'listContentButton',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}