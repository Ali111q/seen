import 'package:devicelocale/devicelocale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:seen/binding/root_binding.dart';
import 'package:seen/config/style/colors.dart';
import 'package:seen/core/language.dart';
import 'package:seen/view/auth/login/login.dart';
import 'package:seen/view/auth/register/register.dart';
import 'package:seen/view/intro/intro.dart';
import 'package:seen/view/main_layout/main_layout.dart';
import 'package:seen/view/on_boarding/on_boarding.dart';
import 'package:seen/view/profile/profile.dart';
import 'package:seen/view/reels/reels.dart';
import 'package:seen/view/show/show.dart';
import 'package:seen/view/stream/radio.dart';
import 'package:seen/view/stream/streamFullScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

late SharedPreferences prefs;

void main(List<String> args) async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  prefs = await SharedPreferences.getInstance();
  String deviceLocale = await Devicelocale.currentLocale ?? '';
  print('language pre: $deviceLocale');
  // prefs.setString('locale', deviceLocale.split('-').first);
  prefs.setString('locale', 'ar');
  String? locale = prefs.getString('locale');
  Get.updateLocale(Locale(locale ?? 'ar'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme:
              const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
          canvasColor: Colors.black.withOpacity(0.7),
          navigationBarTheme:
              const NavigationBarThemeData(backgroundColor: Colors.black),
          scaffoldBackgroundColor: MyColors.backGround,
          fontFamily: GoogleFonts.almarai().fontFamily),
      initialBinding: RootBionding(),
      routes: {
        '/': (context) => const IntroView(),
        '/main': (context) => MainLayoutView(),
        '/profile': (context) => ProfileView(),
        '/login': (context) => LoginView(),
        '/register': (context) => RegisterView(),
        '/radio': (context) => RadioView(),
        '/video-player': (context) => StreamFullScreenView(),
        '/onBoard': (context) => OnBoardingView(),
        '/show': (context) => ShowView(),
        '/reel_videos': (context) => ReelsView(),
      },
      translations: Language(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
