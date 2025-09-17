

import 'package:crisant_app/data/model/user.dart';

abstract class PaginationState {}

class PaginationInitial extends PaginationState {}

class PaginationLoading extends PaginationState {}

class PaginationLoaded extends PaginationState {
  final List<User> users;
  final bool hasMore;

  PaginationLoaded({required this.users, required this.hasMore});
}

class PaginationError extends PaginationState {
  final String message;

  PaginationError(this.message);
}
