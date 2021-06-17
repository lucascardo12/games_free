import 'package:games_free/services/adMob.dart';
import 'package:games_free/services/global.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var index = 0.obs;
  final gb = Get.find<Global>();
  final admob = Get.find<AdMob>();
  @override
  void onInit() {
    gb.gravaToken();
    admob.banner.load();
    super.onInit();
  }
}
