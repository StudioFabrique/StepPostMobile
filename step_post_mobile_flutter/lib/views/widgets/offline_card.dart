import 'package:flutter/material.dart';
import 'package:step_post_mobile_flutter/services/formatter_service.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_text.dart';
import 'package:step_post_mobile_flutter/views/widgets/mail_infos.dart';

class OfflineCard extends StatefulWidget {
  final String numBordereau;
  final String statut;
  final Function handleChange;
  const OfflineCard(
      {super.key,
      required this.numBordereau,
      required this.statut,
      required this.handleChange});

  @override
  State<OfflineCard> createState() => _OfflineCardState();
}

class _OfflineCardState extends State<OfflineCard> {
  late String numBordereau;
  late String statut;
  late Function handleChange;
  late TextEditingController numBordereauValue;
  final TextStyle labelStyle = new TextStyle(
      fontSize: 18, color: Colors.grey, fontWeight: FontWeight.normal);

  @override
  void initState() {
    super.initState();
    numBordereau = widget.numBordereau;
    statut = widget.statut;
    handleChange = widget.handleChange;
    numBordereauValue = new TextEditingController(text: numBordereau);
  }

  @override
  void dispose() {
    super.dispose();
    numBordereau;
    statut;
    handleChange;
  }

  String formatDate() {
    DateTime newDate = new DateTime.now();
    String date = FormatterService().getDate(newDate);
    String time = FormatterService().getTime(newDate);
    return "$date - $time";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(label: "Bordereau:", size: 24),
              TextField(
                controller: numBordereauValue,
                onChanged: (newValue) {
                  setState(() {
                    numBordereauValue.text;
                    handleChange(newValue);
                  });
                },
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: kBlue,
                ),
                decoration: InputDecoration(
                    labelText: "Numéro de bordereau", labelStyle: labelStyle),
              ),
              SizedBox(
                height: 24,
              ),
              numBordereauValue.text.length > 0
                  ? MailInfos(date: new DateTime.now(), statut: statut)
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
