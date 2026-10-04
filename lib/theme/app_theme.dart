import 'package:flutter/material.dart';

class AppTheme {
  static const Color cream = Color(0xFFFFF0F3);
  static const Color softPink = Color(0xFFF6DDE2);
  static const Color dustyRose = Color(0xFFEFCAD1);
  static const Color dustyRoseDark = Color(0xFFD89AA8);
  static const Color darkPlum = Color(0xFF402538);
  static const Color white = Color(0xFFFFFFFF);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: cream,

      colorScheme: ColorScheme.fromSeed(
        seedColor: dustyRoseDark,
        primary: darkPlum,
        secondary: dustyRoseDark,
        surface: white,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: darkPlum,
        elevation: 0,
        centerTitle: false,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: white,
        indicatorColor: dustyRose,
        elevation: 4,
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w600, color: darkPlum),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: dustyRoseDark, width: 1.5),
        ),
      ),

      cardTheme: CardThemeData(
        color: white,
        elevation: 3,
        shadowColor: darkPlum.withValues(alpha: 0.12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
