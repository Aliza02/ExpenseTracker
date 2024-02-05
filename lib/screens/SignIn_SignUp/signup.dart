import 'package:expensetracker/bloc/onboardingBloc/signupbloc/signup_bloc.dart';
import 'package:expensetracker/bloc/onboardingBloc/signupbloc/signup_events.dart';
import 'package:expensetracker/bloc/onboardingBloc/signupbloc/signup_states.dart';
import 'package:expensetracker/firebase_auth_methods/authentication_methods.dart';
import 'package:expensetracker/res/images.dart';
import 'package:expensetracker/screens/SignIn_SignUp/signin.dart';
import 'package:expensetracker/widgets/signin_signup_button.dart';
import 'package:expensetracker/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  void user() {
    print('print');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => SignUpBloc(),
        child: Scaffold(
          // resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.signup,
                    cacheHeight: 1080,
                    cacheWidth: 1080,
                  ),
                  textfield(
                    hintText: 'Name',
                    controller: name,
                  ),
                  SizedBox(height: Get.height * 0.02),
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
                  textfield(
                    hintText: 'Confirm Password',
                    controller: confirmPassword,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  SizedBox(height: Get.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an Account?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Get.width * 0.04,
                        ),
                      ),
                      SizedBox(width: Get.width * 0.01),
                      InkWell(
                        onTap: () {
                          Get.toNamed('/signin');
                        },
                        child: Text(
                          'SignIn',
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
                  BlocConsumer<SignUpBloc, SignUpStates>(
                      listener: (context, state) {
                    if (state is InvalidSignUpState) {
                      Get.showSnackbar(GetSnackBar(
                        title: 'Incorrect Input',
                        message: state.errorMessage,
                        duration: Duration(seconds: 2),
                      ));
                    } else if (state is SignUpLoadingState) {
                       UserSignup(
                        email: email.text,
                        name: name.text,
                        password: password.text,
                        confirmPassword: confirmPassword.text,
                      );

                      
                    }
                  }, builder: (context, state) {
                    if (state is InitialState || state is InvalidSignUpState || userCreated==false) {
                      return Button(
                        buttonTitle: 'Sign Up',
                        onPressed: () {
                          BlocProvider.of<SignUpBloc>(context)
                              .add(SignUpSubmitEvent(
                            name: name.text,
                            email: email.text,
                            password: password.text,
                            confirmPassword: confirmPassword.text,
                          ));
                        },
                      );
                    } 
                   
                     else {
                      return Container();
                    }
                  }),
                  SizedBox(height: Get.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
