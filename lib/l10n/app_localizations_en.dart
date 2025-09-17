// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Crisant App';

  @override
  String get welcome => 'Welcome';

  @override
  String get logout => 'Logout';

  @override
  String get cancel => 'Cancel';

  @override
  String get error => 'Error';

  @override
  String get noMoreUsers => 'No more users';

  @override
  String get profile => 'Profile';

  @override
  String get userName => 'User Name';

  @override
  String get userEmail => 'User Email';

  @override
  String get logoutConfirmation => 'Are you sure you want to log out?';
}
