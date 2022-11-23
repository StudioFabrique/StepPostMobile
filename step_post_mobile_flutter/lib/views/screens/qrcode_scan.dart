import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_button.dart';

import '../../repositories/data_repository.dart';

class QRCodeScan extends StatefulWidget {
  const QRCodeScan({super.key});

  @override
  State<QRCodeScan> createState() => _QRCodeScanState();
}

class _QRCodeScanState extends State<QRCodeScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan"),
        centerTitle: true,
        backgroundColor: kBlue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? CustomButton(
                      label: '${result!.code}',
                      callback: () async {
                        Navigator.of(context).pop();
                        dataProvider.currentScan = result!.code!;
                        await dataProvider.getCurrentScan();
                        dataProvider.currentIndex = 0;
                      })
                  : Text('Scan a code', style: GoogleFonts.rubik()),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

/*
Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          dataProvider.currentScan = result!.code!;
                          await dataProvider.getCurrentScan();
                          dataProvider.currentIndex = 0;
                        },
                        style:
                            ElevatedButton.styleFrom(backgroundColor: kOrange),
                        child: Text(
                          '${result!.code}',
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    )

                    */