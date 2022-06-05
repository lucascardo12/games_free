import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:games_free/controllers/game_controller.dart';
import 'package:games_free/main.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final ct = di.get<GameController>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => ct.init(context),
    );
    super.initState();
  }

  @override
  void dispose() {
    ct.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ct.of.title ?? ''),
      ),
      body: AnimatedBuilder(
        animation: ct,
        builder: (controller, child) {
          if (ct.jogo.info != null) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 10),
                CachedNetworkImage(
                  imageUrl: ct.jogo.info!.thumb ?? '',
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text(
                      'Ofertas',
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(height: 10),
                Text(
                  'Clique nos links abaixo para resgatar os descontos das lojas',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(height: 10),
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
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      onTap: () => launchUrlString(
                        ct.retornaUrlLoja(oferta: e),
                        mode: LaunchMode.externalApplication,
                      ),
                    );
                  }).toList(),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          }
        },
      ),
    );
  }
}
