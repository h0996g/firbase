import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase/models/UserModel.dart';
import 'package:firbase/modules/chats/chats.dart';
import 'package:firbase/modules/feeds/feeds.dart';
import 'package:firbase/modules/posts/posts.dart';
import 'package:firbase/modules/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/settings/settings.dart';
import '../../../shared/components/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  int currentIndex = 0;
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

  changeButtonNav(int currentIndex) {
    if (currentIndex == 2) {
      emit(ChangeButtonNavStateToAddPostsGood());
    } else {
      this.currentIndex = currentIndex;
      emit(ChangeButtonNavStateGood());
    }
  }

  List<Widget> userScreen = const [
    Feeds(),
    Chats(),
    AddPost(),
    Users(),
    Setting()
  ];
  List<String> appbarScreen = const [
    'Feeds',
    'Chats',
    'AddPost',
    'Users',
    'Settings'
  ];
}
