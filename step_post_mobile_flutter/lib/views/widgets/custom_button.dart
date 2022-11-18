import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function callback;
  final Color? color;
  final dynamic value;

  const CustomButton(
      {super.key,
      required this.label,
      required this.callback,
      this.color = const Color(0xff140a82),
      this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color),
          onPressed: value != null ? () => callback(value) : () => callback(),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 18),
            ),
          )),
    );
  }
}
