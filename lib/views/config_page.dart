import 'package:flutter/material.dart';
import 'package:games_free/main.dart';
import 'package:games_free/services/global.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final gb = di.get<Global>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
          contentPadding: const EdgeInsets.all(10),
        ),
      ],
    );
  }
}
