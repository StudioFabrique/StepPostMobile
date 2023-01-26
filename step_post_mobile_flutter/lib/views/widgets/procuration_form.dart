import 'package:flutter/material.dart';

import '../../utils/constantes.dart';

class ProcurationForm extends StatefulWidget {
  final Function onProcurationNameChange;
  const ProcurationForm(
      {super.key, required Function this.onProcurationNameChange});

  @override
  State<ProcurationForm> createState() => _ProcurationFormState();
}

class _ProcurationFormState extends State<ProcurationForm> {
  late TextEditingController procurationNameController;
  late Function onProcurationNameChange;

  @override
  void initState() {
    procurationNameController = TextEditingController();
    onProcurationNameChange = widget.onProcurationNameChange;
    super.initState();
  }

  @override
  void dispose() {
    procurationNameController.dispose();
    super.dispose();
  }

  void _procurationNameChangedHandler() {
    onProcurationNameChange(procurationNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextField(
      controller: procurationNameController,
      decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          focusColor: kBlue,
          labelText: "Entrez le prénom et le nom"),
      onChanged: (text) => _procurationNameChangedHandler(),
    ));
  }
}
