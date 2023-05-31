import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';

class Offline extends StatelessWidget {
  const Offline({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text("Y'a l'internet qui est en panne!"),
        ),
        ElevatedButton(
            onPressed: () {
              dataProvider.getHandshake();
            },
            child: Text("Refresh"))
      ],
    ));
  }
}
