import 'package:flutter/material.dart';

import 'custom_text.dart';

class NoResult extends StatelessWidget {
  final String message;

  const NoResult({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(label: message, size: 20, fw: FontWeight.bold,),
        Image.asset("assets/images/203_1_1.png",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,),
      ],);
  }
}
