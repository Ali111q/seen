import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seen/video.dart';

class jj extends StatelessWidget {
  const jj({super.key, required this.link});
  final link;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoPlayerWidget(context: context, link: link),
    );
  }
}
