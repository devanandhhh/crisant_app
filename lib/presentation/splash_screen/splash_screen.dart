import 'package:crisant_app/data/shared_preference/shared_preference.dart';
import 'package:crisant_app/presentation/home_screen/home_screen.dart';
import 'package:crisant_app/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),()async{
      final sharedPrefz = await SharedPreference.getboolValue();
      if(sharedPrefz!=true){
        knavigatorPushReplacement(context, SignInScreen());
      }else{
        knavigatorPushReplacement(context, HomeScreen());
      }
    });
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.red[400], borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
  
}
Future<void> knavigatorPushReplacement(BuildContext context, Widget screen) {
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => screen));
}
