import 'package:flutter/material.dart';
import 'package:step_post_mobile_flutter/models/bottom_bar_datas.dart';
import 'package:step_post_mobile_flutter/models/tab_menu_item.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';

class MyBottomBar extends StatefulWidget {
  final int currentIndex;

  const MyBottomBar({super.key, required this.currentIndex});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  late int currentIndex;
  final List<TabMenuItem> items = BottomBarDatas().getItems();

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: kBlue,
      unselectedItemColor: Colors.white,
      currentIndex: currentIndex,
      items: items.map((item) => item.item).toList(),
    );
  }
}
