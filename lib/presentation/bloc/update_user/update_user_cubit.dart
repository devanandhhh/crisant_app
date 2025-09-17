import 'package:crisant_app/presentation/bloc/update_user/update_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/update_user_service.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  final UpdateUserService _service;

  UpdateUserCubit(this._service) : super(UpdateUserInitial());

  Future<void> updateUserCubit({
    required String id,
    String? firstName,
    String? lastName,
    String? email,
    
  }) async {
    try {
      emit(UpdateUserLoading());

      final updatedUser = await _service.updateUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        
      );

      if (updatedUser != null) {
        emit(UpdateUserSuccess(updatedUser));
      } else {
        emit(UpdateUserError('Failed to update user.'));
      }
    } catch (e) {
      emit(UpdateUserError(e.toString()));
    }
  }
}
