import 'package:flutter/material.dart';

final kLightColorScheme =
    ColorScheme.fromSeed(seedColor: const Color(0xff18604A));
final kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xff18604A), brightness: Brightness.dark);

class AppThemes {
// 1
  static TextTheme lightTextTheme = TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Cairo-VariableFont_slnt,wght',
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: kLightColorScheme.onPrimary,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Cairo-VariableFont_slnt,wght',
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
      color: kLightColorScheme.onPrimaryContainer,
    ),
    displayLarge: TextStyle(
      fontFamily: 'Cairo-VariableFont_slnt,wght',
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: kLightColorScheme.onPrimaryContainer,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Cairo-VariableFont_slnt,wght',
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: kLightColorScheme.onPrimaryContainer,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Cairo-VariableFont_slnt,wght',
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: kLightColorScheme.onPrimaryContainer,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Cairo-VariableFont_slnt,wght',
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: kLightColorScheme.onPrimaryContainer,
    ),
  );
// 2
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Cairo-VariableFont_slnt,wght',
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: kDarkColorScheme.onPrimary,
    ),
    displayLarge: TextStyle(
      fontFamily: 'Cairo-VariableFont_slnt,wght',
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: kDarkColorScheme.onPrimary,
    ),
    displayMedium: const TextStyle(
      fontFamily: 'Cairo-VariableFont_slnt,wght',
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Cairo-VariableFont_slnt,wght',
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: kDarkColorScheme.onPrimary,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Cairo-VariableFont_slnt,wght',
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: kDarkColorScheme.onPrimary,
    ),
  );
// 3
  static ThemeData lightAppTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: kLightColorScheme,
    scaffoldBackgroundColor: kLightColorScheme.background,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          return Colors.black;
        },
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kLightColorScheme.primary,
      foregroundColor: kLightColorScheme.onPrimary,
      elevation: 5,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kLightColorScheme.primary,
        foregroundColor: kLightColorScheme.onPrimary,
        elevation: 8),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.green,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: kLightColorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)))),
    ),
    textTheme: lightTextTheme,
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: kDarkColorScheme.primary),
    cardTheme: CardTheme(
      clipBehavior: Clip.none,
      color: kLightColorScheme.primary,
    ),
    iconTheme: IconThemeData(color: kLightColorScheme.primary),
    primaryIconTheme: IconThemeData(color: kLightColorScheme.primary),
    drawerTheme: DrawerThemeData(),
  );

// 4
  static ThemeData darkAppTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kDarkColorScheme.shadow,
    appBarTheme: AppBarTheme(
      backgroundColor: kDarkColorScheme.primary,
      foregroundColor: kDarkColorScheme.onSecondary,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kDarkColorScheme.secondary,
      foregroundColor: kDarkColorScheme.onSecondary,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.green,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: kLightColorScheme.inversePrimary,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          minimumSize: const Size(130, 70)),
    ),
    textTheme: darkTextTheme,
  );
}
