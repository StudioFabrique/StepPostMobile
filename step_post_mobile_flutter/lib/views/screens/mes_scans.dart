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

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    if (context.read<DataRepository>().mesScans.isEmpty) {
      await context.read<DataRepository>().getMesScans();
    }
  }

  void callback(dynamic value) async {
    List<Scan> searchScans = await context.read<DataRepository>().getSearchScan(bordereau: value);
    openSearchScansView(searchScans, value);
  }

  void openSearchScansView(List<Scan> scans, String bordereau) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScanView(scans: scans, bordereau: bordereau,)));
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    List<Scan> mesScans = dataProvider.mesScans;
    return Center(
      child:
      dataProvider.isLoading
          ? SpinKitDualRing(color: kOrange, size: 80,)
          : mesScans.isEmpty
          ? const NoResult(message: "Aucun courrier n'a été scanné aujourd'hui",)
          : ListView.builder(itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child:
            index == 0
                ? SearchForm(callback: callback)
                : Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomScan(scan: mesScans[index - 1])));
      },
        itemCount: mesScans.length + 1,),
    );
  }
}
