import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/models/bottom_bar_datas.dart';
import 'package:step_post_mobile_flutter/models/tab_menu_item.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/screens/qrcode_scan.dart';

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
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
        title: items[dataProvider.currentIndex].appBarTitle,
        centerTitle: true,
      ),
      body: items[dataProvider.currentIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        key: globalKey,
        backgroundColor: kBlue,
        unselectedItemColor: Colors.white,
        currentIndex: dataProvider.currentIndex,
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
