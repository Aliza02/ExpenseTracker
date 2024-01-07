import 'package:expensetracker/res/images.dart';
import 'package:expensetracker/screens/SignIn_SignUp/signin.dart';
import 'package:expensetracker/widgets/signin_signup_button.dart';
import 'package:expensetracker/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.signup,
                  cacheHeight: 1080,
                  cacheWidth: 1080,
                ),
                const textfield(hintText: 'Name'),
                SizedBox(height: Get.height * 0.02),
                const textfield(hintText: 'Email'),
                SizedBox(height: Get.height * 0.02),
                const textfield(hintText: 'Password'),
                SizedBox(height: Get.height * 0.02),
                const textfield(hintText: 'Confirm Password'),
                SizedBox(height: Get.height * 0.02),
                SizedBox(height: Get.height * 0.02),
                RichText(
                  text: TextSpan(
                    text: "Already have an Account? ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Get.width * 0.04,
                    ),
                    // style: DefaultTextStyle.of(context).style,
                    children: const [
                      TextSpan(
                        text: 'Sign in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Button(
                  buttonTitle: 'Sign Up',
                  onPressed: () {
                  
                  },
                ),
                SizedBox(height: Get.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
