import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/views/screens/offline.dart';

import './tab_view_controller.dart';
import '../repositories/data_repository.dart';
import '../utils/constantes.dart';
import '../views/screens/login_page.dart';
import '../views/widgets/custom_text.dart';

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

  /// test la validité d'un potentiel jeton de session dans le storage
  void initData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    Map<String, dynamic>? map = await dataProvider.getHandshake();
    if (map != null) {
      if (map['code'] == 403) {
        toastError();
      } else if (map['code'] == 200) {
        toastSuccess(map['username']);
      }
    }
  }

  /// si l'utilisateur est authentifié l'application devient accessible
  /// à l'uilisateur, sinon la page de connexion est affichée
  @override
  Widget build(BuildContext context) {
    return /*context.watch<DataRepository>().offline
        ? const Offline()
        : context.watch<DataRepository>().isLogged
            ? const TabViewController()
            : const LoginPage();*/
        const Offline();
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

  void toastSuccess(String username) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Text("Bienvenue ", style: GoogleFonts.rubik()),
          Text(
            username,
            style:
                GoogleFonts.rubik(color: kGreen, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ));
  }
}
