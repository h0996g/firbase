abstract class LoginState {}

class LoginInitial extends LoginState {}

class ShowPasswordState extends LoginState {}

class LodinLoginState extends LoginState {}

class SignInWithEmailAndPasswordGood extends LoginState {}

class SignInWithEmailAndPasswordBad extends LoginState {
  final String err;

  SignInWithEmailAndPasswordBad(this.err);
}
