import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            "assets/images/welcome.png",
            width: MediaQuery.of(context).size.width * .65,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
