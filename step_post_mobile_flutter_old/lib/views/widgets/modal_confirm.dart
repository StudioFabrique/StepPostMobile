import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_text.dart';

class ModalConfirm extends StatelessWidget {
  final int value;
  final Function callback;
  const ModalConfirm({super.key, required this.value, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const CustomText(
        label: "Mise à jour du statut",
        size: 18,
        fw: FontWeight.bold,
        color: Colors.white,
        hasAlignment: TextAlign.center,
      ),
      backgroundColor: kLightBlue,
      children: [
        const Icon(
          Icons.fmd_bad_outlined,
          color: Colors.white,
          size: 40,
        ),
        const SizedBox(
          height: 40,
        ),
        const CustomText(
          label: "Confirmez le nouveau statut :",
          size: 14,
          color: Colors.white,
          fw: FontWeight.bold,
          hasAlignment: TextAlign.center,
        ),
        CustomText(
          label: value != 9
              ? context.read<DataRepository>().getEtat(value).toUpperCase()
              : "PROCURATION",
          size: 24,
          color: Colors.white,
          hasAlignment: TextAlign.center,
          fw: FontWeight.bold,
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: kOrange),
              child: Text(
                "ANNULER",
                style: GoogleFonts.rubik(color: Colors.white),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  callback();
                },
                style: ElevatedButton.styleFrom(backgroundColor: kBlue),
                child: Text(
                  "CONFIRMER",
                  style: GoogleFonts.rubik(color: Colors.white),
                ))
          ],
        )
      ],
    );
  }
}
