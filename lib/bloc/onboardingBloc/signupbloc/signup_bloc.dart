import 'package:email_validator/email_validator.dart';
import 'package:expensetracker/bloc/onboardingBloc/signupbloc/signup_events.dart';
import 'package:expensetracker/bloc/onboardingBloc/signupbloc/signup_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SignUpBloc extends Bloc<SignupEvents, SignUpStates> {
  SignUpBloc() : super(InitialState()) {
    on<SignUpSubmitEvent>((event, emit) {
      if (EmailValidator.validate(event.email) == false &&
          event.email.isNotEmpty) {
        emit(InvalidSignUpState(errorMessage: 'Enter correct email'));
      } else if (event.password.length < 7 && event.password.isNotEmpty ||
          event.confirmPassword.length < 7 &&
              event.confirmPassword.isNotEmpty) {
        emit(InvalidSignUpState(
            errorMessage: 'Password should be 7 characters long'));
      } else if (event.name.isEmpty) {
        emit(InvalidSignUpState(errorMessage: 'Name cannot be empty'));
      } else if (event.password != event.confirmPassword) {
        emit(InvalidSignUpState(errorMessage: 'Passwords do not match'));
      } else if (event.email.isEmpty ||
          event.name.isEmpty ||
          event.password.isEmpty ||
          event.confirmPassword.isEmpty) {
        emit(InvalidSignUpState(errorMessage: 'Enter all Details to Proceed'));
      } else if (event.email.isNotEmpty &&
          event.password.isNotEmpty &&
          event.name.isNotEmpty &&
          event.confirmPassword.isNotEmpty) {
        emit(SignUpLoadingState());
      }
    });
  }
}
