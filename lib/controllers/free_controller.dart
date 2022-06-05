import 'package:flutter/material.dart';
import 'package:games_free/core/interfaces/controller_interface.dart';
import 'package:games_free/models/ofertas.dart';
import 'package:games_free/services/global.dart';

class FreeController extends IController {
  var listOfertas = ValueNotifier([]);
  final Global gb;

  FreeController({required this.gb});

  void getOfertas() async {
    var value = await gb.api.getOfertas(upperPrice: 0);
    listOfertas.value = value.map((e) => Ofertas.fromJson(e)).toList();
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
