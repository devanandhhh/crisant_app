import 'package:crisant_app/data/model/user.dart';
import 'package:crisant_app/presentation/bloc/update_user/update_user_cubit.dart';
import 'package:crisant_app/presentation/widgets/custom_snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

void showUpdateUserDialog(BuildContext context, User user) {
  final nameController = TextEditingController(
      text: "${user.firstName ?? ''} ${user.lastName ?? ''}");
  final emailController = TextEditingController(text: user.email ?? '');

  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                user.avatar ??
                    'https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png',
              ),
            ),
            const Gap(16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const Gap(8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  final firstName = nameController.text.split(' ').first;
                  final lastName = nameController.text.split(' ').length > 1
                      ? nameController.text.split(' ').sublist(1).join(' ')
                      : '';

                  await context.read<UpdateUserCubit>().updateUserCubit(
                        id: user.id.toString(),
                        firstName: firstName,
                        lastName: lastName,
                        email: emailController.text,
                      );

                  Navigator.pop(ctx);
                  showCustomSnackBar(
                      context, "Update Data Successfully", Colors.green[400]);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ],
      );
    },
  );
}