import 'package:flutter/material.dart';
import 'package:games_free/controllers/oferta-controller.dart';
import 'package:games_free/models/ofertas.dart';
import 'package:get/get.dart';

class OfertaPage extends GetView {
  final ct = Get.put(OfertaController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ct.listOfertas.length != 0
          ? ListView.builder(
              itemCount: ct.listOfertas.length,
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                        '\$ ${of.salePrice} / ${of.normalPrice}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ));
              })
          : Center(
              child: CircularProgressIndicator(
              color: Colors.deepPurple.shade600,
            )),
    );
  }
}
