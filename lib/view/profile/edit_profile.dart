import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:seen/controller/auth_controller.dart';
import 'package:seen/helper/image_picker.dart';
import 'package:seen/view/contact/contact.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProfileEditView extends StatelessWidget {
  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              // Save changes
              controller
                  .updateUserProfile(); // Example method to update user profile
              Get.back();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => GestureDetector(
                onTap: () async {
                  SaiImage? image = await SaiImagePicker.pickImage();
                  controller.setImage(image: image);
                },
                child: CircleAvatar(
                  backgroundImage: controller.profileImage.value == null
                      ? null
                      : FileImage(controller.profileImage.value!.image),
                  radius: 60,
                ),
              ),
            ),
            SizedBox(height: 20),
            ProfileEditField(
              controller: controller.nameController,
              title: 'Name',
              initialValue: controller.user.value!.name,
              onChanged: (value) {
                // Update name
                controller.user.update((user) {
                  user!.name = value;
                });
              },
            ),
            ProfileEditField(
              controller: controller.emailController,
              title: 'Email',
              initialValue: controller.user.value!.email,
              onChanged: (value) {
                // Update email
                controller.user.update((user) {
                  user!.email = value;
                });
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProfileEditField extends StatelessWidget {
  final String title;
  final String initialValue;
  final void Function(String) onChanged;
  final TextEditingController? controller;
  const ProfileEditField({
    this.controller,
    required this.title,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        // initialValue: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
