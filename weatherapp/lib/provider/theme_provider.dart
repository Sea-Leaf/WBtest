import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

// ignore: camel_case_types
class myThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF0C172B),
    iconTheme: const IconThemeData(color: Colors.white),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF0C172B)),
    cardColor: const Color(0x4DFFFFFF),
    shadowColor: const Color(0xFFFFFFFF),
    backgroundColor: const Color(0xFF0F1F40),
    dialogBackgroundColor: const Color(0xFF223B70),
    colorScheme: const ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
    cardColor: const Color(0x4DBFBFBF),
    shadowColor: const Color(0xFFDEDEDE),
    backgroundColor: const Color(0xFF9CBCFF),
    dialogBackgroundColor: const Color(0XFFCDDAF5),
    colorScheme: const ColorScheme.light(),
  );
}
