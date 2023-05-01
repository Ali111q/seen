import 'dart:ui';

import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
 TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  // Function to handle image picker
  Future<void> _pickImage() async {
    // TODO: Implement image picker logic
  }
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          SlideTransition(
            position: _offsetAnimation,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _controller.reverse();
                    },
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://seen-dorto.s3.amazonaws.com/thumbnail/1682878656seenthumbnail.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'John Doe',
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
                    onPressed: () {
                      // Logout functionality here
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      _controller.forward();
                    },
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  // SizedBox(height: 50.0),

                  // TextFields for name and email
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Button to pick image from gallery
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text(
                      'Pick Image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );  }

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
