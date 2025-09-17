import 'package:crisant_app/presentation/bloc/delete_user/delete_user_cubit.dart';
import 'package:crisant_app/presentation/widgets/custom_snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showDeleteConfirmationDialog(BuildContext context, String userId) {
  int id = int.parse(userId);
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('Delete User'),
        content: const Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await context.read<DeleteUserCubit>().deleteUser(id);
              Navigator.pop(ctx);
              showCustomSnackBar(
                  context, "User deleted successfully", Colors.green[400]!);
              // context.read<PaginationCubit>().refresh();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}