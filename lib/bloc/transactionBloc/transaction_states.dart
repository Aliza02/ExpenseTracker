abstract class TransactionStates {}
class InitialState extends TransactionStates{}
class InValidState extends TransactionStates{
  final String errorMessage;
  InValidState({required this.errorMessage});
}

class AddLoadingState extends TransactionStates{}