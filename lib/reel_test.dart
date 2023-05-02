import 'package:flutter/material.dart';

class ReelsScroll extends StatefulWidget {
  // List<Widget> items;

  // ReelsScroll({super.key, required this.items});
  @override
  _ReelsScrollState createState() => _ReelsScrollState();
}

class _ReelsScrollState extends State<ReelsScroll> {
  PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        children: [
          Container(
            color: Colors.red,
            child: Center(
              child: Text("Page 1"),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Center(
              child: Text("Page 2"),
            ),
          ),
          Container(
            color: Colors.green,
            child: Center(
              child: Text("Page 3"),
            ),
          ),
        ],
      ),
    );
  }
}
