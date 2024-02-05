import 'package:expensetracker/bloc/signinbloc/signin_bloc.dart';
import 'package:expensetracker/bloc/signinbloc/signin_events.dart';
import 'package:expensetracker/bloc/signinbloc/signin_states.dart';
import 'package:expensetracker/firebase_auth_methods/authentication_methods.dart';
import 'package:expensetracker/res/images.dart';
import 'package:expensetracker/widgets/signin_signup_button.dart';
import 'package:expensetracker/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => SigninState();
}

class SigninState extends State<Signin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => SignInBloc(),
        child: Scaffold(
         
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
                textfield(
                  hintText: 'Email',
                  controller: email,
                ),
                SizedBox(height: Get.height * 0.02),
                textfield(
                  hintText: 'Password',
                  controller: password,
                ),
                SizedBox(height: Get.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Get.width * 0.04,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.01),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/signup');
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.03),
                BlocConsumer<SignInBloc, SignInStates>(
                  listener: (context, state) {
                    if (state is InValidState) {
                      Get.showSnackbar(GetSnackBar(
                        message: state.errorMessage,
                        duration: const Duration(seconds: 2),
                      ));
                    } else if (state is SignInLoadingState) {
                      UserSignIn(email: email.text, password: password.text);
                    }
                  },
                  builder: (context, state) {
                    if (state is InitialState || state is InValidState) {
                      return Button(
                          buttonTitle: 'Sign In',
                          onPressed: () {
                            BlocProvider.of<SignInBloc>(context).add(
                              SignInSubmitEvents(
                                email: email.text,
                                password: password.text,
                              ),
                            );
                          });
                    } else if (state is SignInLoadingState) {
                      return SizedBox(
                        height: Get.height * 0.065,
                        width: Get.width * 0.9,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
