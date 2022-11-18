import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/services/formatter_service.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/screens/update_statut.dart';
import 'package:step_post_mobile_flutter/views/widgets/card_text.dart';
import 'package:step_post_mobile_flutter/views/widgets/mail_card.dart';
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CardText(
                              label:
                                  "${FormatterService().getDate(dataProvider.courrier.date)} à ${FormatterService().getTime(dataProvider.courrier.date)}",
                              size: 18,
                              fw: FontWeight.bold,
                              color: kOrange,
                            ),
                            CardText(
                              label: dataProvider.etat.toUpperCase(),
                              size: 18,
                              fw: FontWeight.bold,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        dataProvider.courrier.etat < 5
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(_createRoute());
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kBlue,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    'MODIFIER LE STATUT',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ))
                            : const CardText(
                                label: 'Aucune action disponible',
                                size: 20,
                                fw: FontWeight.bold,
                              ),
                        const SizedBox(
                          height: 24,
                        ),
                        hasBeenUpdated
                            ? ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kOrange,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    'ANNULER STATUT',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ))
                            : const SizedBox()
                      ])
                    : Container(
                        margin: const EdgeInsets.only(top: 200),
                        child: Text(
                          "Aucun Résultat",
                          style: TextStyle(
                              color: kBlue,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      )
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
