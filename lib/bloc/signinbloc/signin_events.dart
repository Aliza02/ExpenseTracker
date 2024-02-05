abstract class SignInEvents {}

class SignInSubmitEvents extends SignInEvents {
  String email;
  String password;
  SignInSubmitEvents({required this.email, required this.password});
}
