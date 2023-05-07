import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _OpacityAnimationState createState() => _OpacityAnimationState();
}

class _OpacityAnimationState extends State<LaunchScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    // Create the animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
    

        child: Image.asset('assets/images/loading.gif', fit: BoxFit.fitWidth,),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
