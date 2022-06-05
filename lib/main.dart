import 'package:flutter/material.dart';
import 'package:games_free/controllers/controllers_module.dart';
import 'package:games_free/services/service_module.dart';
import 'package:games_free/views/game_page.dart';
import 'package:games_free/views/home_page.dart';
import 'package:get_it/get_it.dart';

GetIt di = GetIt.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceModule().register();
  ControllersModule().register();
  await ServiceModule().start();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Games Free',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme.of(context).copyWith(backgroundColor: Colors.deepPurple.shade600),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple.shade600),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/game': (context) => const GamePage(),
      },
    );
  }
}
