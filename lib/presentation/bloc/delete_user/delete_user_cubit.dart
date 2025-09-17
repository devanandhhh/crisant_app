import 'package:crisant_app/presentation/bloc/delete_user/delete_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/delete_user_service.dart';

/// Cubit
class DeleteUserCubit extends Cubit<DeleteUserState> {
  final DeleteUserService service;

  DeleteUserCubit(this.service) : super(DeleteUserInitial());

  Future<void> deleteUser(int id) async {
    try {
      emit(DeleteUserLoading());
      final success = await service.deleteUser(id: id);
      if (success) {
        emit(DeleteUserSuccess(id));
      } else {
        emit(DeleteUserFailure('Failed to delete user'));
      }
    } catch (e) {
      emit(DeleteUserFailure(e.toString()));
    }
  }
}