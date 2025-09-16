
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static String key ='isLogin';


  static Future<void> saveboolValue(bool value)async{
    final SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
  static Future<bool> getboolValue()async{
  final SharedPreferences prefs =await SharedPreferences.getInstance();
  return prefs.getBool(key)??false;
  }

  static Future<bool> deletebool()async{
    final SharedPreferences prefs =await SharedPreferences.getInstance();
    return prefs.clear();
    
  }
}