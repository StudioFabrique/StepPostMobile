import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/views/screens/update_statut.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_button.dart';
import 'package:step_post_mobile_flutter/views/widgets/offline_card.dart';
import 'package:step_post_mobile_flutter/views/widgets/scanner_widget.dart';

class Offline extends StatefulWidget {
  const Offline({super.key});

  @override
  State<Offline> createState() => _OfflineState();
}

class _OfflineState extends State<Offline> {
  bool isScanning = false;
  bool isUpdating = false;
  String statut = "pris en charge";
  String numBordereau = "";
  final DateTime date = new DateTime.now();

  void handleScanned(String value) {
    setState(() {
      isScanning = false;
      numBordereau = value;
    });
  }

  void handleChange(String value) {
    print("value: $value");
    setState(() {
      numBordereau = value;
    });
  }

  void handleUpdateMail() {
    print("bonjour");
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => UpdateStatut(
        statut: 2,
        date: date,
        updatedStatut: handleUpdateMail,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Hors Connexion"),
        centerTitle: true,
      ),
      body: isScanning
          ? ScannerWidget(onScanned: handleScanned)
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                OfflineCard(
                  numBordereau: numBordereau,
                  statut: statut,
                  date: date,
                  handleChange: handleChange,
                ),
                SizedBox(
                  height: 32,
                ),
                CustomButton(
                  label: "Modifier le Statut",
                  color: Colors.red,
                  callback: () {
                    Navigator.push(context, _createRoute());
                  },
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        tooltip: 'Scanner un QR Code',
        onPressed: () {
          dataProvider.offline = true;
          setState(() {
            isScanning = true;
          });
        },
        elevation: 10,
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
