import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seen/like_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'ad_video.dart';
import 'model/ad.dart';

class ContentScreen extends StatefulWidget {
  final String? src;
  Ad ad;

  ContentScreen({Key? key, this.src, required this.ad}) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _playing = true;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

 Future<void> initializePlayer() async {
    print(widget.src);
    // final cachedVideoPath = await cacheNetworkVideo(widget.src!);

    _videoPlayerController = VideoPlayerController.network(widget.ad.file);
    // await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      autoInitialize: true,
      looping: true,
    );
    _videoPlayerController.addListener(() { if (_videoPlayerController.value.isInitialized) {
    setState(() {});
      
    }});
    _chewieController!.setVolume(0);

  }
    Future<String> cacheNetworkVideo(String videoUrl) async {
    final videoCacheManager = CacheManager(Config('cacheCustomkey',
        stalePeriod: const Duration(hours: 4), maxNrOfCacheObjects: 100));
    final file = await videoCacheManager.getSingleFile(videoUrl, );
    return file.path;
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.ad.local_title,
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.ad.local_description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
        _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Hero(
              tag: widget.ad.id.toString(),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: GestureDetector(
                    onTap: () {
                      if (_videoPlayerController.value.isInitialized) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoScreen(
                              tag: widget.ad.id.toString(),
                              videoPlayerController:
                                  _chewieController!.videoPlayerController,
                              name: widget.ad.local_title,
                            ),
                          ),
                        );
                      }
                    },
                    child: Stack(
                      children: [
                        Chewie(
                          controller: _chewieController!,
                        ),
                        Positioned(
                          child: VideoProgressIndicator(_chewieController!.videoPlayerController,
                              allowScrubbing: false),
                        ),
                        if (!_playing)
                          Center(
                            child: Icon(
                              Icons.play_arrow,
                              size: 44,
                              color: Colors.white,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
            )
            : Image.network(
                widget.ad.thumbnail!,
                // height: MediaQuery.of(context).size.height * 0.4,
              ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              if (widget.ad.website != null || widget.ad.instagram != null)
                GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse(
                          widget.ad.website ?? widget.ad.instagram ?? ''));
                    },
                    child: SvgPicture.asset('assets/images/website.svg')),
              Container(
                width: 20,
              ),
              if (widget.ad.lat != null && widget.ad.lng != null)
                GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse(
                          'https://www.google.com/maps/search/?api=1&query=${widget.ad.lat},${widget.ad.lng}'));
                    },
                    child: SvgPicture.asset('assets/images/marker.svg')),
              Spacer(),
              Text(
                widget.ad.local_sub_title,
                style: TextStyle(color: Colors.white, fontSize: 26),
              )
            ],
          ),
        ),
      ],
    );
  }
}
