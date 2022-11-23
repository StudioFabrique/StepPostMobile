import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/controller/tab_view_controller.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/services/shared_handler.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';
import 'package:step_post_mobile_flutter/views/screens/login_page.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_text.dart';

class MainController extends StatefulWidget {
  const MainController({super.key});

  @override
  State<MainController> createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    String token = await SharedHandler().getToken();
    if (token.isNotEmpty) {
      int? code = await dataProvider.getTestToken(tokenToTest: token);
      if (code == 403) {
        toastError();
      } else if (code == 200) {
        toastSuccess();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return dataProvider.isLogged
        ? const TabViewController()
        : const LoginPage();
  }

  void toastError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: CustomText(
        label: "Jeton de session expiré, veuillez vous reconnecter",
        size: 14,
        color: kOrange,
        fw: FontWeight.bold,
      )),
    );
  }

  void toastSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        Text("Bienvenue ", style: GoogleFonts.rubik(),),
        Text(
          context.read<DataRepository>().name,
          style: GoogleFonts.rubik(
              color: kGreen, fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    )));
  }
}
