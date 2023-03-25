abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ShowPasswordState extends RegisterState {}

class LodinRegisterState extends RegisterState {}

class CreateUserWithEmailAndPasswordGood extends RegisterState {}

class CreateUserWithEmailAndPasswordBad extends RegisterState {
  final String error;

  CreateUserWithEmailAndPasswordBad(this.error);
}
