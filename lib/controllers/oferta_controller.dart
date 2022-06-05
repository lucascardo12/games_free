import 'package:flutter/material.dart';
import 'package:games_free/core/apis/api_cheapshark.dart';
import 'package:games_free/core/interfaces/controller_interface.dart';
import 'package:games_free/models/ofertas.dart';

class OfertaController extends IController {
  var listOfertas = ValueNotifier([]);
  final ApiCheapShark api;

  OfertaController(this.api);

  void getOfertas() async {
    List<dynamic> anterior = [];
    var value = await api.getOfertas();
    for (var element in value) {
      if (anterior.indexWhere((x) => element['gameID'] == x['gameID']) < 0) {
        anterior.add(element);
      }
    }
    listOfertas.value = anterior.map((e) => Ofertas.fromJson(e)).toList();
  }

  @override
  void close() {
    listOfertas.dispose();
  }

  @override
  void init(BuildContext context) {
    getOfertas();
  }
}
