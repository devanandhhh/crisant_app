import 'package:crisant_app/data/shared_preference/shared_preference.dart';
import 'package:crisant_app/others/network_checker.dart';
import 'package:crisant_app/presentation/home_screen/home_screen.dart';
import 'package:crisant_app/presentation/no_network_screen/no_network_screen.dart';
import 'package:crisant_app/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:crisant_app/presentation/widgets/custom_snakbar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final ConnectivityService connectivityService;

  const SplashScreen({super.key, required this.connectivityService});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      if (!connectivityService.isConnected.value) {
        // If no network, navigate to NoNetworkScreen
        knavigatorPushReplacement(
            context,
            NoNetworkPage(
              connectivityService: connectivityService,
            ));
        return;
      }

      final sharedPrefz = await SharedPreference.getboolValue();
      if (sharedPrefz != true) {
        knavigatorPushReplacement(
            context,
            SignInScreen(
              connectivityService: connectivityService,
            ));
      } else {
        knavigatorPushReplacement(
            context,
            HomeScreen(
              connectivityService: connectivityService,
            ));
      }
    });

    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to Crisant App",
          style: abeezeeStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 41, 187, 143)),
        ),
      ),
    );
  }
}

Future<void> knavigatorPushReplacement(BuildContext context, Widget screen) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (ctx) => screen),
  );
}
