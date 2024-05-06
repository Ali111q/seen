import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
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

class LoginView extends StatelessWidget {
  LoginView({super.key});
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
              Logo(
                width: 40.w(context),
              ),
              Container(
                height: 50,
              ),
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
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
                        title: 'login'.tr,
                        onTap: () {
                          controller.login();
                        },
                      ),
                      Container(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'forget_password'.tr,
                          style: MyStyles.normalOrangeText,
                        ),
                      ),
                      Container(
                        height: 10.h(context),
                      ),
                      Text(
                        'login_with'.tr,
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
                            'no_account'.tr,
                            style: MyStyles.normalText,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/register');
                            },
                            child: Text(
                              'register'.tr,
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

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.title, this.onTap});
  final void Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w(context),
        decoration: BoxDecoration(
            gradient: MyColors.buttonGradient,
            borderRadius: BorderRadius.circular(MyStyles.buttonBorderRadius)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            title,
            style: MyStyles.buttonTitleWhiteStyle,
          ),
        )),
      ),
    );
  }
}

class AuthField extends StatefulWidget {
  AuthField(
      {super.key,
      required this.hint,
      required this.isPassword,
      required this.controller,
      this.validator});
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  String? Function(String?)? validator;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword && !visible,
        validator: widget.validator,
        style: MyStyles.normalText,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      visible = !visible;
                    });
                  },
                  icon: Icon(
                    !visible ? Icons.visibility_off : Icons.visibility,
                    // size: ,
                  ),
                  color: Colors.white,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MyStyles.fieldBorderRadius),
            borderSide: BorderSide(
              color: MyColors.swatch.withOpacity(0.5),
              width: 3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MyStyles.fieldBorderRadius),
            borderSide: BorderSide(
              color: MyColors.swatch,
              width: 3,
            ),
          ),
          hintText: widget.hint,
          hintStyle: MyStyles.hintStyle,
        ),
      ),
    );
  }
}
