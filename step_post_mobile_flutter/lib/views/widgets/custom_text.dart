import 'package:flutter/material.dart';

class CardText extends StatelessWidget {
  final String label;
  final double size;
  final FontWeight fw;
  final Color color;
  final TextAlign hasAlignment;

  const CardText(
      {super.key,
      required this.label,
      required this.size,
      this.fw = FontWeight.normal,
      this.color = const Color(0xff140a82),
      this.hasAlignment = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: size, color: color, fontWeight: fw),
      textAlign: hasAlignment,
    );
  }
}
