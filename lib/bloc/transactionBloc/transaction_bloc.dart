import 'package:expensetracker/bloc/transactionBloc/transaction_events.dart';
import 'package:expensetracker/bloc/transactionBloc/transaction_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvents, TransactionStates> {
  TransactionBloc() : super(InitialState()) {
    on<AddTransactionEvent>(
      (event, emit) {
        if (event.amount.isNotEmpty &&
            event.date.isNotEmpty &&
            event.notes.isNotEmpty) {
          emit(AddLoadingState());
        } else {
          emit(InValidState(errorMessage: 'Enter all details to proceed'));
        }
      },
    );
  }
}
