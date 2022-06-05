import 'package:games_free/core/apis/api_cheapshark.dart';
import 'package:games_free/main.dart';
import 'package:games_free/services/admob.dart';
import 'package:games_free/services/global.dart';
import 'package:games_free/services/notificaion.dart';

class ServiceModule {
  void register() {
    di.registerFactory(() => ApiCheapShark());
    di.registerLazySingleton(() => AdMob());
    di.registerLazySingleton(() => NotificFCM());
    di.registerLazySingleton(() => Global(notf: di(), api: di()));
  }

  Future<void> start() async {
    await di.get<AdMob>().inicia();
    await di.get<NotificFCM>().inicia();
    await di.get<Global>().inicia();
  }
}
