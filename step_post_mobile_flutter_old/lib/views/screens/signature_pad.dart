import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../repositories/data_repository.dart';
import '../../utils/constantes.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/procuration_form.dart';

class SignaturePad extends StatefulWidget {
  final int state;
  final Function callback;

  const SignaturePad({super.key, required this.state, required this.callback});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  late int state;
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  late Function callback;
  String procurationName = '';
  //late TextEditingController procurationNameController;

  @override
  void initState() {
    state = widget.state;
    print(state);
    callback = widget.callback;
    //procurationNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // procurationNameController.dispose();
    super.dispose();
  }

  Future<void> _emptyProcurationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Procuration',
            style: TextStyle(color: const Color(0xff140a82)),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                CustomText(
                  label: 'Merci de saisir un prénom et un nom svp.',
                  size: 18,
                  color: const Color(0xff140a82),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Fermer',
                style: TextStyle(color: const Color(0xff140a82)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    if (state != 9) {
      await dataProvider.postSignature(
          signature: uint8ListTob64(bytes!.buffer.asUint8List()));
      callback();
    } else if (state == 9 && procurationName.isNotEmpty) {
      await dataProvider.postSignature(
          signature: uint8ListTob64(bytes!.buffer.asUint8List()));
      await dataProvider.postProcuration(procuration: procurationName);
      callback();
    } else if (state == 9 && procurationName.isEmpty) {
      _emptyProcurationDialog();
    }
  }

  String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }

  void _onProcurationNameChange(value) {
    procurationName = value;
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    final width = MediaQuery.of(context).size.width * .4;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Signature"),
          centerTitle: true,
          backgroundColor: kBlue,
          foregroundColor: Colors.white,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              state == 9
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ProcurationForm(
                          onProcurationNameChange: _onProcurationNameChange),
                    )
                  : const SizedBox(),
              Column(
                children: [
                  CustomText(
                    label: 'Destinataire',
                    size: 20,
                    fw: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomText(
                      label:
                          "${dataProvider.courrier!.prenom != null ? dataProvider.courrier!.prenom!.toUpperCase() : null} ${dataProvider.courrier!.nom.toUpperCase()}",
                      size: 20),
                  CustomText(
                    label: "Bordereau n° ${dataProvider.courrier!.bordereau}",
                    size: 18,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: SfSignaturePad(
                              key: signatureGlobalKey,
                              backgroundColor: Colors.white,
                              strokeColor: Colors.black,
                              minimumStrokeWidth: 1.0,
                              maximumStrokeWidth: 1.0))),
                  const SizedBox(height: 32),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomButton(
                          label: "Effacer",
                          callback: _handleClearButtonPressed,
                          width: width,
                          color: kOrange,
                        ),
                        CustomButton(
                          label: "Enregistrer",
                          callback: () {
                            _handleSaveButtonPressed();
                            //callback();
                          },
                          width: width,
                        )
                      ])
                ],
              )
            ]));
  }
}
