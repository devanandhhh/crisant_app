import 'package:bloc/bloc.dart';



class ThemeBlocCubit extends Cubit<bool> {
  ThemeBlocCubit() : super(false);

  //  static final ThemeData _lightTheme = ThemeData(
  //   brightness: Brightness.light,
  //   primaryColor: Colors.blue,
  //   scaffoldBackgroundColor: Colors.white,
  //   appBarTheme: AppBarTheme(color: Colors.blue),
  //   textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
  // );

  // static final ThemeData _darkTheme = ThemeData(
  //   brightness: Brightness.dark,
  //   primaryColor: Colors.black,
  //   scaffoldBackgroundColor: Colors.black,
  //   appBarTheme: AppBarTheme(color: Colors.black),
  //   textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
  // );
//   static final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primarySwatch: Colors.blue,
//   );

//   static final ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primarySwatch: Colors.blueGrey,
//   );

//  void toggleTheme(bool isDarkMode) {
//     emit(state.brightness == Brightness.dark ? lightTheme : darkTheme);
//   }
 void toggleTheme() {
    emit(!state); // Toggles between true/false
  }
}