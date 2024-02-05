abstract class SignInStates{}

class InitialState extends SignInStates{}
class SignInLoadingState extends SignInStates{}
class InValidState extends SignInStates{
  final String errorMessage;
  InValidState({required this.errorMessage});
}
class ValidState extends SignInStates{}