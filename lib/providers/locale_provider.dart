import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  // Constructor
  LocaleProvider(Locale locale) {
    _locale = locale;
  }

  // Change Locale
  void changeLocale(Locale newLocale) async {
    _locale = newLocale;
    notifyListeners();
  }

}