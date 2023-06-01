import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/scanner_widget.dart';

import '../../repositories/data_repository.dart';

class QRCodeScan extends StatelessWidget {
  const QRCodeScan({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Scan"),
          centerTitle: true,
          backgroundColor: kBlue,
        ),
        body: ScannerWidget(
          onScanned: (String value) async {
            Navigator.of(context).pop();
            dataProvider.currentScan = value;
            await dataProvider.getCurrentScan();
            if (dataProvider.currentIndex != 2) {
              dataProvider.currentIndex = 1;
            }
          },
        ));
  }
}
