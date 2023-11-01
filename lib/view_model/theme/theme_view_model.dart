import 'package:flutter/material.dart';
import 'package:weather_app/services/shared_preference/shared_preference_service.dart';
import 'package:weather_app/utils/export.dart';

class ThemeViewModel extends ChangeNotifier {
  bool _isDark = false;

  Color lightPrimary = Colors.white;
  Color darkPrimary = Colors.black;

  bool get isDark => _isDark;

  void toggleTheme(bool value) {
    _isDark = value;
    notifyListeners();
    SharedPreferenceService().saveBool(AppConstants.isDarkMode, _isDark);
  }

  final ThemeData _darkTheme = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      brightness: Brightness.dark,
      switchTheme: const SwitchThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(Colors.deepPurple),
          trackColor: MaterialStateProperty.all(Colors.white)),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
      drawerTheme:
          const DrawerThemeData(backgroundColor: Colors.black, width: 250),
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontSize: 20, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 25, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 30, color: Colors.white),
      ));

  final ThemeData _lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    brightness: Brightness.light,
    switchTheme: const SwitchThemeData().copyWith(
        thumbColor: MaterialStateProperty.all(Colors.deepPurple),
        trackColor: MaterialStateProperty.all(Colors.black)),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20)),
    drawerTheme:
        const DrawerThemeData(backgroundColor: Colors.white, width: 250),
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 20, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 25, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 30, color: Colors.black),
    ),
  );

  initSharedPref() async {
    _isDark = await SharedPreferenceService().getBool(AppConstants.isDarkMode);
    String? locale =
        await SharedPreferenceService().getString(AppConstants.locale);
    if (locale != null) {
      _locale = Locale(locale);
    }
    notifyListeners();
  }

  ThemeData get themeData {
    initSharedPref();
    if (_isDark) {
      return _darkTheme;
    } else {
      return _lightTheme;
    }
  }

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void changeLocale(BuildContext context, String newLocale) {
    if (!AppLocalizations.supportedLocales.contains(locale)) return;
    _locale = Locale(newLocale);
    notifyListeners();
    SharedPreferenceService().saveString(AppConstants.locale, newLocale);
  }
}
