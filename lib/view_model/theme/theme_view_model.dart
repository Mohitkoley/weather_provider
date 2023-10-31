import 'package:flutter/material.dart';
import 'package:weather_app/services/shared_prefrenced/shared_prefrence_service.dart';
import 'package:weather_app/shared/app_constants.dart';

class ThemeViewModel extends ChangeNotifier {
  bool _isDark = false;

  Color lightPrimary = Colors.white;
  Color darkPrimary = Colors.black;

  bool get isDark => _isDark;

  void toggleTheme(bool value) {
    _isDark = value;
    SharedPreferenceService().saveBool(AppConstants.isDarkMode, _isDark);
    notifyListeners();
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
          titleTextStyle: TextStyle(color: Colors.white)),
      drawerTheme:
          const DrawerThemeData(backgroundColor: Colors.black, width: 250),
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontSize: 12, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
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
        titleTextStyle: TextStyle(color: Colors.white)),
    drawerTheme:
        const DrawerThemeData(backgroundColor: Colors.white, width: 250),
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 12, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
    ),
  );

  initSharedPrefBool() async {
    _isDark = await SharedPreferenceService().getBool(AppConstants.isDarkMode);
    notifyListeners();
  }

  ThemeData get themeData {
    initSharedPrefBool();
    if (_isDark) {
      return _darkTheme;
    } else {
      return _lightTheme;
    }
  }
}
