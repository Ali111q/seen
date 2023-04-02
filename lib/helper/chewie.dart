// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
// import 'package:video_player/video_player.dart';

// class videoPlayer extends StatefulWidget {
//   const videoPlayer({super.key});

//   @override
//   State<videoPlayer> createState() => _videoPlayerState();
// }

// class _videoPlayerState extends State<videoPlayer> {
//   final IjkMediaController controller = IjkMediaController();
// await controller.setNetworkDataSource(
//   'http://example.com/my-video.m3u8',
//   autoPlay: true,
// );
//   @override
//   void initState() {
//     super.initState();
//     controller.initialize().then((_) {
//       controller.play();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     final qualities = [
//   {'name': 'Low', 'url': 'http://example.com/my-video-low.m3u8'},
//   {'name': 'Medium', 'url': 'http://example.com/my-video-medium.m3u8'},
//   {'name': 'High', 'url': 'http://example.com/my-video-high.m3u8'},

// ];
// void _changeQuality(int index) {
//   final quality = qualities[index];
//   final url = quality['url'];
//   controller.setQuality(
//     Resolution(
//       name: quality['name'],
//       source: url,
//     ),
//   );
// }
//     return Scaffold(
//       body: Center(
//         child: AspectRatio(
//           aspectRatio: controller.value.aspectRatio,
//           child: VideoPlayer(controller),
//         ),
//       ),
//     );
    
//   }
  
// }
