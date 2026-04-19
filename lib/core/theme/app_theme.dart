import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Dark Tech Tokens
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color primaryCyan = Color(0xFF22D3EE);
  static const Color surfaceGlass = Color(0x1AFFFFFF); 

  // Light Clean Tokens
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color primaryIndigo = Color(0xFF4F46E5);

  static ThemeData get darkTechTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primaryCyan,
      colorScheme: const ColorScheme.dark(
        primary: primaryCyan,
        surface: darkBackground,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      useMaterial3: true,
    );
  }

  static ThemeData get cleanLightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: primaryIndigo,
      colorScheme: const ColorScheme.light(
        primary: primaryIndigo,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: darkBackground),
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      useMaterial3: true,
    );
  }

  static BoxDecoration glassDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? const Color(0x1AFFFFFF) : const Color(0x0D000000),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isDark ? const Color(0x33FFFFFF) : const Color(0x1A000000),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}
