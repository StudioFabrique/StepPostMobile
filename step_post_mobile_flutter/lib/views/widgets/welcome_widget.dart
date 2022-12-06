import 'package:flutter/material.dart';

import './custom_text.dart';

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
            "assets/images/welcome.webp",
            width: MediaQuery.of(context).size.width * .75,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .75,
            child: const CustomText(
              label:
                  "Bonjour, scannez un QRCode ou recherchez un numéro de bordereau avec le formulaire",
              size: 18,
              hasAlignment: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
