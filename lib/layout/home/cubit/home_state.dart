part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LodinGetUserDataState extends HomeState {}

class GetUserDataStateGood extends HomeState {}

class GetUserDataStateBad extends HomeState {
  final error;

  GetUserDataStateBad(this.error);
}

class LodinGetAllUsersDataState extends HomeState {}

class GetAllUsersDataStateGood extends HomeState {}

class GetAllUsersDataStateBad extends HomeState {
  final error;

  GetAllUsersDataStateBad(this.error);
}

class ChangeButtonNavStateGood extends HomeState {}

class ChangeButtonNavStateToAddPostsGood extends HomeState {}

class ImagePickerCoverStateGood extends HomeState {}

class ImagePickerCoverStateBad extends HomeState {}

class ImagePickerProfileStateGood extends HomeState {}

class ImagePickerProfileStateBad extends HomeState {}

class ImagePickerPostStateGood extends HomeState {}

class ImagePickerPostStateBad extends HomeState {}

class UploadProfileImgAndGetUrlStateGood extends HomeState {}

class UploadProfileImgAndGetUrlStateBad extends HomeState {}

class UploadCoverImgAndGetUrlStateGood extends HomeState {}

class UploadCoverImgAndGetUrlStateBad extends HomeState {}

class LodingUpdateUserState extends HomeState {}

class UpdateUserStateGood extends HomeState {}

class UpdateUserStateBad extends HomeState {}

class UploadPostAndGetUrlStateGood extends HomeState {}

class UploadPostAndGetUrlStateBad extends HomeState {}

class LodingAddPostState extends HomeState {}

class AddPostStateGood extends HomeState {}

class AddPostStateBad extends HomeState {}

class LodinGetPostsState extends HomeState {}

class GetPostsStateGood extends HomeState {}

class GetPostsStateBad extends HomeState {
  final error;

  GetPostsStateBad(this.error);
}

class LodinLikePostsState extends HomeState {}

class LikePostsStateGood extends HomeState {}

class LikePostsStateBad extends HomeState {
  final error;

  LikePostsStateBad(this.error);
}

// class LodinSendAndReciveMessageDataState extends HomeState {}

class SendMessageDataStateGood extends HomeState {}

class SendMessageDataStateBad extends HomeState {
  final error;

  SendMessageDataStateBad(this.error);
}

class ReciveMessageDataStateGood extends HomeState {}

class ReciveMessageDataStateBad extends HomeState {
  final error;

  ReciveMessageDataStateBad(this.error);
}

class GetMessageDataStateGood extends HomeState {}
