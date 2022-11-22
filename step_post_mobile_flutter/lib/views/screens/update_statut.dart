import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/screens/signature_pad.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_button.dart';
import 'package:step_post_mobile_flutter/views/widgets/mail_infos.dart';
import 'package:step_post_mobile_flutter/views/widgets/modal_confirm.dart';

class UpdateStatut extends StatefulWidget {
  final int statut;
  final Function updatedStatut;

  const UpdateStatut({
    super.key,
    required this.statut,
    required this.updatedStatut
  });

  @override
  State<UpdateStatut> createState() => _UpdateStatutState();
}

class _UpdateStatutState extends State<UpdateStatut> {
  late int statut;
  int limit = 9;
  late Function callback;
  bool isUpdated = false;
  late Function updatedStatut;

  @override
  void initState() {
    statut = widget.statut;
    updatedStatut = widget.updatedStatut;
    initData();
    super.initState();
  }

  void initData() {
    if (statut == 1) limit = 3;
  }

  updateStatut(int value) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ModalConfirm(
              value: value,
              callback: value == 5
                  ? () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignaturePad(
                          callback: ()  {
                            updatedStatut(value);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          state: value,
                        )));
                    }
                  : () {
                      updatedStatut(value);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
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
              date: dataProvider.courrier!.date,
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
