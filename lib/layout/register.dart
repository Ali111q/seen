import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/user_controller.dart';
import 'package:seen/layout/login.dart';
import "../utils//colors.dart" as myColors;

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(color: Color(0xffA8A8A8))),
                  child: Icon(
                    Icons.person,
                    color: Color(0xffA8A8A8),
                    size: 80,
                  )),
              Text(
                'رفع صورة',
                style: TextStyle(color: Color(0xffA8A8A8)),
              ),
              Container(
                height: 30,
              ),
              MyTextField(
                w: w,
                controller: email,
                hint: 'البريد الالكتروني',
              ),
              Container(
                height: 30,
              ),
              MyTextField(
                w: w,
                controller: name,
                hint: 'الاسم',
              ),
              Container(
                height: 30,
              ),
              MyTextField(
                w: w,
                controller: password,
                hint: 'كلمة السر',
              ),
              Container(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  print('object');
                  Provider.of<UserController>(context, listen: false)
                      .register(email.text, name.text, password.text);
                },
                child: ProfileButton(
                  w: w,
                  color: myColors.liteBlue,
                  child: Text(
                    'انشاء',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                height: 30,
              ),
              SvgPicture.asset(
                'assets/images/seen.svg',
                width: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.w,
      required this.controller,
      required this.hint});

  final double w;
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        textAlign: TextAlign.right,
        controller: controller,
        style: TextStyle(color: myColors.grey, fontSize: w * 0.05),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xffA8A8A8)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.transparent)),
        ),
      ),
    );
  }
}