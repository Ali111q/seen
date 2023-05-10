import 'package:flutter/material.dart';

class ReelsScroll extends StatefulWidget {
  List<Widget> items;
  int index = 0;
  ReelsScroll({super.key, required this.items});

  dispose(int e, context) {}
  initialize(int e, context) {}
  void initState() {}
  @override
  _ReelsScrollState createState() => _ReelsScrollState();
}

class _ReelsScrollState extends State<ReelsScroll> {
  PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: PageView(
          controller: _controller,
          onPageChanged: (int e) async {
            print('#########################################');
            print(widget.index);
            print('#########################################');

            await widget.dispose(widget.index, context);
            print(widget.index);
            print('#########################################');

            setState(() {
              widget.index = e;
            });
            print(widget.index);
            print('#########################################');

            await widget.initialize(widget.index, context);
            print(widget.index);
            print('#########################################');
          },
          scrollDirection: Axis.vertical,
          children: widget.items),
    );
  }
}
