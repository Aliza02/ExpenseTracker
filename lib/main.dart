import 'package:expensetracker/bloc/notification/notification_bloc.dart';
import 'package:expensetracker/bloc/onboardingBloc/onboarding_bloc.dart';
import 'package:expensetracker/bloc/onboardingBloc/statsBloc/stats_bloc.dart';
import 'package:expensetracker/firebase_auth_methods/authentication_methods.dart';
import 'package:expensetracker/firebase_notifications/firebase_noti.dart';
import 'package:expensetracker/firebase_options.dart';
import 'package:expensetracker/screens/SignIn_SignUp/signin.dart';
import 'package:expensetracker/screens/SignIn_SignUp/signup.dart';
import 'package:expensetracker/screens/add_transaction.dart';
import 'package:expensetracker/screens/home/home_screen.dart';
import 'package:expensetracker/screens/onboarding/onboarding_screens.dart';
import 'package:expensetracker/screens/profile/profile.dart';
import 'package:expensetracker/screens/stats/stats.dart';
import 'package:expensetracker/screens/transactions/all_transactions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onboard');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Route GeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/onboard':
        return GetPageRoute(
          page: () => BlocProvider(
            create: (context) => OnboardingBloc(),
            child: const OnboardingScreens(),
          ),
          settings: settings,
        );
      case '/signin':
        return GetPageRoute(
          page: () => const Signin(),
          settings: settings,
        );
      case '/signup':
        return GetPageRoute(
          page: () => const Signup(),
          settings: settings,
        );
      case '/home':
        return GetPageRoute(
          page: () => BlocProvider(
              create: (context) => NotificationBloc(),
              child: const HomeScreen()),
          settings: settings,
        );
      case '/addTransaction':
        return GetPageRoute(
          page: () => const AddTransaction(),
          settings: settings,
        );

      case '/allTransactions':
        return GetPageRoute(
          page: () => AllTransactions(),
          settings: settings,
        );
      case '/stats':
        return GetPageRoute(
          page: () => BlocProvider(
            create: (context) => statsBloc(),
            child: Stats(),
          ),
          settings: settings,
        );
      case '/profile':
        return GetPageRoute(
          page: () => BlocProvider(
            create: (context) => statsBloc(),
            child: profile(),
          ),
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
      onGenerateRoute: GeneratedRoutes,
      initialRoute: isViewed != 0
          ? '/onboard'
          : auth.currentUser != null
              ? '/home'
              : '/signin',
      // home: BlocProvider(
      //   create: (context) => OnboardingBloc(),
      //   child: const OnboardingScreens(),
      // ),
    );
  }
}
