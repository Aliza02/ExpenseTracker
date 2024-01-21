import 'package:expensetracker/bloc/onboardingBloc/statsBloc/stats_events.dart';
import 'package:expensetracker/bloc/onboardingBloc/statsBloc/stats_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class statsBloc extends Bloc<StatsEvents, StatsStates> {
  statsBloc() : super(StatButtonSelectedStates(0)) {
    on<MonthlyStatsEvents>((event, emit) => emit(StatButtonSelectedStates(1)));
    on<WeeklyStatsEvents>((event, emit) => emit(StatButtonSelectedStates(0)));
  }
}
