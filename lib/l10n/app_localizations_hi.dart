// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'क्रिसेंट ऐप';

  @override
  String get welcome => 'स्वागत है';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get error => 'त्रुटि';

  @override
  String get noMoreUsers => 'कोई और उपयोगकर्ता नहीं';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get userName => 'उपयोगकर्ता नाम';

  @override
  String get userEmail => 'उपयोगकर्ता ईमेल';

  @override
  String get logoutConfirmation => 'क्या आप लॉग आउट करना चाहते हैं?';
}
