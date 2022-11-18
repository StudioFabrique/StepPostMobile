import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/card_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController username;
  late TextEditingController password;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Center(
        child: dataProvider.isLoading == false
            ? Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value == null || !mailRegEX.hasMatch(value)) {
                        return "Entrez une adresse email valide";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        focusColor: kBlue,
                        labelText: "Entrez votre Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value == null || !isNumeric(s: value)) {
                        return "Entrez un mot de passe valide";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        focusColor: kBlue,
                        labelText: "Entrez votre mot de passe"),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      int? code = await dataProvider.login(
                          username: "toto@tata.fr", password: "1234");
                      if (code == 200) {
                        toast(code: true, name: dataProvider.name);
                      } else if (code == 401) {
                        toast(code: false);
                      }
                      //  }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text("SE CONNECTER"),
                  )
                ]),
              )
            : SpinKitDualRing(
                color: kOrange,
                size: 60,
              ));
  }

  bool isNumeric({required String s}) {
    return double.tryParse(s) != null;
  }

  void toast({required bool code, String name = ""}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: code
              ? Row(
                  children: [
                    const Text("Bonjour "),
                    CardText(
                      label: name.toUpperCase(),
                      size: 15,
                      color: kGreen,
                      fw: FontWeight.bold,
                    )
                  ],
                )
              : CardText(
                  label: "Identifiants incorrects",
                  size: 14,
                  color: kOrange,
                  fw: FontWeight.bold,
                )),
    );
  }
}
