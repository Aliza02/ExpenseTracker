import 'package:expensetracker/bloc/onboardingBloc/onboarding_events.dart';
import 'package:expensetracker/bloc/onboardingBloc/onboarding_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvents, OnboardingStates> {
  OnboardingBloc() : super(InitialState()) {
    on<LastPageEvent>(
      (event, emit) => emit(LastPageState()),
    );
    on<InitialEvent>(
      (event, emit) => emit(InitialState()),
    );
  }
}
