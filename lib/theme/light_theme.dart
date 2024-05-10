import 'package:flutter_chat_application/lib.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade500,
    onPrimary: Colors.white,
    secondary: Colors.grey.shade200,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    background: Colors.grey.shade300,
    onBackground: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    brightness: Brightness.light,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black),
    centerTitle: true,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.black,
    elevation: 0,
    backgroundColor: Colors.white,
  ),
);
