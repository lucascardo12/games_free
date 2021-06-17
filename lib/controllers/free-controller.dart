import 'package:games_free/models/ofertas.dart';
import 'package:games_free/services/global.dart';
import 'package:get/get.dart';

class FreeController extends GetxController {
  List listOfertas = [].obs;
  final gb = Get.find<Global>();
  @override
  void onInit() {
    getOfertas();
    super.onInit();
  }

  getOfertas() async {
    await gb.api.getOfertas(upperPrice: 0).then((value) {
      value.forEach((element) => listOfertas.add(Ofertas.fromJson(element)));
    });
  }
}
