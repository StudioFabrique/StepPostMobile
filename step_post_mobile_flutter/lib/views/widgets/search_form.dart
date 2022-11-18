import 'package:flutter/material.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';

class SearchForm extends StatelessWidget {
  final TextEditingController formValue = TextEditingController();
  final _mailKey = GlobalKey<FormState>();
  final Function callback;

  SearchForm({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _mailKey,
      child: Column(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: TextFormField(
                controller: formValue,
                validator: (value) {
                  if (value == null || !isNumeric(s: value)) {
                    return "Ceci n'est pas un n° de bordereau valide";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    focusColor: Colors.orange,
                    labelText: 'Saisissez un n° de bordereau'),
              ),
            ),
            Ink(
                decoration:
                    ShapeDecoration(color: kBlue, shape: const CircleBorder()),
                child: IconButton(
                  onPressed: () {
                    if (_mailKey.currentState!.validate()) {
                      callback(formValue.text);
                    }
                  },
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                )),
          ],
        ),
      ]),
    );
  }

  bool isNumeric({required String s}) {
    return double.tryParse(s) != null;
  }
}




/* _SearchFormState extends State<SearchForm> {
  late TextEditingController bordereau;
  final _mailKey = GlobalKey<FormState>();
  late Function callback; */
