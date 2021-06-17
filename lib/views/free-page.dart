import 'package:flutter/material.dart';
import 'package:games_free/controllers/free-controller.dart';
import 'package:games_free/models/ofertas.dart';
import 'package:get/get.dart';

class FreePage extends GetView {
  final ct = Get.put(FreeController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          itemCount: ct.listOfertas.length,
          padding: EdgeInsets.all(20),
          itemBuilder: (BuildContext context, int inex) {
            Ofertas of = ct.listOfertas[inex];
            return Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  onTap: () => Get.toNamed('/game', arguments: of),
                  leading: Image.network(
                    of.thumb ?? '',
                    height: 100,
                  ),
                  title: Text(
                    of.title ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    '\$ ${of.normalPrice} Grátis na ${ct.gb.retornaNomeLoja(idLoja: of.storeID ?? '')}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  contentPadding: EdgeInsets.all(10),
                ));
          }),
    );
  }
}