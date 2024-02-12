import 'dart:ui';
import 'package:expensetracker/bloc/onboardingBloc/onboarding_bloc.dart';
import 'package:expensetracker/bloc/onboardingBloc/onboarding_events.dart';
import 'package:expensetracker/bloc/onboardingBloc/onboarding_states.dart';
import 'package:expensetracker/model/onboarding_model.dart';
import 'package:expensetracker/res/colors.dart';
import 'package:expensetracker/res/images.dart';
import 'package:expensetracker/screens/SignIn_SignUp/signin.dart';
import 'package:expensetracker/screens/SignIn_SignUp/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  List<OnBoardingModel> onboardingData = [
    OnBoardingModel(
        image: AppImages.page1Image,
        title: 'Effortless Transaction Entry',
        description:
            "Log your expenses in seconds with our user-friendly interface. Simply enter the amount, select a category, and you're good to go!"),
    OnBoardingModel(
        image: AppImages.page2Image,
        title: "Categorized Spending",
        description:
            "Easily categorize your expenses to gain insights into where your money is going. We've got predefined categories, or you can create custom ones."),
    OnBoardingModel(
        image: AppImages.page3Image,
        title: "Real-Time Analytics",
        description:
            "Explore visual reports and analytics to track your spending patterns over time. Understand your habits and make informed financial decisions.")
  ];

  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  _storedonBoaredInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('onboard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
            controller: pageController,
            itemCount: onboardingData.length,
            onPageChanged: (value) {
              // print(value);
              if (value == onboardingData.length - 1) {
                BlocProvider.of<OnboardingBloc>(context).add(LastPageEvent());
              } else {
                BlocProvider.of<OnboardingBloc>(context).add(InitialEvent());
              }
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  BlocBuilder<OnboardingBloc, OnboardingStates>(
                    builder: (context, state) {
                      if (state is LastPageState) {
                        return Container();
                      } else {
                        return Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(
                            top: Get.height * 0.02,
                            right: Get.width * 0.03,
                          ),
                          child: InkWell(
                            onTap: () {
                              _storedonBoaredInfo();
                              pageController
                                  .jumpToPage(onboardingData.length - 1);
                            },
                            child: Text(
                              'skip',
                              style: TextStyle(
                                fontSize: Get.width * 0.04,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: Get.height * 0.04,
                    ),
                    child: Image.asset(
                      onboardingData[index].image,
                      cacheHeight: 1080,
                      cacheWidth: 1080,
                      height: 400,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: Get.height * 0.02,
                    ),
                    child: Text(
                      onboardingData[index].title,
                      style: TextStyle(
                        fontSize: Get.width * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width * 0.9,
                    margin: EdgeInsets.only(
                      top: Get.height * 0.01,
                    ),
                    child: Text(
                      onboardingData[index].description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Get.width * 0.043,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  BlocBuilder<OnboardingBloc, OnboardingStates>(
                    builder: (context, states) {
                      if (states is LastPageState) {
                        return Container(
                          margin: EdgeInsets.only(
                            top: Get.height * 0.025,
                          ),
                          height: Get.height * 0.08,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // backgroundColor: Gradient.linear(from, to, colors)
                              backgroundColor: AppColors.onboardingButtonColor,
                            ),
                            onPressed: () {
                              _storedonBoaredInfo();
                              Get.to(() => Signup());
                            },
                            child: Text(
                              'Start Managing your Expenses',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.045,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }
}
