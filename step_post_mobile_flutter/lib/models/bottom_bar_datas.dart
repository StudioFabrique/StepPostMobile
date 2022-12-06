import 'package:flutter/material.dart';
import 'package:step_post_mobile_flutter/models/tab_menu_item.dart';
import 'package:step_post_mobile_flutter/views/screens/current_scan.dart';
import 'package:step_post_mobile_flutter/views/screens/logout.dart';
import 'package:step_post_mobile_flutter/views/screens/mes_scans.dart';

class BottomBarDatas {
  List<TabMenuItem> items = [
    TabMenuItem(
        label: 'Mes Scans', iconData: Icons.pedal_bike, page: const MesScans()),
    TabMenuItem(
        label: 'Scan en cours',
        iconData: Icons.mail,
        page: const CurrentScan()),
    TabMenuItem(
        label: "Déconnexion",
        iconData: Icons.exit_to_app_outlined,
        page: const Logout())
  ];

  List<TabMenuItem> getItems() => items;
}
