import 'package:flutter/material.dart';
import 'package:flutter_post/repositories/data_repository.dart';
import 'package:flutter_post/utils/constantes.dart';
import 'package:flutter_post/views/screens/qrcode_scan.dart';
import 'package:provider/provider.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QRCodeScan()));
            },
            style: ElevatedButton.styleFrom(backgroundColor: kBlue),
            child: const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Scan un QR Code',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            dataProvider.currentScan,
            style: const TextStyle(fontSize: 40),
          )
        ],
      ),
    );
  }
}
