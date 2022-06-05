import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:games_free/main.dart';
import 'package:games_free/models/store.dart';
import 'package:games_free/services/global.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final gb = di.get<Global>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: gb.listStores,
      builder: (context, value, child) => ListView.builder(
        itemCount: gb.listStores.value.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (BuildContext context, int inex) {
          Stores of = gb.listStores.value[inex];
          return ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            title: Text(
              of.storeName,
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: CachedNetworkImage(
              imageUrl: '${gb.api.host}/${of.images!.logo}',
              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Theme.of(context).colorScheme.secondary,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            onTap: () => launchUrlString(
              gb.linkLojas[of.storeID] ?? "",
              mode: LaunchMode.externalApplication,
            ),
          );
        },
      ),
    );
  }
}
