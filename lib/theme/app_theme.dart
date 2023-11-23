import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kLightColorScheme =
    ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent);
final kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepPurpleAccent, brightness: Brightness.dark);

class AppThemes {
// 1
  static TextTheme lightTextTheme = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: kLightColorScheme.onPrimaryContainer,
    ),
    displayLarge: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: kLightColorScheme.onPrimary,
    ),
    displayMedium: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: kLightColorScheme.onPrimary,
    ),
    displaySmall: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: kLightColorScheme.onPrimary,
    ),
    titleLarge: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: kLightColorScheme.onPrimary,
    ),
  );
// 2
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: kDarkColorScheme.primary,
    ),
    displayLarge: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: kDarkColorScheme.onPrimary,
    ),
    displayMedium: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: kDarkColorScheme.onPrimary,
    ),
    displaySmall: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: kDarkColorScheme.onPrimary,
    ),
    titleLarge: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: kDarkColorScheme.onPrimary,
    ),
  );
// 3
  static ThemeData light() {
    return ThemeData(
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
      textTheme: lightTextTheme,
    );
  }

// 4
  static ThemeData dark() {
    return ThemeData(
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
      textTheme: darkTextTheme,
    );
  }
}
