import 'package:games_free/apis/api-cheapshark.dart';
import 'package:games_free/apis/api-mongoDB.dart';
import 'package:games_free/models/store.dart';
import 'package:games_free/models/users.dart';
import 'package:games_free/services/notificaion.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Global extends GetxService {
  List listStores = [].obs;
  final notf = Get.find<NotificFCM>();
  var api = ApiCheapShark();
  late PackageInfo packageInfo;

  late Box box;
  Future<Global> inicia() async {
    await Hive.initFlutter();
    box = await Hive.openBox('global');
    packageInfo = await PackageInfo.fromPlatform();
    await getStore();
    return this;
  }

  String retornaNomeLoja({required String idLoja}) {
    return listStores.firstWhere((element) => element.storeID == idLoja).storeName;
  }

  String retornaLogoLoja({required String idLoja}) {
    return 'https://www.cheapshark.com/' +
        listStores.firstWhere((element) => element.storeID == idLoja).images.logo;
  }

  getStore() async {
    await api.getStores().then((value) {
      value.forEach(
        (element) => listStores.add(
          Stores.fromJson(element),
        ),
      );
    });
  }

  gravaToken() async {
    if (box.get('token', defaultValue: true)) {
      await notf.gettoken();
      var apiMongodb = ApiMongoDB();
      var ret = await apiMongodb.getData(
        tabela: 'Devices',
        selector: {'token': notf.token},
      );
      if (ret.isEmpty) {
        var retorno = await apiMongodb.insertUpdate(
          tabela: 'Devices',
          objeto: Users(
            token: notf.token ?? '',
          ),
        );
        box.put('token', !retorno);
      } else {
        box.put('token', false);
      }
    }
  }

  Map<String, String> linkLojas = {
    "1": 'https://store.steampowered.com',
    "2": 'https://www.gamersgate.com',
    "3": 'https://www.greenmangaming.com',
    "6": 'https://www.direct2drive.com',
    "7": 'https://www.gog.com',
    "8": 'https://www.origin.com',
    "11": 'https://www.humblebundle.com',
    "15": 'https://www.fanatical.com',
    "21": 'https://www.wingamestore.com',
    "23": 'https://www.gamebillet.com',
    "24": 'https://www.voidu.com',
    "25": 'https://www.epicgames.com',
    "27": 'https://www.gamesplanet.com',
    "28": 'https://www.gamesload.com',
    "29": 'https://www.2game.com',
    "30": 'https://www.indiegala.com',
    "32": 'https://www.allyouplay.com',
  };
}
