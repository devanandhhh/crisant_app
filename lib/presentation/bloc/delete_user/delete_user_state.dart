
/// States
abstract class DeleteUserState {}

class DeleteUserInitial extends DeleteUserState {}

class DeleteUserLoading extends DeleteUserState {}

class DeleteUserSuccess extends DeleteUserState {
  final int userId; // deleted user id
  DeleteUserSuccess(this.userId);
}

class DeleteUserFailure extends DeleteUserState {
  final String message;
  DeleteUserFailure(this.message);
}

/// Cubit
// class DeleteUserCubit extends Cubit<DeleteUserState> {
//   final DeleteUserService service;

//   DeleteUserCubit(this.service) : super(DeleteUserInitial());

//   Future<void> deleteUser(int id) async {
//     try {
//       emit(DeleteUserLoading());
//       final success = await service.deleteUser(id: id);
//       if (success) {
//         emit(DeleteUserSuccess(id));
//       } else {
//         emit(DeleteUserFailure('Failed to delete user'));
//       }
//     } catch (e) {
//       emit(DeleteUserFailure(e.toString()));
//     }
//   }
// }
