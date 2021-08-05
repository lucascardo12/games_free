import 'package:flutter/material.dart';
import 'package:games_free/services/global.dart';
import 'package:get/get.dart';

class ConfigPage extends GetView {
  final gb = Get.find<Global>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        ListTile(
          dense: true,
          title: Text(
            'Versão',
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: Text(
            gb.packageInfo.version,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          contentPadding: EdgeInsets.all(10),
        ),
      ],
    );
  }
}
