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
