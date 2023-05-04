import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/ads_controller.dart';
import 'package:seen/controlller/home_controller.dart';
import 'package:seen/controlller/reels_controller.dart';
import 'package:seen/controlller/user_controller.dart';
import 'package:seen/jj.dart';
import 'package:seen/layout/Episode.dart';
import 'package:seen/layout/profile.dart';
import 'package:seen/reel_test.dart';

import 'controlller/setting_controller.dart';
import 'controlller/show_controller.dart';
import 'launch_scrteen.dart';
import 'layout/login.dart';
import 'layout/main_layout.dart';
import 'layout/register.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((e) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
        ChangeNotifierProvider<UserController>(create: (_) => UserController()),
        ChangeNotifierProvider<ShowController>(create: (_) => ShowController()),
        ChangeNotifierProvider<ReelsController>(
            create: (_) => ReelsController()),
        ChangeNotifierProvider<AdsController>(create: (_) => AdsController()),
        ChangeNotifierProvider<SettingController>(
            create: (_) => SettingController())
      ],
      child: Home(),
    ));
  });
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch',
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => MainLayout(),

        '/launch': (context) => VideoSplashScreen(),
        '/profile': (context) => ProfileScreen(),
        '/test': (context) => ReelsScroll()
        // '/video-player': (context) => jj()
      },
    );
  }
}
