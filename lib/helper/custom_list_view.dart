import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CustomListView extends StatefulWidget {
  CustomListView(
      {super.key,
      required this.onEnd,
      this.loadingWidget,
      required this.scrollDirection,
      required this.children});
  Future<void> Function() onEnd;
  Widget? loadingWidget;
  final Axis scrollDirection;
  List<Widget> children;
  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(listener);
  }

  void listener() async {
    if (controller.position.pixels >= controller.position.maxScrollExtent) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        await widget.onEnd();
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.removeListener(listener);
    controller.dispose();
  }

  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: widget.scrollDirection,
      controller: controller,
      children: [...widget.children, widget.loadingWidget ?? Container()],
    );
  }
}
