import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: const Color.fromARGB(255, 49, 165, 76),
    secondary: Colors.white,
    surface: Color.fromRGBO(20, 20, 20, 1),
    error: Colors.red,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onError: Colors.white,
  ),
  useMaterial3: true,
  textTheme: lightTextTheme,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleTextStyle: lightTextTheme.headlineLarge,
    backgroundColor: Colors.white,
    centerTitle: false,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(16.0),
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(color: Color.fromRGBO(20, 20, 20, 1)),
    contentPadding: const EdgeInsets.all(16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.black),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.black),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.amber[300]!, width: 2.0),
    ),
    labelStyle: TextStyle(color: Colors.grey[700]),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.amber[200]!,
    secondary: Colors.grey[900]!,
    surface: Color.fromRGBO(245, 245, 245, 1),
    error: Colors.red[300]!,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onError: Colors.black,
  ),
  useMaterial3: true,
  textTheme: darkTextTheme,
  scaffoldBackgroundColor: Color.fromRGBO(20, 20, 20, 1),
  appBarTheme: AppBarTheme(
    titleTextStyle: darkTextTheme.headlineLarge,
    backgroundColor: Color.fromRGBO(26, 26, 26, 1),
    centerTitle: false,
  ),
);

const String primaryFont = 'NataSans';
const String secondaryFont = 'Outfit';

final lightTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: primaryFont,
    fontSize: 57,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  displayMedium: TextStyle(
    fontFamily: primaryFont,
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  displaySmall: TextStyle(
    fontFamily: primaryFont,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  headlineLarge: TextStyle(
    fontFamily: primaryFont,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  headlineMedium: TextStyle(
    fontFamily: primaryFont,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  headlineSmall: TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  titleLarge: TextStyle(
    fontFamily: primaryFont,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
  titleMedium: TextStyle(
    fontFamily: secondaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
  titleSmall: TextStyle(
    fontFamily: secondaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),
  bodyLarge: TextStyle(
    fontFamily: secondaryFont,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  ),
  bodyMedium: TextStyle(
    fontFamily: secondaryFont,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  ),
  bodySmall: TextStyle(
    fontFamily: secondaryFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  ),
  labelLarge: TextStyle(
    fontFamily: secondaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),
  labelMedium: TextStyle(
    fontFamily: secondaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),
  labelSmall: TextStyle(
    fontFamily: secondaryFont,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),
);

final darkTextTheme = lightTextTheme.apply(
  bodyColor: Colors.white,
  displayColor: Colors.white,
);
