import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../controlller/user_controller.dart';
import "../utils//colors.dart" as myColors;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<UserController>(context).isLogin) {
      Navigator.pushReplacementNamed(
        context,
        '/home',
      );
    }
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [myColors.firstBackGround, myColors.sceondBackGround],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            toolbarHeight: h * 0.15,
            title: Icon(
              Icons.abc,
              size: w * 0.33,
            ),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputLogin(
                w: w,
                controller: email,
              ),
              SizedBox(
                height: 25,
              ),
              InputLogin(
                w: w,
                controller: password,
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  print('object');
                  Provider.of<UserController>(context, listen: false)
                      .login(email.text, password.text);
                },
                child: ProfileButton(
                  w: w,
                  color: myColors.liteBlue,
                  child: LoginWidget(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'انشاء حساب',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'تسجيل بواسطة',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              ProfileButton(
                  w: w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Gmail',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset('assets/images/gmail.svg')
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              ProfileButton(
                  w: w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('facebook',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 27,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'font')),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 22.0, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'التسجيل لاحقا',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class ProfileButton extends StatelessWidget {
  ProfileButton({super.key, required this.w, required this.child, this.color});

  final double w;
  final Widget child;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: w * 0.15,
      width: w * 0.8,
      child: Material(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        elevation: 3,
        child: Center(child: child),
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'تسجيل الدخول',
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    );
  }
}

class InputLogin extends StatelessWidget {
  const InputLogin({
    required this.controller,
    super.key,
    required this.w,
  });

  final double w;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: w * 0.15,
          width: w * 0.8,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(113, 11, 14, 25),
                spreadRadius: 1.0,
                blurRadius: 20.0,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(color: myColors.grey, fontSize: w * 0.05),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
          ),
        ),
      ],
    );
  }
}
