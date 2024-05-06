import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:seen/config/style/colors.dart';
import 'package:seen/config/style/styles.dart';
import 'package:seen/config/validator/validators.dart';
import 'package:seen/controller/auth_controller.dart';
import 'package:seen/core/app_validator.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/widgets/logo.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../login/login.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 7.h(context),
              ),
              Obx(
                () => GestureDetector(
                  onTap: controller.setImage,
                  child: Container(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 11.w(context),
                          backgroundColor: controller.profileImage.value == null
                              ? MyColors.backGround
                              : null,
                          backgroundImage: controller.profileImage.value == null
                              ? null
                              : FileImage(controller.profileImage.value!.image),
                          child: controller.profileImage.value != null
                              ? null
                              : SvgPicture.asset('assets/svg/avatar.svg'),
                        ),
                        TextButton(
                          onPressed: controller.setImage,
                          child: Text(
                            'select_image'.tr,
                            style: MyStyles.miniOrangeText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
              ),
              Form(
                  key: controller.registerFormKey,
                  child: Column(
                    children: [
                      AuthField(
                        controller: controller.nameController,
                        isPassword: false,
                        hint: 'name'.tr,
                      ),
                      Container(
                        height: 20,
                      ),
                      AuthField(
                        validator: AppValidator.emailValidator,
                        controller: controller.emailController,
                        isPassword: false,
                        hint: 'email'.tr,
                      ),
                      Container(
                        height: 20,
                      ),
                      AuthField(
                        validator: AppValidator.passwordValidator,
                        controller: controller.passwordController,
                        isPassword: true,
                        hint: 'password'.tr,
                      ),
                      Container(
                        height: 60,
                      ),
                      AuthButton(
                        title: 'register'.tr,
                        onTap: () {
                          controller.register();
                        },
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 10.h(context),
                      ),
                      Text(
                        'register_with'.tr,
                        style: MyStyles.normalText,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: [
                          if (Platform.isIOS)
                            Container(
                              width: 80.w(context),
                              child: SignInWithAppleButton(
                                onPressed: controller.signInWithApple,
                                style: SignInWithAppleButtonStyle.white,
                              ),
                            ),
                          Container(
                            height: 19,
                          ),
                          Container(
                            width: 80.w(context),
                            child: SignInWithAppleButton(
                              logo: SvgPicture.asset(
                                'assets/svg/google.svg',
                                height: 10.w(context),
                              ),
                              text: 'Sign in with Google',
                              onPressed: controller.googleSignIn,
                              style: SignInWithAppleButtonStyle.white,
                            ),
                          ),
                        ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'have_account'.tr,
                            style: MyStyles.normalText,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/login');
                            },
                            child: Text(
                              'login'.tr,
                              style: MyStyles.normalOrangeText,
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
