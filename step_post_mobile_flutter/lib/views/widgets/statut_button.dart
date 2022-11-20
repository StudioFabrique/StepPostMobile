import 'package:flutter/material.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_text.dart';

class StatutButton extends StatelessWidget {
  final String label;
  final Function callback;
  final int value;

  const StatutButton(
      {super.key,
      required this.label,
      required this.callback,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: kBlue,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () => {callback(value)},
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CardText(
          label: label,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
