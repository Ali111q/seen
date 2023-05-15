import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:provider/provider.dart';
import 'package:seen/controller/setting_controller.dart';
import 'package:seen/controller/user_controller.dart';
import 'package:video_player/video_player.dart';

class VideoSplashScreen extends StatefulWidget {
  @override
  _VideoSplashScreenState createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen>
    with SingleTickerProviderStateMixin {
  // late FlutterGifController controller;
  @override
  void initState() {
    super.initState();

    Provider.of<UserController>(context, listen: false).getUserFromShared();
    // controller = FlutterGifController(vsync: this);

    _push();
  }

  _push() async {
    Provider.of<SettingController>(context, listen: false).getSetting();
    await Future.delayed(Duration(seconds: 4));
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff080029), Color(0xff420808)],
        )),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  child: Image.asset("assets/images/int.gif"),
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
