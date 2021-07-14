import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:games_free/controllers/home-controller.dart';
import 'package:games_free/models/store.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class StorePage extends GetView {
  final ct = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: ct.gb.listStores.length,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (BuildContext context, int inex) {
          Stores of = ct.gb.listStores[inex];
          return ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            title: Text(
              of.storeName,
              style: Get.textTheme.headline6,
            ),
            trailing: CachedNetworkImage(
              imageUrl: 'https://www.cheapshark.com/${of.images!.logo}',
              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Get.theme.accentColor,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            onTap: () => launch(ct.gb.linkLojas[of.storeID] ?? ""),
          );
        },
      ),
    );
  }
}
