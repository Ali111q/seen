import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/user_controller.dart';
import 'package:seen/jj.dart';

import 'layout/login.dart';
import 'layout/main_layout.dart';

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
      initialRoute: '/',
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => MainLayout(),
        '/': (context) => jj()
      },
    );
  }
}
