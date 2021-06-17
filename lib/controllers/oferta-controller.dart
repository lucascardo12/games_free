import 'package:games_free/apis/api-cheapshark.dart';
import 'package:games_free/models/ofertas.dart';
import 'package:get/get.dart';

class OfertaController extends GetxController {
  List listOfertas = [].obs;
  var api = ApiCheapShark();
  @override
  void onInit() {
    getOfertas();
    super.onInit();
  }

  getOfertas() async {
    List<dynamic> anterior = [];
    await api.getOfertas().then((value) {
      value.forEach((element) {
        if (anterior.indexWhere((x) => element['gameID'] == x['gameID']) < 0) {
          anterior.add(element);
          listOfertas.add(Ofertas.fromJson(element));
        }
      });
    });
  }
}
