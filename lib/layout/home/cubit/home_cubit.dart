import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase/models/UserModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../shared/components/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  void getUserData() {
    emit(LodinGetUserDataState());
    FirebaseFirestore.instance.collection('users').doc(UID).get().then((value) {
      print(value.data());
      model = UserModel.fromJson(value.data()!);
      // print(_userModel);
      emit(GetUserDataStateGood());
    }).catchError((e) {
      emit(GetUserDataStateBad(e.toString()));
    });
  }
}
