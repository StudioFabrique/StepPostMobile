import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_post_mobile_flutter/services/formatter_service.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_text.dart';
import '../../models/infos_courriers.dart';

class MailCard extends StatelessWidget {
  final InfosCourrier mail;
  const MailCard({super.key, required this.mail});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomText(
                  label: FormatterService().getType(mail.type),
                  size: 16,
                  fw: FontWeight.bold,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(label: "Bordereau n°", size: 16),
                    Text(
                      mail.bordereau.toString(),
                      style: GoogleFonts.rubik(
                          color: kBlue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  CustomText(label: "${mail.prenom} ${mail.nom}", size: 16),
                  CustomText(label: mail.adresse, size: 16),
                  CustomText(
                      label: "${mail.codePostal} ${mail.ville}", size: 16),
                  CustomText(
                      label:
                          "tél: ${mail.telephone != null ? mail.telephone : 'non disponible'}",
                      size: 16)
                ])
              ],
            )
          ]),
        ),
      ),
    );
  }
}
