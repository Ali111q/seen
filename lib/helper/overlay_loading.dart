import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) return;

    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Container(
        color: Colors.black54,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

 //          showOverlayNotification((context, ) {
    //           // print(d);
    //   return Stack(
    //     children: [
          
    //       Positioned(
    //         // duration: Duration(milliseconds: 300),
    //       // bottom: 5,
    //           child: Container(
    //         child: Image.asset(
    //           'assets/images/loading resized.gif',
    //         ),
    //       )),
    //     ],
    //   );
    // }, );