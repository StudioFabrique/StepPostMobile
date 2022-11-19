import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/services/formatter_service.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/screens/update_statut.dart';
import 'package:step_post_mobile_flutter/views/widgets/card_text.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_button.dart';
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
  bool hasBeenUpdated = false;

  callback(bool value) async {
    Future.delayed(Duration.zero, () {
      setState(() {
        hasBeenUpdated = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return dataProvider.isLoading
        ? SpinKitDualRing(
            color: kOrange,
            size: 80,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
                SearchForm(callback: dataProvider.onSearchMail),
                dataProvider.hasCourrier
                    ? Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 24),
                          child: MailCard(
                            mail: dataProvider.courrier,
                          ),
                        ),
                        MailInfos(
                          date: dataProvider.courrier.date,
                          statut: dataProvider.etat,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        dataProvider.courrier.etat < 5
                            ? CustomButton(
                                label: "Modifier le Statut",
                                callback: () {
                                  Navigator.of(context).push(_createRoute());
                                },
                              )
                            : const CardText(
                                label: 'Aucune action disponible',
                                size: 20,
                                fw: FontWeight.bold,
                              ),
                        const SizedBox(
                          height: 24,
                        ),
                        hasBeenUpdated
                            ? CustomButton(
                                label: "Annuler Statut",
                                color: kOrange,
                                callback: () {})
                            : const SizedBox()
                      ])
                    : Container(
                        margin: const EdgeInsets.only(top: 100),
                        child: Image.asset(
                          "assets/images/203_1_1.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
              ]);
  }

  Route _createRoute() {
    final data = Provider.of<DataRepository>(context, listen: false);
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => UpdateStatut(
        statut: data.courrier.etat,
        callback: callback,
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
