import 'package:flutter/material.dart';
import 'package:games_free/services/adMob.dart';
import 'package:games_free/services/global.dart';
import 'package:games_free/services/notificaion.dart';
import 'package:games_free/views/game-page.dart';
import 'package:games_free/views/home-page.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => NotificFCM().inicia());
  await Get.putAsync(() => AdMob().inicia());
  await Get.putAsync(() => Global().inicia());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Games Free',
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.deepPurple.shade600,
      ),
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/game',
          page: () => GamePage(),
        ),
      ],
    );
  }
}
