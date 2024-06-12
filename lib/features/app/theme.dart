import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static final light = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontFamily: 'SFUI',
            fontSize: 36,
            fontWeight: FontWeight.w400,
          ),
        ),
        overlayColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.05)),
        minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
        elevation: const WidgetStatePropertyAll(5),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
        ),
        floatingLabelStyle: const TextStyle(color: Colors.black),
        prefixStyle: const TextStyle(color: Colors.black),
        helperStyle: const TextStyle(color: Colors.black)),
    fontFamily: 'SFUI',
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primaryContainer: Color(0xFFFDBC15),
      primary: Colors.white,
      onPrimary: Colors.blue,
      secondary: Color.fromARGB(255, 51, 34, 53),
      onSecondary: Colors.white,
      surface: Color.fromARGB(255, 243, 243, 243),
      onSurface: Colors.black,
      error: Color.fromARGB(255, 255, 124, 124),
      errorContainer: Color.fromARGB(255, 253, 237, 237),
      onError: Colors.white,
    ),
    dialogBackgroundColor: Colors.white,
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      titleTextStyle: TextStyle(
        fontFamily: 'SFUI',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
    datePickerTheme: const DatePickerThemeData(),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: 'SFUI',
        fontSize: 48,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'SFUI',
        fontSize: 26,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),
  );
}
