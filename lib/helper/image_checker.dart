import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seen/helper/loading.dart';

class NetworkImageChecker extends StatefulWidget {
  final String imageUrl;
  bool ImageLoaded = false;
  NetworkImageChecker({required this.imageUrl});

  @override
  _NetworkImageCheckerState createState() => _NetworkImageCheckerState();
}

class _NetworkImageCheckerState extends State<NetworkImageChecker> {
  bool _isLoading = true;
  bool _isError = false;

  void _checkImageStatus(ImageProvider provider) async {
    final imageStream = provider.resolve(ImageConfiguration.empty);
    imageStream.addListener(ImageStreamListener((imageInfo, _) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          widget.ImageLoaded =true;
          _isError = false;
        });
      }
    }, onError: (_, __) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          widget.ImageLoaded =false;
          _isError = true;
        });
      }
    }));
  }

  @override
  void initState() {
    super.initState();
    _checkImageStatus(NetworkImage(widget.imageUrl));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Loading();
    } else if (_isError) {
      return Loading();
    } else {
      return CachedNetworkImage( imageUrl: widget.imageUrl, fit: BoxFit.fitHeight,);
    }
  }
}

