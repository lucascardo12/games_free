import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MenuTop extends GetView {
  final String label;
  final Function()? onpress;
  final IconData icon;
  final bool index;
  MenuTop({
    required this.label,
    this.onpress,
    required this.icon,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 25,
        backgroundColor: index ? Colors.white : Theme.of(context).backgroundColor,
        child: CircleAvatar(
            backgroundColor: Theme.of(context).backgroundColor,
            child: IconButton(
              onPressed: onpress,
              icon: Icon(
                icon,
                color: Colors.white,
              ),
            )),
      ),
      SizedBox(height: 10),
      Text(label)
    ]);
  }
}
