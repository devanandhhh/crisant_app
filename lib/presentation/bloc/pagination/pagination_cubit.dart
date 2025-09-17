import 'dart:developer';

import 'package:crisant_app/presentation/bloc/pagination/pagination_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/api/get_all_user_service.dart';
import '../../../data/model/user.dart';

class PaginationCubit extends Cubit<PaginationState> {
  final GetAllUserService service;
  int currentPage = 1;
  bool hasMore = true;
  List<User> users = [];

  PaginationCubit(this.service) : super(PaginationInitial());

  void fetchUsers() async {
    if (!hasMore) return;

    try {
      emit(PaginationLoading());
      final newUsers = await service.getUsers(page: currentPage);
      users.addAll(newUsers);

      if (newUsers.isEmpty) hasMore = false;
      currentPage++;

      emit(PaginationLoaded(users: users, hasMore: hasMore));
    } catch (e) {
      log(  'Error fetching users: $e');
      emit(PaginationError(e.toString()));
    }
  }

  // Optional: reset pagination
  void refresh() {
    currentPage = 1;
    hasMore = true;
    users = [];
    fetchUsers();
  }
}
