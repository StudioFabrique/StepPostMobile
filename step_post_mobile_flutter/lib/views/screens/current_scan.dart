import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/models/infos_courriers.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/screens/update_statut.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_button.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_text.dart';
import 'package:step_post_mobile_flutter/views/widgets/mail_card.dart';
import 'package:step_post_mobile_flutter/views/widgets/mail_infos.dart';
import 'package:step_post_mobile_flutter/views/widgets/search_form.dart';

class CurrentScan extends StatefulWidget {
  const CurrentScan({
    super.key,
  });

  @override
  State<CurrentScan> createState() => _CurrentScanState();
}

class _CurrentScanState extends State<CurrentScan> {
  bool isLoading = false;
  InfosCourrier? mail;

  callback(bool value) {
    Future.delayed(Duration.zero, () {
      context.read<DataRepository>().hasBeenUpdated = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///final dataProvider = Provider.of<DataRepository>(context);
    mail = context.watch<DataRepository>().courrier;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SearchForm(callback: context.watch<DataRepository>().onSearchMail),
          mail != null
              ? Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 24),
              child: MailCard(
                mail: mail!,
              ),
            ),
            MailInfos(
              date: mail!.date,
              statut: context.watch<DataRepository>().etat,
            ),
            const SizedBox(
              height: 24,
            ),
            mail!.etat < 5
                ? CustomButton(
              label: "Modifier le Statut",
              callback: () {
                Navigator.of(context).push(_createRoute());
              },
            )
                : const CustomText(
              label: 'Aucune action disponible',
              size: 20,
              fw: FontWeight.bold,
            ),
            const SizedBox(
              height: 24,
            ),
            context.watch<DataRepository>().hasBeenUpdated
                ? CustomButton(
                label: "Annuler Statut",
                color: kOrange,
                callback: () {
                  context.read<DataRepository>().deleteStatut(
                      bordereau:
                      mail!.bordereau);
                })
                : const SizedBox()
          ])
              : Container(
            margin: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/203_1_1.png",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                const CustomText(
                  label: "Aucun résultat",
                  size: 20,
                  fw: FontWeight.bold,
                )
              ],
            ),
          ),
        ]);
  }

  checkUpdatedStatutResponse(int value) async {
    setState(() {
      isLoading = true;
    });
    await context.read<DataRepository>().getUpdatedStatuts(state: value);
    setState(() {
      isLoading = false;
    });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => UpdateStatut(
        statut: context.watch<DataRepository>().courrier!.etat, updatedStatut: checkUpdatedStatutResponse,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

}
