import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final String name;
  final String tag;

  VideoScreen({
    required this.videoPlayerController,
    required this.name,
    required this.tag,
  });

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;
  bool _isPlaying = true;
  double _currentSliderValue = 0.0;
  bool _isFullScreen = false;
  bool _showControllers = false;

void setStateIfMounted(f){
  if (this.mounted) {
    setState(f);
  }
}
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    _videoPlayerController = widget.videoPlayerController;
    _videoPlayerController.setVolume(5);
    _videoPlayerController.addListener(() { 
      setStateIfMounted(() {
        _currentSliderValue = _videoPlayerController.value.position.inSeconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _videoPlayerController.setVolume(0);

  }

  void _togglePlay() {
    setStateIfMounted(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _videoPlayerController.play();
      } else {
        _videoPlayerController.pause();
      }
    });
  }





  void _onSliderChanged(double value) {
    setStateIfMounted(() {
      _currentSliderValue = value;
      final Duration duration = _videoPlayerController.value.duration;
      final newPosition = duration * value;
      _videoPlayerController.seekTo(newPosition);
    });
  }

  void _toggleFullScreen() {
    setStateIfMounted(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double aspectRatio = _videoPlayerController.value.aspectRatio;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _isFullScreen?null: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Hero(
          tag: widget.tag,
          child: Stack(
            children: [
              GestureDetector(
                onTap: ()async{
                  if (_showControllers) {
                    setState(() {
                  _showControllers = false;
                });
                  }else{

                  setState(() {
                    _showControllers = true;
                  });
                  }
                  await Future.delayed(Duration(seconds: 4));
                setState(() {
                  _showControllers = false;
                });
                
                },
                child: AspectRatio(
                  aspectRatio: aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: _showControllers?1:0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    
                        IconButton(
                          onPressed: _togglePlay,
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                          color: Colors.white,
                        ),
              
                        Expanded(
                          child: VideoProgressIndicator(_videoPlayerController, allowScrubbing: true
                          )
                        ),
                        IconButton(
                          onPressed: _toggleFullScreen,
                          icon: Icon(
                            _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                          ),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
