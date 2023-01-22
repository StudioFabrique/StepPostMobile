import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/views/widgets/custom_button.dart';

class Logout extends StatefulWidget {
  const Logout({
    super.key,
  });

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  late Function callback;

  @override
  void initState() {
    super.initState();
  }

  void initData() {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    dataProvider.logout();
    dataProvider.currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomButton(label: "Déconnexion", callback: initData));
  }
}
