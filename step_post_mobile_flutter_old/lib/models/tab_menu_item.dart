import 'package:flutter/material.dart';

class TabMenuItem {
  String label;
  IconData iconData;
  Widget page;

  //  getters

  Icon get icon => Icon(
        iconData,
        color: Colors.white,
      );
  Text get appBarTitle => Text(label);

  BottomNavigationBarItem get item =>
      BottomNavigationBarItem(icon: icon, label: label);

  TabMenuItem(
      {required this.label, required this.iconData, required this.page});
}
