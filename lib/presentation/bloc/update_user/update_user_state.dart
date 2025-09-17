import '../../../data/model/user.dart';

abstract class UpdateUserState {}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final User user;
  UpdateUserSuccess(this.user);
}

class UpdateUserError extends UpdateUserState {
  final String message;
  UpdateUserError(this.message);
}
