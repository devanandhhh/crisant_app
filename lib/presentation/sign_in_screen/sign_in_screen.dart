import 'package:crisant_app/data/model/user_model.dart';
import 'package:crisant_app/data/shared_preference/shared_preference.dart';
import 'package:crisant_app/data/sqflite/sqflite.dart';
import 'package:crisant_app/presentation/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

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
      if (account == null) {
        setState(() {
          error = 'user cancelled';
        });
        return null;
      }
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
      appBar: AppBar(
        title: Text('Google Sign in'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(Buttons.google, text: "Sign in with Google",
                onPressed: () async {
              User? user = await handleSignIn();

              if (user != null) {
                UserModel userModel = UserModel(
                  name: user.displayName ?? '',
                  email: user.email ?? '',
                  photoUrl: user.photoURL ?? '',
                );

                await saveUser(userModel);
                //Saving status
              await  SharedPreference.saveboolValue(true);
                //Showing snakbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("User Profile Saved"),
                    backgroundColor: Colors.green[400],
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => HomeScreen(
                        // user: user,
                        ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("user not found")));
              }
            }),
          ],
        ),
      ),
    );
  }
}
