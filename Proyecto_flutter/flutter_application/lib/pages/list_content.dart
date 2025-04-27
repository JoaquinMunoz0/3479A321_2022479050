import 'package:flutter/material.dart';
import 'about.dart';
import 'home_page.dart';

class ListContent extends StatefulWidget {
  const ListContent({super.key});

  @override
  ListContentState createState() => ListContentState();  // Cambio aquí
}

class ListContentState extends State<ListContent> {  // Cambio aquí
  bool isDancing = false;

  final List<String> items = const [
    '1. Donkey Kong Country',
    '2. Devil May Cry 5',
    '3. Guitar Hero III: Legends Of Rock',
    '4. Dragons Dogma: Dark Arisen',
    '5. R.E.P.O',
  ];

  void _toggleDonkeyKong() {
    setState(() {
      isDancing = !isDancing;
    });

    if (isDancing) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isDancing = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Tier últimos juegos jugados'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.check),
                  title: Text(items[index]),
                );
              },
            ),
          ),

          GestureDetector(
            onTap: _toggleDonkeyKong,
            child: Image.asset(
              isDancing
                  ? 'assets/donkey_kong_dancing.gif'
                  : 'assets/donkey_kong_quieto.gif',
              width: isDancing ? 180 : 150,
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
                      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Inicio')),
                    );
                  },
                  label: const Text('Volver al menú'),
                  icon: const Icon(Icons.home),
                  heroTag: 'homeButton',
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 10),
              child: SizedBox(
                width: 180,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const About()),
                    );
                  },
                  label: const Text('Ir a Sobre'),
                  icon: const Icon(Icons.info_outline),
                  heroTag: 'aboutButton',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}