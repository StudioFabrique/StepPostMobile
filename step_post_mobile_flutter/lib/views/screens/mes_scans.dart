import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/models/scan.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/screens/search_scan_view.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_scan.dart';
import 'package:step_post_mobile_flutter/views/widgets/search_form.dart';

import '../widgets/no_result.dart';

class MesScans extends StatefulWidget {
  const MesScans({Key? key}) : super(key: key);

  @override
  State<MesScans> createState() => _MesScansState();
}

class _MesScansState extends State<MesScans> {
  bool isLoading = false;

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    setState(() {
      isLoading = true;
    });
    await context.read<DataRepository>().initData();
    setState(() {
      isLoading = false;
    });
  }

  void callback(dynamic value) async {
    List<Scan> searchScans =
        await context.read<DataRepository>().getSearchScan(bordereau: value);
    openSearchScansView(searchScans, value);
  }

  void openSearchScansView(List<Scan> scans, String bordereau) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchScanView(
                  scans: scans,
                  bordereau: bordereau,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    List<Scan> mesScans = dataProvider.mesScans;
    return Center(
        child: isLoading
            ? SpinKitDualRing(
                color: kOrange,
                size: 80,
              )
            : Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SearchForm(callback: callback),
                mesScans.isEmpty
                    ? Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const NoResult(
                          message:
                              "Aucun statut de courrier n'a encore été modifié",
                        ))
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: InkWell(
                                        onDoubleTap: () {
                                          callback(mesScans[index - 1]
                                              .courrier
                                              .bordereau
                                              .toString());
                                        },
                                        child: CustomScan(
                                            scan: mesScans[index]))));
                          },
                          itemCount: mesScans.length,
                        ),
                      ),
              ]));
  }
}
