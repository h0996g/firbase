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

class ChangeButtonNavStateGood extends HomeState {}

class ChangeButtonNavStateToAddPostsGood extends HomeState {}

class ImagePickerCoverStateGood extends HomeState {}

class ImagePickerCoverStateBad extends HomeState {}

class ImagePickerProfileStateGood extends HomeState {}

class ImagePickerProfileStateBad extends HomeState {}
