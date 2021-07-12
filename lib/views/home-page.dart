import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:games_free/controllers/home-controller.dart';
import 'package:games_free/views/config-page.dart';
import 'package:games_free/views/free-page.dart';
import 'package:games_free/views/ofertas-page.dart';
import 'package:games_free/views/store-page.dart';
import 'package:games_free/widgets/menuTop.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends GetView {
  final ct = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade600,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Menu',
                      style: Theme.of(context).textTheme.headline6!,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => MenuTop(
                              label: 'Free',
                              index: ct.index.value == 0,
                              icon: Icons.free_breakfast,
                              onpress: () => ct.index.value = 0,
                            )),
                        Obx(() => MenuTop(
                              label: 'Ofertas',
                              icon: Icons.offline_bolt,
                              index: ct.index.value == 1,
                              onpress: () => ct.index.value = 1,
                            )),
                        Obx(() => MenuTop(
                              label: 'Lojas',
                              icon: Icons.store,
                              index: ct.index.value == 2,
                              onpress: () => ct.index.value = 2,
                            )),
                        Obx(() => MenuTop(
                              label: 'Config',
                              icon: Icons.settings,
                              index: ct.index.value == 3,
                              onpress: () => ct.index.value = 3,
                            ))
                      ],
                    )
                  ],
                ),
              )),
          Obx(() => Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: [
                  FreePage(),
                  OfertaPage(),
                  StorePage(),
                  ConfigPage(),
                ].elementAt(
                  ct.index.value,
                ),
              ))),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: Get.width,
        child: AdWidget(
          ad: ct.admob.banner,
        ),
      ),
    );
  }
}
