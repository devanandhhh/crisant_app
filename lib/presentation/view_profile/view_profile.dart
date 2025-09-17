import 'package:crisant_app/l10n/app_localizations.dart';
import 'package:crisant_app/presentation/widgets/custom_snakbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/model/user.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key, required this.user});

  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: abeezeeStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.4,
              width: MediaQuery.sizeOf(context).width * 0.6,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      (user.avatar != null && user.avatar!.isNotEmpty)
                          ? user.avatar!
                          : "https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png",
                    ),
                  ),
                  Text(
                    "${user.firstName ?? ''} ${user.lastName ?? ''}",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.email ?? 'No Email',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //     decoration: BoxDecoration(
            //         color: Colors.red[300],
            //         borderRadius: BorderRadius.circular(10)),
            //     child: TextButton(
            //         onPressed: () async {
            //           //calling Clear data from sqflite
            //           await clearUser();
            //           //push to login page
            //           knavigatorPushReplacement(
            //             context,
            //             SignInScreen(),
            //           );
            //         },
            //         child: TextButton(
            //           child: Text("Log Out",
            //               style: TextStyle(color: Colors.black)),
            //           onPressed: () => showDialog(
            //             context: context,
            //             builder: (ctx) => AlertDialog(
            //               title: Text("Log Out"),
            //               content: Text("Are you sure you want to log out?"),
            //               actions: [
            //                 TextButton(
            //                   onPressed: () {
            //                     Navigator.of(ctx).pop();
            //                   },
            //                   child: Text("Cancel"),
            //                 ),
            //                 TextButton(
            //                   onPressed: () async {
            //                     //calling Clear data from sqflite
            //                     await clearUser();
            //                     //push to login page
            //                     Navigator.pushAndRemoveUntil(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) => SignInScreen()),
            //                       (route) => false,
            //                     );
            //                   },
            //                   child: Text("Log Out"),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         )))
          ],
        ),
      ),
    );
  }
}
