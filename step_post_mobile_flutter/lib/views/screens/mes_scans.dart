import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/models/scan.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_scan.dart';
import 'package:step_post_mobile_flutter/views/widgets/search_form.dart';

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
    await context.read<DataRepository>().getMesScans();
  }

  void callback(dynamic value) async {
    await context.read<DataRepository>().getSearchScan(bordereau: value);
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    List<Scan> mesScans = dataProvider.mesScans;
    print("toto $mesScans");
    return Center( child: ListView.builder(itemBuilder: (context, index) {
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
