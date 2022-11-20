import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/card_text.dart';

class ModalConfirm extends StatelessWidget {
  final int value;
  final Function callback;
  const ModalConfirm({super.key, required this.value, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const CardText(
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
        const CardText(
          label: "Confirmez le nouveau statut :",
          size: 14,
          color: Colors.white,
          fw: FontWeight.bold,
          hasAlignment: TextAlign.center,
        ),
        CardText(
          label: context.read<DataRepository>().getEtat(value).toUpperCase(),
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
              child: const Text("ANNULER"),
            ),
            ElevatedButton(
                onPressed: () {
                  callback();
                },
                style: ElevatedButton.styleFrom(backgroundColor: kBlue),
                child: const Text("CONFIRMER"))
          ],
        )
      ],
    );
  }
}
