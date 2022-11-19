import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/services/formatter_service.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/card_text.dart';

class MailInfos extends StatelessWidget {
  final DateTime date;
  final String statut;

  const MailInfos({super.key, required this.date, required this.statut});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        CardText(
          label:
              "${FormatterService().getDate(date)} à ${FormatterService().getTime(date)}",
          size: 18,
          fw: FontWeight.bold,
          color: kOrange,
        ),
        CardText(
          label: statut.toUpperCase(),
          size: 18,
          fw: FontWeight.bold,
        )
      ],
    );
  }
}
