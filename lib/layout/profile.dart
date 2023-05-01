import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/user_controller.dart';
import 'package:seen/layout/edit_profile.dart';
import 'package:seen/model/user.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user2 = Provider.of<UserController>(context).user!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(   
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://seen-dorto.s3.amazonaws.com/thumbnail/1682878656seenthumbnail.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                user2.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'johndoe@example.com',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  // Logout functionality here
                },
                
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              // ElevatedButton(
              //   onPressed: () {
              //     // Edit profile functionality here
              //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfile()));
              //   },
                
              //   child: Text(
              //     'Edit Profile',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 18.0,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Stack(
      children: [
        Image.network(
          'https://seen-dorto.s3.amazonaws.com/thumbnail/1682878656seenthumbnail.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ],
    );
  }
}
