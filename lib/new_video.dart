// import 'dart:io';

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
// import 'package:provider/provider.dart';
// import 'package:seen/controller/home_controller.dart';
// import 'package:seen/model/ad.dart';

// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final BuildContext context;
//   final List link;
//   const VideoPlayerWidget(
//       {super.key, required this.context, required this.link});
//   @override
//   _ChewieDemoState createState() => _ChewieDemoState();
// }

// class _ChewieDemoState extends State<VideoPlayerWidget> {
//   bool showControls = false;
//   bool _isDragging = false;
//   bool isPlay = false;
//   VideoPlayerController? _videoPlayerController;
//   ChewieController? _chewieController;
//   bool isLoading = false;
//   String dragValue = '';
//   Duration _bufferedDuration = Duration.zero;
//   double _total_duration = 0.0;
//   int showAd = 0;
//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       isLoading = true;
//     });
    
//     FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     _videoPlayerController = VideoPlayerController.network(widget.link[2]);

//     _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController!,
//         autoPlay: true,
//         looping: true,
//         // showControls: false,
//         // fullScreenByDefault: true,
//         // customControls: Center(child: Text('sdads')),
//         aspectRatio: MediaQuery.of(widget.context).size.height /
//             MediaQuery.of(widget.context).size.width);
//     _videoPlayerController!.addListener(() {
//         if(_chewieController!.videoPlayerController.value.isBuffering)
//         {
//           print('object');
//           setState(() {
//           isLoading = true;
            
//           });
//         }else{
//           print('notObject');

//             setState(() {
//           isLoading = false;
            
//           });
//         }
//       setState(() {
//         _bufferedDuration = _videoPlayerController!.value.buffered.fold(
//             Duration.zero,
//             (previousValue, element) =>
//                 previousValue + (element.end - element.start));
//       });
//       final position = _videoPlayerController!.value.position;
//       setState(() {
//         showAd = _videoPlayerController!.value.position.inSeconds < 15 &&
//                 _videoPlayerController!.value.position.inSeconds > 10 &&
//                 showAd == 0
//             ? 1
//             : 0;
//         _total_duration =
//             _videoPlayerController!.value.duration.inMilliseconds.toDouble();
//       });
//     });
//     setState(() {});
//     Provider.of<HomeController>(context, listen: false).getAdInVideo();
//   }

//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     _videoPlayerController?.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Ad? ad = Provider.of<HomeController>(context).adInVideo;
//     List qualities = [
//       ListTile(
//         textColor: Colors.white,
//         title: Text('480'),
//             onTap: () async {
//           bool isFirst = true;
//           Duration? time = await _videoPlayerController!.position;
//           _videoPlayerController!.dispose();
//           _videoPlayerController =
//               VideoPlayerController.network(widget.link[0]);
//           if (_videoPlayerController!.value.isPlaying) {
//             _chewieController!.pause();
//           }
//           _chewieController!.dispose();
//           var _newChewieController = ChewieController(
//               videoPlayerController: _videoPlayerController!,
//               autoPlay: true,
//               looping: true,
//               showControls: false,
//               aspectRatio: MediaQuery.of(widget.context).size.width /
//                   MediaQuery.of(widget.context).size.height);

//           setState(() {
//             _chewieController = _newChewieController;
//           });
//           print(time);

//           _videoPlayerController!.addListener(() {
//             setState(() {
//               _bufferedDuration = _videoPlayerController!.value.buffered.fold(
//                   Duration.zero,
//                   (previousValue, element) =>
//                       previousValue + (element.end - element.start));
//             });
//             final position = _videoPlayerController!.value.position;
//             setState(() {
//               showAd = _videoPlayerController!.value.position.inSeconds < 15 &&
//                       _videoPlayerController!.value.position.inSeconds > 10 &&
//                       showAd == 0
//                   ? 1
//                   : 0;
//               _total_duration = _videoPlayerController!
//                   .value.duration.inMilliseconds
//                   .toDouble();
//               if (isFirst &&
//                   _chewieController!
//                       .videoPlayerController.value.isInitialized) {
//                 print(time);
//                 setState(() {
//                   _chewieController!.videoPlayerController.seekTo(time!);
//                   isFirst = false;
//                 });
//               }
//             });
//           });
//           Navigator.of(context).pop();
//         },
//       ),
//       ListTile(
//         textColor: Colors.white,
//         title: Text('720'),
//             onTap: () async {
//           bool isFirst = true;
//           Duration? time = await _videoPlayerController!.position;
//           _videoPlayerController!.dispose();
//           _videoPlayerController =
//               VideoPlayerController.network(widget.link[1]);
//           if (_videoPlayerController!.value.isPlaying) {
//             _chewieController!.pause();
//           }
//           _chewieController!.dispose();
//           var _newChewieController = ChewieController(
//               videoPlayerController: _videoPlayerController!,
//               autoPlay: true,
//               looping: true,
//               showControls: false,
//               aspectRatio: MediaQuery.of(widget.context).size.width /
//                   MediaQuery.of(widget.context).size.height);

//           setState(() {
//             _chewieController = _newChewieController;
//           });
//           print(time);

//           _videoPlayerController!.addListener(() {
//             setState(() {
//               _bufferedDuration = _videoPlayerController!.value.buffered.fold(
//                   Duration.zero,
//                   (previousValue, element) =>
//                       previousValue + (element.end - element.start));
//             });
//             final position = _videoPlayerController!.value.position;
//             setState(() {
//               showAd = _videoPlayerController!.value.position.inSeconds < 15 &&
//                       _videoPlayerController!.value.position.inSeconds > 10 &&
//                       showAd == 0
//                   ? 1
//                   : 0;
//               _total_duration = _videoPlayerController!
//                   .value.duration.inMilliseconds
//                   .toDouble();
//               if (isFirst &&
//                   _chewieController!
//                       .videoPlayerController.value.isInitialized) {
//                 print(time);
//                 setState(() {
//                   _chewieController!.videoPlayerController.seekTo(time!);
//                   isFirst = false;
//                 });
//               }
//             });
//           });
//           Navigator.of(context).pop();
//         },
//       ),
//       ListTile(
//         textColor: Colors.white,
//         title: Text('1080'),
//         onTap: () async {
//           bool isFirst = true;
//           Duration? time = await _videoPlayerController!.position;
//           _videoPlayerController!.dispose();
//           _videoPlayerController =
//               VideoPlayerController.network(widget.link[2]);
//           if (_videoPlayerController!.value.isPlaying) {
//             _chewieController!.pause();
//           }
//           _chewieController!.dispose();
//           var _newChewieController = ChewieController(
//               videoPlayerController: _videoPlayerController!,
//               autoPlay: true,
//               looping: true,
//               showControls: false,
//               aspectRatio: MediaQuery.of(widget.context).size.width /
//                   MediaQuery.of(widget.context).size.height);

//           setState(() {
//             _chewieController = _newChewieController;
//           });
//           print(time);

//           _videoPlayerController!.addListener(() {
//             setState(() {
//               _bufferedDuration = _videoPlayerController!.value.buffered.fold(
//                   Duration.zero,
//                   (previousValue, element) =>
//                       previousValue + (element.end - element.start));
//             });
//             final position = _videoPlayerController!.value.position;
//             setState(() {
//               showAd = _videoPlayerController!.value.position.inSeconds < 15 &&
//                       _videoPlayerController!.value.position.inSeconds > 10 &&
//                       showAd == 0
//                   ? 1
//                   : 0;
//               _total_duration = _videoPlayerController!
//                   .value.duration.inMilliseconds
//                   .toDouble();
//               if (isFirst &&
//                   _chewieController!
//                       .videoPlayerController.value.isInitialized) {
//                 print(time);
//                 setState(() {
//                   _chewieController!.videoPlayerController.seekTo(time!);
//                   isFirst = false;
//                 });
//               }
//             });
//           });
//           Navigator.of(context).pop();
//         },
//       )
//     ];
//     List speeds = [
//       ListTile(
//         textColor: Colors.white,
//         title: Text('0.50'),
//         onTap: () {
//           _videoPlayerController!.setPlaybackSpeed(0.5);
//           Navigator.of(context).pop();
//         },
//       ),
//       ListTile(
//         textColor: Colors.white,
//         title: Text('1.0'),
//         onTap: () {
//           _videoPlayerController!.setPlaybackSpeed(1.0);
//           Navigator.of(context).pop();
//         },
//       ),
//       ListTile(
//         textColor: Colors.white,
//         title: Text('1.5'),
//         onTap: () {
//           _videoPlayerController!.setPlaybackSpeed(1.5);
//           Navigator.of(context).pop();
//         },
//       ),
//       ListTile(
//         textColor: Colors.white,
//         title: Text('2.0'),
//         onTap: () {
//           _videoPlayerController!.setPlaybackSpeed(2.0);
//           Navigator.of(context).pop();
//         },
//       )
//     ];
//     return Container(
//       child: GestureDetector(
//         onTap: showControlsFunction,
//         child: Stack(
//           children: [
//             Chewie(controller: _chewieController!),
//             AnimatedContainer(
//               duration: Duration(milliseconds: 100),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: showControls
//                   ? Colors.black.withOpacity(0.2)
//                   : Colors.transparent,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: AnimatedOpacity(
//                   opacity: showControls ? 1.0 : 0.0,
//                   duration: Duration(milliseconds: 100),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           IconButton(
//                             onPressed: showControls
//                                 ? () {
//                                     showModalBottomSheet(
//                                         context: context,
//                                         builder: (context) {
//                                           return BottomSheet(
//                                               backgroundColor:
//                                                   Color(0xff0B0E19),
//                                               onClosing: () {},
//                                               builder: (context) {
//                                                 return ListView(
//                                                   children: [
//                                                     ExpansionTile(
//                                                       title: Text(
//                                                         'quality',
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.white),
//                                                       ),
//                                                       textColor: Colors.white,
//                                                       collapsedIconColor:
//                                                           Colors.white,
//                                                       children: [
//                                                         ...qualities
//                                                             .map((e) => e)
//                                                       ],
//                                                     ),
//                                                     ExpansionTile(
//                                                       title: Text(
//                                                         'show speed',
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.white),
//                                                       ),
//                                                       textColor: Colors.white,
//                                                       collapsedIconColor:
//                                                           Colors.white,
//                                                       children: [
//                                                         ...speeds.map((e) => e)
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 );
//                                               });
//                                         });
//                                   }
//                                 : null,
//                             icon: Icon(
//                               Icons.settings,
//                               color: Colors.white,
//                               size: 30,
//                             ),
//                           ),
//                           Spacer(),
//                           IconButton(
//                               onPressed: showControls
//                                   ? () {
//                                       Navigator.of(context).pop();
//                                     }
//                                   : null,
//                               icon: Icon(
//                                 Icons.close,
//                                 color: Colors.white,
//                               ))
//                         ],
//                       ),
//                       Spacer(),
//                       Center(
//                         child: !_videoPlayerController!.value.isInitialized &&
//                                 !_videoPlayerController!.value.isBuffering
//                             ? CircularProgressIndicator(
//                                 color: Colors.white,
//                               )
//                             : _isDragging
//                                 ? Text(
//                                     dragValue,
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 30,
//                                         shadows: [Shadow()]),
//                                   )
//                                 : Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       GestureDetector(
//                                         child: IconButton(
//                                           onPressed: showControls
//                                               ? () async {
//                                                   _videoPlayerController!.seekTo(
//                                                       (await _videoPlayerController!
//                                                               .position)! -
//                                                           const Duration(
//                                                               seconds: 5));
//                                                   setState(() {});
//                                                 }
//                                               : null,
//                                           icon: Icon(Icons.replay_5_sharp),
//                                           iconSize: 60,
//                                           color: Colors.white.withOpacity(0.6),
//                                         ),
//                                       ),
//                                       Container(
//                                         width: 20,
//                                       ),
//                                      if(!isLoading)  
//                                       GestureDetector(
//                                         onTap: showControls
//                                             ? () {
//                                                 setState(() {
//                                                   isPlay = !isPlay;
//                                                 });
//                                                 if (isPlay) {
//                                                   _videoPlayerController!
//                                                       .pause();
//                                                 } else {
//                                                   _videoPlayerController!
//                                                       .play();
//                                                 }
//                                               }
//                                             : null,
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               color:
//                                                   Colors.grey.withOpacity(0.6),
//                                               shape: BoxShape.circle),
//                                           child: isPlay
//                                               ? Icon(
//                                                   Icons.play_arrow,
//                                                   size: 80,
//                                                   color: Colors.black
//                                                       .withOpacity(0.6),
//                                                 )
//                                               : Icon(
//                                                   Icons.pause_sharp,
//                                                   size: 80,
//                                                   color: Colors.black
//                                                       .withOpacity(0.6),
//                                                 ),
//                                         ),
//                                       ),
//                                       Container(
//                                         width: 20,
//                                       ),
//                                       GestureDetector(
//                                         child: IconButton(
//                                           onPressed: showControls
//                                               ? () async {
//                                                   _videoPlayerController!.seekTo(
//                                                       (await _videoPlayerController!
//                                                               .position)! +
//                                                           const Duration(
//                                                               seconds: 5));
//                                                   setState(() {});
//                                                 }
//                                               : null,
//                                           icon: Icon(Icons.forward_5_rounded),
//                                           iconSize: 60,
//                                           color: Colors.white.withOpacity(0.6),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                       ),
//                       Spacer(),
//                       Container(
//                         height: 20,
//                       ),
//                       _buildProgressBar()
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             ad == null
//                 ? Container()
//                 : AnimatedPositioned(
//                     duration: Duration(milliseconds: 1000),
//                     left: showAd == 1 ? 60 : -800,
//                     bottom: 60,
//                     child: Align(
//                       alignment: Alignment.bottomLeft,
//                       child: GestureDetector(
//                         onHorizontalDragEnd: (e) {
//                           setState(() {
//                             showAd = 2;
//                           });
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(left: 20),
//                           width: MediaQuery.of(context).size.width * 0.22,
//                           height: MediaQuery.of(context).size.width * 0.026,
//                           color: Colors.white,
//                           child: Image.network(
//                             ad!.file,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
          
//           if(isLoading)Center(
//             child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                 ),
//           )
//           ],
//         ),
//       ),
//       // child: Container(),
//     );
//   }

//   showControlsFunction() async {
//     if (showControls) {
//       setState(() {
//         SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
//         showControls = false;
//       });
//     } else {
//       setState(() {
//         SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

//         showControls = true;
//       });
//       await Future.delayed(Duration(seconds: 7));
//       setState(() {
//         SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

//         showControls = false;
//       });
//     }
//   }

//   Widget _buildProgressBar() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Row(
//           children: [
//             SizedBox(width: 12.0),
//             Text(
//               _durationToString(_videoPlayerController!.value.position),
//               style: TextStyle(color: Colors.white),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12.0),
//                 child: _buildSlider(),
//               ),
//             ),
//             Text(
//               _durationToString(_videoPlayerController!.value.duration- _videoPlayerController!.value.position, isFull:''),
//               style: TextStyle(color: Colors.white),
//             ),
//             SizedBox(width: 12.0),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildSlider() {
//     return SliderTheme(
//       data: SliderThemeData(
//         trackShape: CustomTrackShape(),
//         thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
//         overlayShape: RoundSliderOverlayShape(overlayRadius: 16.0),
//       ),
//       child: Slider(
//         value: _videoPlayerController!.value.position.inMilliseconds.toDouble(),
//         min: 0.0,
//         max: _total_duration,
//         onChanged: (value) {
//           setState(() {
//             _isDragging = true;
//             dragValue =
//                 _durationToString(Duration(milliseconds: value.toInt()));
//             _videoPlayerController!.seekTo(
//               Duration(milliseconds: value.toInt()),
//             );
//           });
//         },
//         onChangeEnd: (value) {
//           setState(() {
//             _isDragging = false;
//           });
//           _videoPlayerController!.seekTo(
//             Duration(milliseconds: value.toInt()),
//           );
//         },
//         secondaryTrackValue:
//             _bufferedDuration.inMilliseconds.toDouble() > _total_duration
//                 ? _total_duration
//                 : _bufferedDuration.inMilliseconds.toDouble(),
//         activeColor: Colors.white,
//         inactiveColor: Colors.grey.withOpacity(0.5),
//         secondaryActiveColor: Colors.white,
//       ),
//     );
//   }
// }

// class CustomTrackShape extends RoundedRectSliderTrackShape {
//   Rect getPreferredRect({
//     required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     required SliderThemeData sliderTheme,
//     bool isEnabled = false,
//     bool isDiscrete = false,
//   }) {
//     final trackHeight = sliderTheme.trackHeight!;
//     final trackLeft = offset.dx + 24.0;
//     final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
//     final trackWidth = parentBox.size.width - 48.0;
//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
//   }
// }

// String _durationToString(Duration duration, {String? isFull}) {
//   if (isFull !=null) {
    
//   if(duration.inHours == 0){
//     return '-'+
//     duration.inMinutes.remainder(60).toString().padLeft(2, '0') +
//       ':' +
//       duration.inSeconds.remainder(60).toString().padLeft(2, '0');}else{
//  return'-'+
//  duration.inHours.remainder(60).toString().padLeft(1, '0') +
//       ':' +
//     duration.inMinutes.remainder(60).toString().padLeft(2, '0') +
//       ':' +
//       duration.inSeconds.remainder(60).toString().padLeft(2, '0');
//       }
//   }else{
//       if(duration.inHours == 0){
//     return
//     duration.inMinutes.remainder(60).toString().padLeft(2, '0') +
//       ':' +
//       duration.inSeconds.remainder(60).toString().padLeft(2, '0');}else{
//  return
//  duration.inHours.remainder(60).toString().padLeft(1, '0') +
//       ':' +
//     duration.inMinutes.remainder(60).toString().padLeft(2, '0') +
//       ':' +
//       duration.inSeconds.remainder(60).toString().padLeft(2, '0');
//       }
//   }
  
// }
