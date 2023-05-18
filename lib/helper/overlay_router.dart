import 'package:flutter/material.dart';

class OverlayRouter<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  OverlayRouter({required this.builder});

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
  
  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => throw UnimplementedError();
  
  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => throw UnimplementedError();
}
