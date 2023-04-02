import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seen/video.dart';

class jj extends StatelessWidget {
  const jj({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoPlayerWidget(
        videoUrl:
            'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8',
      ),
    );
  }
}
