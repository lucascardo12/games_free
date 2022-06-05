import 'package:flutter/material.dart';
import 'package:games_free/core/apis/api_cheapshark.dart';
import 'package:games_free/models/store.dart';
import 'package:games_free/services/notificaion.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Global {
  final NotificFCM notf;
  var listStores = ValueNotifier([]);
  final ApiCheapShark api;
  late PackageInfo packageInfo;

  late Box box;

  Global({required this.notf, required this.api});

  Future<Global> inicia() async {
    await Hive.initFlutter();
    box = await Hive.openBox('global');
    packageInfo = await PackageInfo.fromPlatform();
    await getStore();
    return this;
  }

  String retornaNomeLoja({required String idLoja}) {
    return listStores.value.firstWhere((element) => element.storeID == idLoja).storeName;
  }

  String retornaLogoLoja({required String idLoja}) {
    return api.host + listStores.value.firstWhere((element) => element.storeID == idLoja).images.logo;
  }

  Future<void> getStore() async {
    await api.getStores().then(
      (value) {
        for (var element in value) {
          listStores.value.add(
            Stores.fromJson(element),
          );
        }
      },
    );
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
