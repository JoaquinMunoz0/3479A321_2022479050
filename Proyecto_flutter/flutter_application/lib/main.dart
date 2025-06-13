import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'provider/app_data.dart';
import 'data/database_helper.dart';
import 'theme/util.dart';
import 'theme/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initializeDatabase();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppData(),
      child: const MyApp(),
    ),
  );
}

var logger = Logger();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Abhaya Libre", "Orbitron");
    MaterialTheme theme = MaterialTheme(textTheme);
    logger.i("Logger funcionando :D");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const MyHomePage(title: 'Home'),
    );
  }
}