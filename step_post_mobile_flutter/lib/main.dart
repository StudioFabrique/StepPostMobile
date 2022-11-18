import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/controller/main_controller.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => DataRepository(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MainController(),
    );
  }
}
