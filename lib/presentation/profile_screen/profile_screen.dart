import 'package:crisant_app/data/model/user_model.dart';
import 'package:crisant_app/l10n/app_localizations.dart';
import 'package:crisant_app/others/network_checker.dart';
import 'package:crisant_app/presentation/bloc/localizations/locale_cubit.dart';
import 'package:crisant_app/presentation/widgets/custom_snakbar.dart';
import 'package:crisant_app/presentation/widgets/rolling_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_logout_button.dart';

class ProfileScreen extends StatelessWidget {
  final ConnectivityService connectivityService;
  const ProfileScreen(
      {super.key, required this.user, required this.connectivityService});

  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile,
        ),
        actions: [
          Row(
            children: [
              CustomThemeSwitch(),
              PopupMenuButton<String>(
            icon: Icon(Icons.language),
            onSelected: (value) {
              if (value == 'en') {
                context.read<LocaleCubit>().changeLocale(Locale('en'));
              } else if (value == 'hi') {
                context.read<LocaleCubit>().changeLocale(Locale('hi'));
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'en',
                child: Text('English'),
              ),
              const PopupMenuItem<String>(
                value: 'hi',
                child: Text('हिन्दी'),
              ),
            ],
          ),
            ],
          )
       
        ],
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
                    backgroundImage: NetworkImage(user.photoUrl.isNotEmpty
                        ? user.photoUrl
                        : "https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png"),
                  ),
                  Text(
                    AppLocalizations.of(context)!.userName,
                    style: abeezeeStyle(),
                  ),
                  Text(
                    user.name,style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal,color: Colors.black),
                  ),
                  Text(
                    AppLocalizations.of(context)!.userEmail,
                    style: abeezeeStyle(),
                  ),
                  Text(user.email,style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal,color: Colors.black),),
                ],
              ),
            ), 
            CustomLogOutButton(
              connectivityService: connectivityService,
            ),
            
          ],
        ),
      ),
    );
  }
 
}
