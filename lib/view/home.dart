import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _TelegramProfileState createState() => _TelegramProfileState();
}

class _TelegramProfileState extends State<HomePage> {
  double _appBarHeight = 200.0;
  double _avatarRadius = 60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            setState(() {
              _appBarHeight -= scrollNotification.scrollDelta!;
              _avatarRadius -= scrollNotification.scrollDelta! / 2;
            });
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: _appBarHeight,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://picsum.photos/id/237/200/300',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: _avatarRadius,
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/200',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'johndoe@gmail.com',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
