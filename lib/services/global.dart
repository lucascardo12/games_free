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
    getStore();
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
      apiMongodb.insertUpdate(
        tabela: 'Devices',
        objeto: Users(
          token: notf.token ?? '',
        ),
      );
      await box.put('token', false);
    }
  }
}
