
import 'package:flutter/material.dart';

class LikeAnimationPainter extends CustomPainter {
  final Animation<double> animation;

  LikeAnimationPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final paint = Paint()..color = Colors.red.withOpacity(0.5);

    canvas.drawCircle(center, radius, paint);

    final scale = animation.value;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scale, scale);
    canvas.translate(-center.dx, -center.dy);

    // Draw your animation here, for example, an icon or shape

    canvas.restore();
  }

  @override
  bool shouldRepaint(LikeAnimationPainter oldDelegate) => true;
}