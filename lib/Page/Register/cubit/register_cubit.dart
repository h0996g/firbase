import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase/Page/Register/cubit/register_state.dart';
import 'package:firbase/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isvisibility = false;
  bool isEmailVerified = false;

  void showPassword() {
    isvisibility = !isvisibility;
    emit(ShowPasswordState());
  }

  void register({
    required String email,
    required String password,
    required String address,
    required String name,
    required String phone,
  }) {
    emit(LodinRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // emit(CreateUserWithEmailAndPasswordGood());
      registerFirestore(
        uid: FirebaseAuth.instance.currentUser!.uid,
        name: name,
        address: address,
        email: email,
        phone: phone,
      );
    }).catchError((e) {
      emit(CreateUserWithEmailAndPasswordBad(e.toString()));
    });
  }

  void registerFirestore(
      {required String uid,
      required String name,
      required String address,
      required String email,
      required String phone,
      isEmailVerified = false}) {
    UserModel model = UserModel(
        name: name,
        address: address,
        email: email,
        phone: phone,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserGood());
    }).catchError((e) {
      emit(CreateUserBad(e.toString()));
    });
  }
}
