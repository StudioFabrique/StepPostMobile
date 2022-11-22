import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/models/scan.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/services/formatter_service.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';

class CustomScan extends StatefulWidget {
  final Scan scan;
  const CustomScan({Key? key, required this.scan}) : super(key: key);

  @override
  State<CustomScan> createState() => _CustomScanState();
}

class _CustomScanState extends State<CustomScan> {
  late Scan scan;
  late Color textColor;

  @override
  void initState() {
    scan = widget.scan;
    textColor = scan.etat == 7 || scan.etat == 8 ? kBlue : Colors.white;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
        color: FormatterService().getColor(scan.etat),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bordereau n°", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                      Text(scan.courrier.bordereau.toString(), style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),),
                    ],
                  ),

                  const SizedBox(height: 24,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(FormatterService().getType(scan.courrier.type), style: TextStyle(fontWeight: FontWeight.bold, color: textColor),),
                      Text(FormatterService().getDate(scan.date), style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                      Text(FormatterService().getTime(scan.date), style: TextStyle(fontWeight: FontWeight.bold, color: textColor))
                    ],
                  )
                ],
              ),
              Container(
                child:
                Text(context.read<DataRepository>().getEtat(scan.etat).toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
              )
            ],
          ),
        )
    );
  }
}


