import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

var logger = Logger();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    logger.i("Logger funcionando :D");
    return MaterialApp(
      title: 'Aplicacion en Flutter',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 87, 227)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Inicio'),
    );
  }
}
