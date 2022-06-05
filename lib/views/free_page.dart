import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:games_free/controllers/free_controller.dart';
import 'package:games_free/main.dart';
import 'package:games_free/models/ofertas.dart';

class FreePage extends StatefulWidget {
  const FreePage({super.key});

  @override
  State<FreePage> createState() => _FreePageState();
}

class _FreePageState extends State<FreePage> {
  final ct = di.get<FreeController>();
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
    return ValueListenableBuilder(
      valueListenable: ct.listOfertas,
      builder: (context, value, child) => ct.listOfertas.value.isNotEmpty
          ? ListView.builder(
              itemCount: ct.listOfertas.value.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (BuildContext context, int inex) {
                Ofertas of = ct.listOfertas.value[inex];
                return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      onTap: () => Navigator.pushNamed(context, '/game', arguments: of),
                      leading: CachedNetworkImage(
                        imageUrl: of.thumb ?? '',
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        of.title ?? '',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        '\$ ${of.normalPrice} Grátis na ${ct.gb.retornaNomeLoja(idLoja: of.storeID ?? '')}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                    ));
              })
          : Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
    );
  }
}
