import 'package:bloc/bloc.dart';
import 'package:firbase/Page/Register/cubit/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isvisibility = false;

  void showPassword() {
    isvisibility = !isvisibility;
    emit(ShowPasswordState());
  }

  void register({required String email, required String password}) {
    print('dkhol le register');
    emit(LodinRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(CreateUserWithEmailAndPasswordGood());
    }).catchError((e) {
      emit(CreateUserWithEmailAndPasswordBad(e.toString()));
    });
  }
}
