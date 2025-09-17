import 'package:crisant_app/data/api/get_all_user_service.dart';
import 'package:crisant_app/firebase_options.dart';
import 'package:crisant_app/l10n/app_localizations.dart';
import 'package:crisant_app/others/network_checker.dart';
import 'package:crisant_app/others/notification_service.dart';
import 'package:crisant_app/presentation/bloc/delete_user/delete_user_cubit.dart';
import 'package:crisant_app/presentation/bloc/localizations/locale_cubit.dart';
import 'package:crisant_app/presentation/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/api/delete_user_service.dart';
import 'data/api/update_user_service.dart';
import 'data/sqflite/sqflite.dart';
import 'presentation/bloc/pagination/pagination_cubit.dart';
import 'presentation/bloc/update_user/update_user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize connectivity service once
  final connectivityService = ConnectivityService();
  await connectivityService.checkInitialConnection();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDatabase();
  final notificationService = NotificationService();
  await notificationService.initFCM();
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  runApp(MyApp(connectivityService: connectivityService)); // Pass it here
}

class MyApp extends StatelessWidget {
  final GetAllUserService userService = GetAllUserService();
  final ConnectivityService connectivityService;

  MyApp(
      {super.key,
      required this.connectivityService}); // Accept it in constructor

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PaginationCubit>(
          create: (_) => PaginationCubit(userService)..fetchUsers(),
        ),
        BlocProvider<UpdateUserCubit>(
          create: (_) => UpdateUserCubit(UpdateUserService()),
        ),
        BlocProvider<DeleteUserCubit>(
          create: (_) => DeleteUserCubit(DeleteUserService()),
        ),
        BlocProvider(create: (_) => LocaleCubit())
        // Add more providers if needed
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            title: 'Crisant App',
            locale: locale,
            localizationsDelegates: [
              AppLocalizations.delegate, // generated
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
            ],
            home: SplashScreen(
                connectivityService: connectivityService), // Pass here
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
Future<void>handleBackgroundMessage(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // You can perform additional actions here, like showing a notification
  // or updating local data based on the message content.
}