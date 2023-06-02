import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
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
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isOffLine = false;

  @override
  void initState() {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityResult = result;
      });
      if (_connectivityResult == ConnectivityResult.none) {
        dataProvider.offline = true;
      } else if (_connectivityResult == ConnectivityResult.wifi) {
        dataProvider.offline = false;
      } else if (_connectivityResult == ConnectivityResult.mobile) {
        dataProvider.offline = false;
      }
    });
    initData();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
      setState(() {
        _connectivityResult = result;
      });
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return;
    }
  }

  void initData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    print(dataProvider.isLogged);
    Map<String, dynamic>? map = await dataProvider.getHandshake();
    if (map != null) {
      if (map['code'] == 403) {
        toastError();
      } else if (map['code'] == 200) {
        toastSuccess(map['username']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    return dataProvider.offline
        ? const Offline()
        : dataProvider.isLogged
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
        ),
      ),
    );
  }

  void toastSuccess(String username) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Text("Bienvenue ", style: GoogleFonts.rubik()),
          Text(
            username,
            style: GoogleFonts.rubik(
              color: kGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ));
  }
}
