import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        color: scan.etat != 9
            ? FormatterService().getColor(scan.etat)
            : FormatterService().getColor(5),
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
                      Text("Bordereau n°",
                          style: GoogleFonts.rubik(
                              color: textColor, fontWeight: FontWeight.bold)),
                      Text(
                        scan.courrier.bordereau.toString(),
                        style: GoogleFonts.rubik(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FormatterService().getType(scan.courrier.type),
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                      Text(FormatterService().getDate(scan.date),
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold, color: textColor)),
                      Text(FormatterService().getTime(scan.date),
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold, color: textColor)),
                    ],
                  )
                ],
              ),
              Text(
                  scan.etat != 9
                      ? context
                          .read<DataRepository>()
                          .getEtat(scan.etat)
                          .toUpperCase()
                      : "Procuration",
                  style: GoogleFonts.rubik(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor))
            ],
          ),
        ));
  }
}
