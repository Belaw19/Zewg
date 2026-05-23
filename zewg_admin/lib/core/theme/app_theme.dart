import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZewgTheme {
  // Colors
  static const Color primary = Color(0xFF0D6E6E);
  static const Color primaryDark = Color(0xFF094F4F);
  static const Color primaryLight = Color(0xFFE6F2F2);
  static const Color background = Color(0xFFF2F4F6);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF0D1B1B);
  static const Color textSecondary = Color(0xFF6B7B7B);
  static const Color textMuted = Color(0xFF9AABAB);
  static const Color border = Color(0xFFE0E6E6);
  static const Color inputFill = Color(0xFFF0F2F2);
  static const Color badgeNew = Color(0xFFFF8C00);
  static const Color badgeInternship = Color(0xFF0D6E6E);
  static const Color badgeJob = Color(0xFF2E4057);
  static const Color badgeScholarship = Color(0xFF7B4F00);
  static const Color danger = Color(0xFFD32F2F);
  static const Color pendingOrange = Color(0xFFE07B00);

  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        background: background,
      ),
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.interTextTheme(),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        hintStyle: const TextStyle(color: textMuted, fontSize: 14),
        labelStyle: const TextStyle(
          color: textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      useMaterial3: true,
    );
  }
}
