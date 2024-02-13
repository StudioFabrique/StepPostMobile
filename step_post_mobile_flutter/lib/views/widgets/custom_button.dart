import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function callback;
  final Color color;
  final dynamic value;
  final double width;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.callback,
    this.color = const Color(0xff140a82),
    this.value,
    this.width = 200,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 10,
        ),
        onPressed: value != null ? () => callback(value) : () => callback(),
        child: Text(
          label,
          style: GoogleFonts.rubik(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
