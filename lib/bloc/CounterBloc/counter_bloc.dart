import 'package:expensetracker/bloc/CounterEvents/counter_events.dart';
import 'package:expensetracker/bloc/CounterStates/counter_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvents, CounterStates> {
  CounterBloc() : super(CounterInitialState()) {
    on<IncrementEvent>((event, emit) =>
        emit(IncrementState(event.counter = event.counter + 1)));
    on<DecrementEvent>(
        (event, emit) => emit(DecrementState(event.counter - 1)));
  }
}
