import 'package:crisant_app/l10n/app_localizations.dart';
import 'package:crisant_app/others/network_checker.dart';
import 'package:crisant_app/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:crisant_app/presentation/widgets/custom_snakbar.dart';
import 'package:flutter/material.dart';

import '../../data/sqflite/sqflite.dart';
import '../splash_screen/splash_screen.dart';

class CustomLogOutButton extends StatelessWidget {
  final ConnectivityService connectivityService;
  const CustomLogOutButton({
    super.key,
    required this.connectivityService,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.red[300], borderRadius: BorderRadius.circular(10)),
        child: TextButton(
            onPressed: () async {
              //calling Clear data from sqflite
              await clearUser();
              //push to login page
              knavigatorPushReplacement(
                context,
                SignInScreen(
                  connectivityService: connectivityService,
                ),
              );
            },
            child: TextButton(
              child: Text(AppLocalizations.of(context)!
                            .logout, style: TextStyle(color: Colors.black)),
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(
                    AppLocalizations.of(ctx)!.logout,
                    style: abeezeeStyle(),
                  ),
                  content: Text(AppLocalizations.of(ctx)!
                            .logoutConfirmation,),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text(AppLocalizations.of(ctx)!.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        logout(context, connectivityService);
                      },
                      // onPressed: () async {
                      //   //calling Clear data from sqflite
                      //   await clearUser();
                      //   //push to login page
                      //   Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => SignInScreen())
                      //     , (route) => false,
                      //   );
                      // },
                      child: Text(
                        AppLocalizations.of(ctx)!
                            .logout, // Localized "Log Out"
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}

Future<void> logout(
    BuildContext context, ConnectivityService connectivityService) async {
  // Clear data from SQLite
  await clearUser();

  // Navigate to login page and remove all previous routes
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => SignInScreen(
              connectivityService: connectivityService,
            )),
    (route) => false,
  );
}
