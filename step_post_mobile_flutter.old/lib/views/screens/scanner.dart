import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/screens/qrcode_scan.dart';

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
            child:  Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Scan un QR Code',
                style: GoogleFonts.rubik(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            dataProvider.currentScan,
            style: GoogleFonts.rubik(fontSize: 40),
          )
        ],
      ),
    );
  }
}
