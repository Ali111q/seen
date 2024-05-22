import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:seen/common/helper/shared_helper.dart';
import 'package:seen/config/constants/assets.dart';
import 'package:seen/helper/image_picker.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../data/api/user_api.dart';
import '../data/model/user.dart' as myUser;
import '../widgets/loading.dart';

class AuthController extends GetxController {
  RxInt onBoardingIndex = 0.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  SharedHelper shared = SharedHelper();
  Rx<myUser.User?> user = Rx(null);
  Rx<SaiImage?> profileImage = Rx(null);
//
  final UserApi _userApi = UserApi();

  List<String> onBoardingImages = [
    'assets/png/1.jpg',
    'assets/png/2.png',
    'assets/png/3.png',
    'assets/png/4.png',
  ];
  List authIcons() => [
        if (Platform.isIOS)
          {
            'icon': Assets.apple,
            'function': signInWithApple,
          },
        // {'icon': Assets.facebook, 'function': signInWithFacebook},
        {
          'icon': Assets.google,
          'function': googleSignIn,
        },
      ];

  signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ],
    );
    showLoading(asyncFunction: () async {
      await loginWithSocial(credential);
    });
  }

  Future<void> loginWithSocial(
      AuthorizationCredentialAppleID credential) async {
    myUser.User? _user = await _userApi.social(
        email: credential.email ?? 'User.${Random().nextInt(100000)}@seen.com',
        name: credential.givenName ?? "user",
        userId: credential.userIdentifier);
    if (_user != null) {
      shared.saveUser(_user);
      this.user.value = _user;
      Get.offAndToNamed('/main');
    }
    print(credential.email);
  }

  void changeIndex(int index) {
    onBoardingIndex.value = index;
  }

  @override
  void onInit() async {
    super.onInit();
    await shared.initialize();
  }
  // auth requests
  //
  //
  //

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      showLoading(asyncFunction: () async {
        try {
          print(emailController.text);
          myUser.User? user = await _userApi.login(
              email: emailController.text, password: passwordController.text);
          if (user != null) {
            shared.saveUser(user);
            this.user.value = user;
            Get.offAndToNamed('/main');
          } else {
            print('error');
          }
        } catch (e) {
          print(e);
        }
      });
    }
  }

  Future<void> register() async {
    showLoading(asyncFunction: () async {
      myUser.User? user = await _userApi.register(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
          image: profileImage.value?.BASE64);
      if (user != null) {
        shared.saveUser(user);
        this.user.value = user;
        Get.offAndToNamed(
          '/main',
        );
      } else {
        print('error');
      }
    });
  }

  bool loginCheck() {
    user.value = shared.getUser();
    return shared.getUser() != null;
  }

  void logout() {
    shared.clear();
    user.value = null;
  }

  void setImage({SaiImage? image}) async {
    profileImage.value = image ?? await SaiImagePicker.pickImage();
  }

  void deleteAccount() async {
    await showLoading(asyncFunction: () async {
      await _userApi.deleteAccount();
    });
    Get.offAndToNamed(
      '/login',
    );
    await Future.delayed(Duration(seconds: 2));
    logout();
  }

  void googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final cards = await FirebaseAuth.instance.signInWithCredential(credential);
    showLoading(asyncFunction: () async {
      myUser.User? _user = await _userApi.social(
          email: cards.user?.email, name: cards.user?.displayName);
      if (_user != null) {
        shared.saveUser(_user);
        this.user.value = _user;
        Get.offAndToNamed('/main');
      }
    });
  }

  Future<UserCredential?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    if (loginResult.accessToken != null) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final ff = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      print(ff.user);

      return ff;
    }
  }

  Future<void> showLoading(
      {required Future<dynamic> Function() asyncFunction}) async {
    await Get.showOverlay(
        asyncFunction: asyncFunction, loadingWidget: LoadingWidget());
  }

  void updateUserProfile() {
    // showLoading(asyncFunction: () async {
    //   myUser.User? _user = await _userApi.updateProfile(
    //       name: nameController.text, image: profileImage.value?.BASE64);
    //   if (_user != null) {
    //     shared.saveUser(_user);
    //     this.user.value = _user;
    //     Get.back();
    //   }
    // });
    user.value = user.value!.copyWith(
      email:
          emailController.text == '' ? user.value!.email : emailController.text,
      name: nameController.text == '' ? null : nameController.text,
    );
  }
}
