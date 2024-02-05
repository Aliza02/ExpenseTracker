abstract class SignupEvents {}

// class SignUpTextChangeEvent extends SignupEvents {
//   final String name;
//   final String email;
//   final String password;
//   final String confirmPassword;
//   SignUpTextChangeEvent({
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.confirmPassword,
//   });
// }

class SignUpSubmitEvent extends SignupEvents {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  SignUpSubmitEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
