import 'package:flutter/material.dart';
import 'package:step_post_mobile_flutter/models/scan.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_scan.dart';
import 'package:step_post_mobile_flutter/views/widgets/no_result.dart';

class SearchScanView extends StatelessWidget {
  final List<Scan> scans;
  final String bordereau;

  const SearchScanView({Key? key, required this.scans, required this.bordereau})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Résultat n° : $bordereau"),
        centerTitle: true,
        backgroundColor: kBlue,
      ),
      body: scans.isEmpty
          ? const NoResult(message: "Aucun courrier n'a été trouvé")
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomScan(
                            scan: scans[index],
                          )));
                },
                itemCount: scans.length,
              ),
            ),
    );
  }
}
