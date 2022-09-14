part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class GetUserDataCompletedState extends UserState{
  final UserDataModel user;
  GetUserDataCompletedState(this.user);
}
class GetUserDataLoadingStateState extends UserState{}
class GetUserDataFailedState extends UserState{
  final String error;
  GetUserDataFailedState(this.error);
}
class UpdateUserDataCompletedState extends UserState{}
class UpdateUserDataLoadingStateState extends UserState{}
class UpdateUserDataFailedState extends UserState{
  final String error;
  UpdateUserDataFailedState(this.error);
}