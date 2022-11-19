import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/card_text.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_button.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

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

  @override
  void initState() {
    state = widget.state;
    callback = widget.callback;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await dataProvider.postSignature(
        signature: uint8ListTob64(bytes!.buffer.asUint8List()));
    await dataProvider.getUpdatedStatuts(state: state);
  }

  String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    final width = MediaQuery.of(context).size.width * .4;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Signature"),
          centerTitle: true,
          backgroundColor: kBlue,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CardText(
                  label:
                      "${dataProvider.courrier!.prenom.toUpperCase()} ${dataProvider.courrier!.nom.toUpperCase()}",
                  fw: FontWeight.bold,
                  size: 20),
              CardText(
                  label: "Bordereau n° ${dataProvider.courrier!.bordereau}",
                  size: 18),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
                  child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: SfSignaturePad(
                          key: signatureGlobalKey,
                          backgroundColor: Colors.white,
                          strokeColor: Colors.black,
                          minimumStrokeWidth: 1.0,
                          maximumStrokeWidth: 1.0))),
              const SizedBox(height: 10),
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
                        callback();
                        Navigator.of(context).pop();
                      },
                      width: width,
                    )
                  ])
            ]));
  }
}
