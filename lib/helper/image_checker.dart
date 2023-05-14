import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:seen/helper/loading.dart';

class NetworkImageChecker extends StatefulWidget {
  final String imageUrl;
  bool imageLoaded = false;
  NetworkImageChecker({required this.imageUrl});

  @override
  _NetworkImageCheckerState createState() => _NetworkImageCheckerState();
}

class _NetworkImageCheckerState extends State<NetworkImageChecker> {
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _checkImageStatus();
  }

  void _checkImageStatus() {
    final imageStream = CachedNetworkImageProvider(widget.imageUrl)
        .resolve(ImageConfiguration.empty);
    imageStream.addListener(
      ImageStreamListener(
        (imageInfo, _) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              widget.imageLoaded = true;
              _isError = false;
            });
          }
        },
        onError: (_, __) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              widget.imageLoaded = false;
              _isError = true;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Loading();
    } else if (_isError) {
      return Loading();
    } else {
      return CachedNetworkImage(
        imageUrl: widget.imageUrl,
        fit: BoxFit.fitHeight,
      );
    }
  }
}
