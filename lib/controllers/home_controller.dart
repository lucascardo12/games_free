import 'package:flutter/material.dart';
import 'package:games_free/core/interfaces/controller_interface.dart';
import 'package:games_free/services/admob.dart';
import 'package:games_free/services/global.dart';

class HomeController extends IController {
  final Global gb;
  final AdMob admob;
  var index = ValueNotifier(0);

  HomeController({required this.gb, required this.admob});
  @override
  void close() {}

  @override
  void init(BuildContext context) {}
}
