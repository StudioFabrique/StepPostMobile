import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/bottom_bar_datas.dart';
import '../models/tab_menu_item.dart';
import '../repositories/data_repository.dart';
import '../utils/constantes.dart';
import '../views/screens/qrcode_scan.dart';

class TabViewController extends StatefulWidget {
  const TabViewController({super.key});

  @override
  State<TabViewController> createState() => _TabViewControllerState();
}

class _TabViewControllerState extends State<TabViewController> {
  int currentIndex = 0;
  GlobalKey globalKey = GlobalKey();
  final List<TabMenuItem> items = BottomBarDatas().getItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kBlue,
        title: items[context.watch<DataRepository>().currentIndex].appBarTitle,
        centerTitle: true,
      ),
      body: items[context.watch<DataRepository>().currentIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        key: globalKey,
        backgroundColor: kBlue,
        unselectedItemColor: Colors.white,
        currentIndex: context.watch<DataRepository>().currentIndex,
        items: items.map((item) => item.item).toList(),
        onTap: barTapped,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kGreen,
        tooltip: 'Scanner un QR Code',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const QRCodeScan()));
        },
        elevation: 10,
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  void barTapped(int index) {
    context.read<DataRepository>().currentIndex = index;
  }
}
