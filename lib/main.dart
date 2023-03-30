import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/user_controller.dart';

import 'layout/kasem.dart';
import 'layout/login.dart';

void main(List<String> args) {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserController>(create: (_) => UserController()),
    ],
    child: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => HomeScreen()
      },
    );
  }
}
