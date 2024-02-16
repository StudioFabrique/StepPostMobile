import 'package:flutter/material.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController username;
  late TextEditingController password;

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kBlue,
        title: const Text("Connexion"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width * .66,
            child: const LoginForm(),
          ),
          Container(
            decoration: BoxDecoration(color: kGreen),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .2,
            child: Image.asset("assets/images/logo-step-post.png"),
          )
        ],
      ),
    );
  }
}
