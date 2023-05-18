import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seen/controller/ads_controller.dart';
import 'package:seen/controller/home_controller.dart';
import 'package:seen/controller/reels_controller.dart';
import 'package:seen/controller/user_controller.dart';
import 'package:seen/layout/profile.dart';

import 'controller/setting_controller.dart';
import 'controller/show_controller.dart';
import 'launch_scrteen.dart';
import 'layout/login.dart';
import 'layout/main_layout.dart';
import 'layout/register.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual  ,overlays: [ SystemUiOverlay.top]);
  })
  
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
      child: const Home(),
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
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'font',
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:
                Colors.transparent, // Customize the status bar color
            statusBarIconBrightness:
                Brightness.light, // Customize the status bar icon color
            systemNavigationBarColor:
                Colors.black,
                systemStatusBarContrastEnforced: false, // Customize the navigation bar color
            systemNavigationBarIconBrightness:
                Brightness.light, // Customize the navigation bar icon color
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => MainLayout(),
        '/launch': (context) => VideoSplashScreen(),
        '/profile': (context) => ProfileScreen(),

        // '/video-player': (context) => jj()
      },
    );
  }
}
