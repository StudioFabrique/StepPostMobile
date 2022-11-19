import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/screens/signature_pad.dart';
import 'package:step_post_mobile_flutter/views/widgets/card_text.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_button.dart';
import 'package:step_post_mobile_flutter/views/widgets/mail_infos.dart';
import 'package:step_post_mobile_flutter/views/widgets/statut_button.dart';

class UpdateStatut extends StatefulWidget {
  final int statut;
  final Function callback;

  const UpdateStatut({super.key, required this.statut, required this.callback});

  @override
  State<UpdateStatut> createState() => _UpdateStatutState();
}

class _UpdateStatutState extends State<UpdateStatut> {
  late int statut;
  int limit = 8;
  late Function callback;
  bool isUpdated = false;

  @override
  void initState() {
    statut = widget.statut;
    callback = widget.callback;
    initData();
    super.initState();
  }

  @override
  void dispose() {
    callback(isUpdated);
    super.dispose();
  }

  void initData() {
    if (statut == 1) limit = 3;
  }

  void updateStatut(int value) async {
    final data = Provider.of<DataRepository>(context, listen: false);
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
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
                label: data.getEtat(value).toUpperCase(),
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
                      onPressed: () async {
                        if (value == 5) {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignaturePad(
                                        state: value,
                                      )));
                        } else {
                          setState(() {
                            isUpdated = true;
                          });
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          await data.getUpdatedStatuts(state: value);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: kBlue),
                      child: const Text("CONFIRMER"))
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un statut"),
        centerTitle: true,
        backgroundColor: kBlue,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(16),
            child: MailInfos(
              date: dataProvider.courrier.date,
              statut: dataProvider.etat,
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: limit,
            itemBuilder: (context, index) {
              return index == 0
                  ? const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    )
                  : index == 1
                      ? const SizedBox(
                          height: 16,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: index > statut
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width * .7,
                                  child: CustomButton(
                                    label: dataProvider
                                        .getEtat(index)
                                        .toUpperCase(),
                                    callback: updateStatut,
                                    value: index,
                                  ),
                                )
                              : null);
            },
          ))
        ],
      )),
    );
  }
}



/* 
          child: ListView.builder(
            itemCount: limit,
            itemBuilder: (context, index) {
              return index == 0
                  ? Container(
                      margin: const EdgeInsets.all(16),
                      child: MailInfos(
                        date: dataProvider.courrier.date,
                        statut: dataProvider.etat,
                      ),
                    )
                  : index == 1
                      ? const SizedBox(
                          height: 16,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .7,
                            child: CustomButton(
                              label: dataProvider.getEtat(index).toUpperCase(),
                              callback: updateStatut,
                              value: index,
                            ),
                          ));
            },
          )
           */