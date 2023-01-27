import 'package:flutter/material.dart';

import './custom_text.dart';
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

  void _clearTextField() {
    procurationNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label: 'A distribuer par procuration à :',
          size: 18,
          fw: FontWeight.bold,
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: procurationNameController,
          decoration: InputDecoration(
              suffixIcon: procurationNameController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () => _clearTextField,
                      icon: const Icon(Icons.clear)),
              border: const UnderlineInputBorder(),
              focusColor: kBlue,
              labelText: "Entrez le prénom et le nom"),
          onChanged: (text) => _procurationNameChangedHandler(),
        ),
      ],
    ));
  }
}
