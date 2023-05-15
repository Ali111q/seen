import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seen/controller/user_controller.dart';
import 'package:seen/helper/image_checker.dart';
import 'package:seen/layout/login.dart';
import 'package:seen/model/user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserController>(context).user!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () async {
                if (!isEditing) {
                  setState(() {
                    isEditing = true;
                    _name.text = user.name;
                  });
                } else {
                  await Provider.of<UserController>(context, listen: false)
                      .editProfile(_name.text);
                  setState(() {
                    isEditing = false;
                  });
                }
              },
              child: Text(
                isEditing ? 'حفظ' : 'تعديل',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(user),
          Center(
            child: isEditing
                ? _buildEditProfileForm(user)
                : _buildProfileInfo(user),
          )
        ],
      ),
    );
  }

  Widget _buildProfileInfo(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(user.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          user.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          user.email,
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
            Provider.of<UserController>(context, listen: false)
                .logout()
                .then((value) async {
              Navigator.of(context).pop();
            });
          },
          child: Text(
            'تسجيل خروج',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditProfileForm(User user) {
    Map? image = Provider.of<UserController>(context).image;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // TODO: Add form fields for editing profile data
        // Example: TextFields, ImagePicker, etc.
        GestureDetector(
          onTap: () {
            Provider.of<UserController>(context, listen: false).pickImage();
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: Color(0xffA8A8A8))),
            child: image != null
                ? CircleAvatar(
                    backgroundImage: FileImage(image['file']),
                    radius: MediaQuery.of(context).size.width * 0.13,
                  )
                : Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(user.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        InputLogin(
            controller: _name,
            w: MediaQuery.of(context).size.width,
            pass: false),
      ],
    );
  }

  Widget _buildBackgroundImage(User user) {
    return Stack(
      children: [
        NetworkImageChecker(
          imageUrl: user.image,
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
