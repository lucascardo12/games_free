import 'package:flutter/material.dart';
import 'package:games_free/controllers/home-controller.dart';
import 'package:games_free/models/store.dart';
import 'package:get/get.dart';

class StorePage extends GetView {
  final ct = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        itemCount: ct.gb.listStores.length,
        padding: EdgeInsets.all(20),
        itemBuilder: (BuildContext context, int inex) {
          Stores of = ct.gb.listStores[inex];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            title: Text(
              of.storeName,
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: Image.network('https://www.cheapshark.com/${of.images!.logo}'),
            onTap: () => null,
          );
        }));
  }
}
