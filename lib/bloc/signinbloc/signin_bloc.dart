import 'package:email_validator/email_validator.dart';
import 'package:expensetracker/bloc/signinbloc/signin_events.dart';
import 'package:expensetracker/bloc/signinbloc/signin_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvents, SignInStates> {
  SignInBloc() : super(InitialState()) {
    on<SignInSubmitEvents>(
      (event, emit) {
        if (event.email.isEmpty || event.password.isEmpty) {
          emit(InValidState(errorMessage: 'Enter all Details to Proceed'));
        } else if (EmailValidator.validate(event.email) == false) {
          emit(InValidState(errorMessage: 'Enter correct email'));
        } else if (event.password.length < 7) {
          emit(InValidState(
              errorMessage: 'Password should be 7 characters long'));
        } else {
          emit(SignInLoadingState());
        }
      },
    );
  }
}
