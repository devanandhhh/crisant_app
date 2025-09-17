import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// Define the states — here, simply using Locale as the state
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')); // default is English

  void changeLocale(Locale locale) {
    emit(locale);
  }
}