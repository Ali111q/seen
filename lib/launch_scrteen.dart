import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/user_controller.dart';
import 'package:video_player/video_player.dart';

class VideoSplashScreen extends StatefulWidget {
  @override
  _VideoSplashScreenState createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen>
    with SingleTickerProviderStateMixin {
  late FlutterGifController controller;
  @override
  void initState() {
    super.initState();

    Provider.of<UserController>(context, listen: false).getUserFromShared();
    controller = FlutterGifController(vsync: this);

    _push();
  }

  _push() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                child: GifImage(
                  controller: controller,
                  image: AssetImage("assets/images/int.gif"),
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
