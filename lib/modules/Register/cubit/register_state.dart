abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ShowPasswordState extends RegisterState {}

class LodinRegisterState extends RegisterState {}

class CreateUserWithEmailAndPasswordGood extends RegisterState {}

class CreateUserWithEmailAndPasswordBad extends RegisterState {
  final String error;

  CreateUserWithEmailAndPasswordBad(this.error);
}

class CreateUserGood extends RegisterState {
  final uid;

  CreateUserGood(this.uid);
}

class CreateUserBad extends RegisterState {
  final String error;

  CreateUserBad(this.error);
}
