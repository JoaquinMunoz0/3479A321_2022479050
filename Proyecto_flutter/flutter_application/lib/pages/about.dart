import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/app_data.dart';
//import 'list_content.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  bool isDiddyDancing = false;

  /*void _toggleDiddyKong() {
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
  }*/

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>();
    final controller = TextEditingController(text: appData.username);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Donkey Kong Country'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Editar datos de usuario',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Nombre de usuario'),
                onSubmitted: (value) =>
                    context.read<AppData>().setUsername(value),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Permitir botón de reinicio'),
                  Switch(
                    value: appData.enableReset,
                    onChanged: (value) =>
                        context.read<AppData>().setEnableReset(value),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              /*Center(
                child: GestureDetector(
                  onTap: _toggleDiddyKong,
                  child: Image.asset(
                    isDiddyDancing
                        ? 'assets/diddy_kong_dancing.gif'
                        : 'assets/diddy_kong_quieto.gif',
                    width: isDiddyDancing ? 180 : 150,
                  ),
                ),
              ),*/
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        label: const Text('Volver'),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
