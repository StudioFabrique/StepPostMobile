import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController username;
  late TextEditingController password;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      username.dispose();
      password.dispose();
    });
    super.dispose();
  }

  /// formulaire de connexion
  @override
  Widget build(BuildContext context) {
    return Center(
        child: !isLoading
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
                    height: 48,
                  ),
                  CustomButton(
                    label: "Se connecter",
                    //click bouton
                    callback: handleLogin,
                  )
                ]),
              )
            : SpinKitDualRing(
                color: kOrange,
                size: 60,
              ));
  }

  void handleLogin() async {
    print("toto");
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final data = await dataProvider.login(
          username: username.text, password: password.text);
      setState(() {
        isLoading = false;
      });
      if (data!['httpCode'] == 200) {
        toast(code: data['httpCode']!, name: data['name']);
      } else if (data['httpCode'] == 400) {
        setState(() {
          isLoading = false;
        });
        toast(code: data['httpCode']);
      } else if (data['httpCode'] == 500) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  /// vérifie si s est une chaîne de caractères composée uniquement de chiffres
  bool isNumeric({required String s}) {
    return double.tryParse(s) != null;
  }

  /// affiche un toast en fonctiondu résultat de la tentative de connexion
  /// de l'utilisateur
  void toast({required int code, String name = ""}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: code == 200
            ? Row(
                children: [
                  Text(
                    "Bienvenue ",
                    style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    name,
                    style: GoogleFonts.rubik(
                        color: kGreen, fontWeight: FontWeight.bold),
                  )
                ],
              )
            : Text(
                "Identifiants incorrects",
                style: GoogleFonts.rubik(
                    color: kOrange, fontWeight: FontWeight.bold),
              )));
  }
}
