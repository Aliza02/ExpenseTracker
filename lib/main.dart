import 'package:expensetracker/bloc/onboardingBloc/onboarding_bloc.dart';
import 'package:expensetracker/screens/SignIn_SignUp/signin.dart';
import 'package:expensetracker/screens/onboarding/onboarding_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Route GeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return GetPageRoute(
          page: () => const OnboardingScreens(),
          settings: settings,
          
        );
        case '/signin':
        return GetPageRoute(
          page: () => const Signin(),
          settings: settings,
          
        );
        case '/signup':
        return GetPageRoute(
          page: () => const Signin(),
          settings: settings,
          
        );
      default:
        return GetPageRoute(
          page: () => const OnboardingScreens(),
          settings: settings,
        );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      onGenerateRoute: GeneratedRoutes,
      initialRoute: '/',
      home: BlocProvider(
        create: (context) => OnboardingBloc(),
        child: OnboardingScreens(),
      ),
    );
  }
}
