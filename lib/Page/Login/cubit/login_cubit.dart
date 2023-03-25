import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool isvisibility = false;

  void showPassword() {
    isvisibility = !isvisibility;
    emit(ShowPasswordState());
  }

  void login({required String email, required String password}) {
    emit(LodinLoginState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SignInWithEmailAndPasswordGood());
    }).catchError((e) {
      emit(SignInWithEmailAndPasswordBad(e.toString()));
    });
  }
}
