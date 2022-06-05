import 'package:games_free/controllers/free_controller.dart';
import 'package:games_free/controllers/game_controller.dart';
import 'package:games_free/controllers/home_controller.dart';
import 'package:games_free/controllers/oferta_controller.dart';
import 'package:games_free/main.dart';

class ControllersModule {
  void register() {
    di.registerFactory(() => FreeController(gb: di()));
    di.registerFactory(() => HomeController(admob: di(), gb: di()));
    di.registerFactory(() => GameController(gb: di()));
    di.registerFactory(() => OfertaController(di()));
  }
}
