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
          style: abeezeeStyle(fontSize: 25,color: Colors.blueGrey,fontWeight: FontWeight.bold),
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
                    AppLocalizations.of(context)!.userName,
                    style: abeezeeStyle(),
                  ), 
                  Text(
                    "${user.firstName ?? ''} ${user.lastName ?? ''}",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20,color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.userEmail,
                    style: abeezeeStyle(),
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
            
          ],
        ),
      ),
    );
  }
}
