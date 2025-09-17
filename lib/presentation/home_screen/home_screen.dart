import 'package:crisant_app/l10n/app_localizations.dart';
import 'package:crisant_app/others/network_checker.dart';
import 'package:crisant_app/presentation/bloc/delete_user/delete_user_cubit.dart'
    show DeleteUserCubit;
import 'package:crisant_app/presentation/bloc/pagination/pagination_cubit.dart';
import 'package:crisant_app/presentation/no_network_screen/no_network_screen.dart';
import 'package:crisant_app/presentation/profile_screen/profile_screen.dart';
import 'package:crisant_app/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:crisant_app/presentation/view_profile/view_profile.dart';
import 'package:crisant_app/presentation/widgets/custom_logout_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../data/api/get_all_user_service.dart';
import '../../data/model/user.dart';
import '../../data/sqflite/sqflite.dart';
import '../bloc/pagination/pagination_state.dart';
import '../bloc/update_user/update_user_cubit.dart';
import '../widgets/custom_snakbar.dart';

class HomeScreen extends StatefulWidget {
  final ConnectivityService connectivityService;
  const HomeScreen({
    super.key,
    required this.connectivityService,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetAllUserService service = GetAllUserService();

  @override
  void initState() {
    super.initState();
    // Listen for connectivity changes
    widget.connectivityService.isConnected.addListener(_onConnectivityChanged);

    // Fetch users if connected
    if (widget.connectivityService.isConnected.value) {
      context.read<PaginationCubit>().fetchUsers();
    }
  }

  void _onConnectivityChanged() {
    if (!widget.connectivityService.isConnected.value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (ctx) =>
                NoNetworkPage(connectivityService: widget.connectivityService)),
        (route) => false,
      );
      //knavigatorPushReplacement(context, NoNetworkPage(connectivityService: widget.connectivityService,));
    }
  }

  @override
  void dispose() {
    widget.connectivityService.isConnected
        .removeListener(_onConnectivityChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<PaginationCubit>().fetchUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: abeezeeStyle(
              fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: .5),
        ),
        actions: [
          FutureBuilder(
              future: getCurrentUser(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => SignInScreen(
                              connectivityService: widget.connectivityService,
                            ),
                          ));
                    },
                  );
                }
                final user = snapshot.data!;
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ProfileScreen(
                                user: user,
                                connectivityService: widget.connectivityService,
                              ))),
                  child: CircleAvatar(
                      radius: 20, backgroundImage: NetworkImage(user.photoUrl)),
                );
              }),
          Gap(10)
        ],
      ),
      body: BlocBuilder<PaginationCubit, PaginationState>(
        builder: (context, state) {
          if (state is PaginationLoading && state is! PaginationLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PaginationError) {
            return Column(
              children: [
                Center(child: Text("Error: ${state.message}")),
                CustomLogOutButton(
                  connectivityService: widget.connectivityService,
                )
              ],
            );
          } else if (state is PaginationLoaded) {
            final users = state.users;
            return ListView.builder(
              itemCount: users.length + 1,
              itemBuilder: (context, index) {
                if (index < users.length) {
                  final user = users[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ViewProfile(user: user),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          (user.avatar != null && user.avatar!.isNotEmpty)
                              ? user.avatar!
                              : "https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png",
                        ),
                      ),
                      title: Text(
                        "${user.firstName ?? ''} ${user.lastName ?? ''}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(user.email ?? 'No Email'),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            return showUpdateUserDialog(context, user);
                          } else if (value == 'delete') {
                            // Call delete function
                            return showDeleteConfirmationDialog(
                                context, user.id.toString());
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                        icon: const Icon(Icons.more_vert), // 3-dot icon
                      ),
                    ),
                  );
                } else {
                  if (state.hasMore) {
                    context.read<PaginationCubit>().fetchUsers();
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return Center(child: Text(AppLocalizations.of(context)!.noMoreUsers));
                  }
                }
              },
            );
          } else {
            return Container(
              child: Text('nothing'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PaginationCubit>().refresh();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

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
