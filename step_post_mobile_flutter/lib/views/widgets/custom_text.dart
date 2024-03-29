import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String label;
  final double size;
  final FontWeight fw;
  final Color color;
  final TextAlign hasAlignment;

  const CustomText(
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
      style: GoogleFonts.rubik(fontSize: size, color: color, fontWeight: fw),
      textAlign: hasAlignment,
    );
  }
}
