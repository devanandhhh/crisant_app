import 'package:crisant_app/data/model/user_model.dart';
import 'package:crisant_app/data/shared_preference/shared_preference.dart';
import 'package:crisant_app/data/sqflite/sqflite.dart';
import 'package:crisant_app/others/network_checker.dart';
import 'package:crisant_app/presentation/home_screen/home_screen.dart';
import 'package:crisant_app/presentation/no_network_screen/no_network_screen.dart';
import 'package:crisant_app/presentation/splash_screen/splash_screen.dart';
import 'package:crisant_app/presentation/widgets/custom_snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../data/api/create_user_service.dart';

class SignInScreen extends StatefulWidget {
  final ConnectivityService connectivityService;
  const SignInScreen({super.key, required this.connectivityService});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GoogleSignIn signIn = GoogleSignIn.instance;
  String? error;

  Future<User?> handleSignIn() async {
    try {
      await signIn.initialize(
        clientId:
            "441373015438-hnlt1gj799qvr1nrkuooptse55q9nnt9.apps.googleusercontent.com",
      );
      final account = await signIn.authenticate();

      final auth = account.authentication;
      final credential = GoogleAuthProvider.credential(idToken: auth.idToken);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      return user;
    } catch (e) {
      error = e.toString();
      print('error is $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar( 
      //   title: Text('Google Sign in'),
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/crisant_app.jpg"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Gap(10),
              SignInButton(Buttons.google, text: "Sign in with Google",
                  onPressed: () async {
                //check network connectivity
                if (!widget.connectivityService.isConnected.value) {
                  // Navigate to No Network Screen if offline
                  knavigatorPushReplacement(context,  NoNetworkPage(connectivityService: widget.connectivityService,));
                  return;
                }
                User? user = await handleSignIn();

                if (user != null) {
                  UserModel userModel = UserModel(
                    name: user.displayName ?? '',
                    email: user.email ?? '',
                    photoUrl: user.photoURL ?? '',
                  );
                  // create user through api
                  await CreateUserService().createUser(
                      username: userModel.name,
                      email: userModel.email,
                      password: '',
                      avatar: userModel.photoUrl);
                  await saveUser(userModel);
                  //Saving status
                  await SharedPreference.saveboolValue(true);
                  //Showing snakbar
                  showCustomSnackBar(
                      context, "Sign In Successfully", Colors.green[400]);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => HomeScreen(connectivityService: widget.connectivityService,
                          // user: user,
                          ),
                    ),
                  );
                } else {
                  showCustomSnackBar(
                      context, "User not Found", Colors.blueGrey);
                  // ScaffoldMessenger.of(context)
                  //     .showSnackBar(SnackBar(content: Text("user not found")));
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
