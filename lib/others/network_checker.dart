import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final ValueNotifier<bool> isConnected = ValueNotifier(true);

  ConnectivityService() {
    _initialize();
  }

  void _initialize() {
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        isConnected.value = false;
      } else {
        isConnected.value = await InternetConnectionChecker().hasConnection;
      }
    });
  }

  Future<void> checkInitialConnection() async {
    isConnected.value = await InternetConnectionChecker().hasConnection;
  }
}
