import 'package:flutter/material.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';

class SearchForm extends StatefulWidget {
  final Function callback;

  const SearchForm({Key? key, required this.callback}) : super(key: key);

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  late TextEditingController formValue;
  late Function callback;
  final _mailKey = GlobalKey<FormState>();
  late FocusScopeNode currentFocus = FocusScope.of(context);

  @override
  void initState() {
    formValue = TextEditingController();
    callback = widget.callback;
    super.initState();
  }

  @override
  void dispose() {
    formValue.dispose();
    super.dispose();
  }

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
                onTap: () {
                  if (!currentFocus.hasPrimaryFocus) {
                    setState(() {
                      currentFocus.unfocus();
                    });
                  }
                },
                onChanged: (newValue) {
                  setState(() {
                    formValue.text;
                  });
                },
                controller: formValue,
                validator: (value) {
                  if (value == null || !isNumeric(s: value)) {
                    return "Ceci n'est pas un n° de bordereau valide";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    suffixIcon: formValue.text.isEmpty
                        ? null
                        : IconButton(onPressed: () => clearTextFormField(), icon: const Icon(Icons.clear))
                    ,
                    border: const UnderlineInputBorder(),
                    focusColor: Colors.orange,
                    labelText: 'Saisissez un n° de bordereau'),
              ),
            ),
            Ink(
                decoration:
                ShapeDecoration(color: kBlue, shape: const CircleBorder()),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      currentFocus.unfocus();
                    });
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

  clearTextFormField() {
    formValue.clear();
    setState(() {});
  }
}





