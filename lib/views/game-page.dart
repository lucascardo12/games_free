import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:games_free/controllers/game-controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class GamePage extends GetView {
  final ct = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ct.of.title ?? ''),
      ),
      body: GetBuilder(
        init: ct,
        builder: (controller) {
          if (ct.jogo.info != null) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(height: 10),
                CachedNetworkImage(
                  imageUrl: ct.jogo.info!.thumb ?? '',
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Get.theme.accentColor,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(height: 10),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepPurple.shade600,
                    ),
                    child: Text(
                      'Ofertas',
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    )),
                SizedBox(height: 10),
                Text(
                  'Clique nos links abaixo para resgatar os descontos das lojas',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(height: 10),
                Column(
                  children: ct.jogo.deals!.map((e) {
                    return ListTile(
                      title: Text('\$${e.price}'),
                      subtitle: Text(ct.gb.retornaNomeLoja(idLoja: e.storeID ?? '')),
                      trailing: CachedNetworkImage(
                        imageUrl: ct.gb.retornaLogoLoja(idLoja: e.storeID ?? ''),
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: Get.theme.accentColor,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      onTap: () => launch(ct.retornaUrlLoja(oferta: e)),
                    );
                  }).toList(),
                )
              ],
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.deepPurple.shade600,
            ));
          }
        },
      ),
    );
  }
}
