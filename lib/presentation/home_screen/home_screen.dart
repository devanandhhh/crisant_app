import 'package:crisant_app/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:crisant_app/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../data/model/user_model.dart';
import '../../data/sqflite/sqflite.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Screen"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                //calling Clear data from sqflite
                await clearUser();
                //push to login page
                knavigatorPushReplacement(
                  context,
                  SignInScreen(),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<UserModel?>(
          future: getCurrentUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            final user = snapshot.data!;
            return Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 40 , backgroundImage: NetworkImage(user.photoUrl)),
                  Text(user.name),
                  Text(user.email),
                ],
              ),
            );
          },
        ));
  }
}
