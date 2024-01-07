import 'package:expensetracker/res/images.dart';
import 'package:expensetracker/widgets/signin_signup_button.dart';
import 'package:expensetracker/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => SigninState();
}

class SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.03),
              Image.asset(
                AppImages.signin,
                cacheHeight: 1080,
                cacheWidth: 1080,
              ),
              const textfield(hintText: 'Email'),
              SizedBox(height: Get.height * 0.02),
              const textfield(hintText: 'Password'),
              SizedBox(height: Get.height * 0.02),
              RichText(
                text: TextSpan(
                  text: "Dont't have an Account? ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Get.width * 0.04,
                  ),
                  // style: DefaultTextStyle.of(context).style,
                  children: const [
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Button(buttonTitle: 'Sign In', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
