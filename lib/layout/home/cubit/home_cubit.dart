import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase/models/PostModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firbase/models/UserModel.dart';
import 'package:firbase/modules/chats/chats.dart';
import 'package:firbase/modules/feeds/feeds.dart';
import 'package:firbase/modules/posts/posts.dart';
import 'package:firbase/modules/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../modules/settings/settings.dart';
import '../../../shared/components/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  int currentIndex = 0;
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

  void getUserData() {
    emit(LodinGetUserDataState());
    FirebaseFirestore.instance.collection('users').doc(UID).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
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

  // ------------------------- //? EditeProfile ------------------------------------------------

  // ! imagePicker lel Edite Profile

  XFile? imageCover;
  XFile? imageProfile;
  Future<void> imagePickerCover(ImageSource source) async {
    final ImagePicker _pickerCover = ImagePicker();

    await _pickerCover.pickImage(source: source).then((value) {
      imageCover = value;
      print(imageCover!.path);
      // print(Uri.file(imageCover!.path).pathSegments.last);
      emit(ImagePickerCoverStateGood());
    }).catchError((e) {
      emit(ImagePickerCoverStateBad());
    });
  }

  Future<void> imagePickerProfile(ImageSource source) async {
    final ImagePicker _pickerProfile = ImagePicker();
    _pickerProfile.pickImage(source: source).then((value) {
      imageProfile = value;
      emit(ImagePickerProfileStateGood());
    }).catchError((e) {
      emit(ImagePickerProfileStateBad());
    });
  }

  // Future<void> imagePickerPost(ImageSource source) async {
  //   final ImagePicker _pickerProfile = ImagePicker();

  //   _pickerProfile.pickImage(source: source).then((value) {
  //     imagePost = value;
  //     emit(ImagePickerPostStateGood());
  //   }).catchError((e) {
  //     emit(ImagePickerPostStateBad());
  //   });
  // }

  // !

// ! update info img profile and cover and value

  String? linkProfileImg;
  String? linkCoverImg;
  Future<void> updateProfileImg() async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/' + Uri.file(imageProfile!.path).pathSegments.last)
        .putFile(File(imageProfile!.path))
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        linkProfileImg = value;
        print(linkProfileImg);
        // emit(UploadProfileImgAndGetUrlStateGood());  //! bah matro7ch  LodingUpdateUserStateGood() t3 Widget LinearProgressIndicator
      }).catchError((e) {
        emit(UploadProfileImgAndGetUrlStateBad());
      });
    });
  }

  Future<void> updateCoverImg() async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/' + Uri.file(imageCover!.path).pathSegments.last)
        .putFile(File(imageCover!.path))
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        linkCoverImg = value;
        print(linkCoverImg);
        // emit(UploadCoverImgAndGetUrlStateGood());  //! bah matro7ch  LodingUpdateUserStateGood() t3 Widget LinearProgressIndicator
      }).catchError((e) {
        emit(UploadCoverImgAndGetUrlStateBad());
      });
    });
  }

  Future<void> updateUser({
    required String name,
    required String phone,
    required String address,
    required String bio,
  }) async {
    emit(LodingUpdateUserState());
    if (imageProfile != null) {
      await updateProfileImg();
    }
    if (imageCover != null) {
      await updateCoverImg();
    }
    print({"Profile img : $linkProfileImg"});
    print("Cover img : $linkCoverImg");

    UserModel model = UserModel(
      uid: userModel!.uid,
      name: name,
      address: address,
      email: userModel!.email,
      phone: phone,
      bio: bio,
      cover: linkCoverImg ?? userModel!.cover,
      img: linkProfileImg ?? userModel!.img,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
      resetWhenUpdateUser(); //update jaya ykono null my3awedtch yb3ethom kon my3amarhomch
      emit(UpdateUserStateGood());
    }).catchError((e) {
      emit(UpdateUserStateBad());
    });
  }

  void resetWhenUpdateUser() {
    linkProfileImg = null;
    linkCoverImg = null;
  }

  void resetWhenReturnFromUpdate() {
    imageCover = null;
    imageProfile = null;
  }
// !

  // ------------------------- //? End EditeProfile ------------------------------------------------

  // ------------------------- //? Add Post ------------------------------------------------
  XFile? imagePost;

  List<XFile> multipickerPost = [];
  // ! to add Multi images AddPost (imagePicker)
  Future<void> multuPickerPost({ImageSource? source}) async {
    final ImagePicker _pickerPost = ImagePicker();
    if (source == ImageSource.camera) {
      // kon tkon mn camera tetzad lel multipickerPost
      await _pickerPost.pickImage(source: ImageSource.camera).then((value) {
        multipickerPost.add(value!);
        emit(ImagePickerPostStateGood());
      });
    } else {
      _pickerPost.pickMultiImage().then((value) {
        multipickerPost.addAll(value);
        emit(ImagePickerPostStateGood());
      }).catchError((e) {
        emit(ImagePickerPostStateBad());
      });
    }
  }

  List<String> linkMultiPostImg = [];
  Future<void> uploadMuliImagePost() async {
    for (var element in multipickerPost) {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('posts/' + Uri.file(element.path).pathSegments.last)
          .putFile(File(element.path))
          .then((p0) async {
        await p0.ref.getDownloadURL().then((value) {
          linkMultiPostImg.add(value);

          // emit(UploadPostAndGetUrlStateGood());  //! bah matro7ch  LodingAddPostState() t3 Widget LinearProgressIndicator
        }).catchError((e) {
          emit(UploadPostAndGetUrlStateBad());
        });
      });
    }
  }

  Future<void> addPost({
    required String text,
  }) async {
    emit(LodingAddPostState());
    if (multipickerPost != []) {
      await uploadMuliImagePost();
    }
    PostModel model = PostModel(
        uid: userModel!.uid,
        name: userModel!.name,
        dateTime: DateTime.now().toString(),
        postImg: linkMultiPostImg.toList(),
        profileimg: userModel!.img,
        text: text);
    await FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(AddPostStateGood());
    }).catchError((e) {
      emit(AddPostStateBad());
    });
  }

  resetWhenAddPost() {
    multipickerPost = [];
    linkMultiPostImg = [];
  }
}


// ------------------------- //? End Add Post ------------------------------------------------

// ! mzllt mdrtch Fonction get defaultValue (NULL);

// ? bh njib user info f login wla register getUserData()
// ?
