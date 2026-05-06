import 'package:flutter/material.dart';

/// Application color palette based on Figma design
/// Primary color: Teal (#1A7B7B)
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors - Teal Palette
  static const Color primary = Color(0xFF1A7B7B);
  static const Color primaryLight = Color(0xFF4DA5A5);
  static const Color primaryDark = Color(0xFF0D5252);
  static const Color primaryContainer = Color(0xFFB2E0E0);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF006B6B);
  static const Color secondaryLight = Color(0xFF339999);
  static const Color secondaryDark = Color(0xFF004D4D);
  static const Color secondaryContainer = Color(0xFFCCF0F0);
  
  // Tertiary Colors
  static const Color tertiary = Color(0xFF7B5B1A);
  static const Color tertiaryLight = Color(0xFFA58547);
  static const Color tertiaryDark = Color(0xFF523D0D);
  static const Color tertiaryContainer = Color(0xFFE0D4B2);
  
  // Neutral Colors - Light Theme
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color background = Color(0xFFFAFAFA);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color onSurfaceVariant = Color(0xFF49454F);
  static const Color outline = Color(0xFF79747E);
  static const Color outlineVariant = Color(0xFFCAC4D0);
  
  // Neutral Colors - Dark Theme
  static const Color surfaceDark = Color(0xFF1C1B1F);
  static const Color surfaceVariantDark = Color(0xFF2B2930);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color onSurfaceDark = Color(0xFFE6E1E5);
  static const Color onSurfaceVariantDark = Color(0xFFCAC4D0);
  static const Color outlineDark = Color(0xFF938F99);
  static const Color outlineVariantDark = Color(0xFF49454F);
  
  // Semantic Colors
  static const Color error = Color(0xFFB3261E);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFF8B1A14);
  static const Color errorContainer = Color(0xFFF9DEDC);
  static const Color onError = Color(0xFFFFFFFF);
  
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFF66BB6A);
  static const Color successDark = Color(0xFF1B5E20);
  static const Color successContainer = Color(0xFFC8E6C9);
  
  static const Color warning = Color(0xFFF57C00);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFE65100);
  static const Color warningContainer = Color(0xFFFFE0B2);
  
  static const Color info = Color(0xFF0288D1);
  static const Color infoLight = Color(0xFF4FC3F7);
  static const Color infoDark = Color(0xFF01579B);
  static const Color infoContainer = Color(0xFFB3E5FC);
  
  // Text Colors - Light Theme
  static const Color textPrimary = Color(0xFF1C1B1F);
  static const Color textSecondary = Color(0xFF49454F);
  static const Color textTertiary = Color(0xFF79747E);
  static const Color textDisabled = Color(0xFFCAC4D0);
  
  // Text Colors - Dark Theme
  static const Color textPrimaryDark = Color(0xFFE6E1E5);
  static const Color textSecondaryDark = Color(0xFFCAC4D0);
  static const Color textTertiaryDark = Color(0xFF938F99);
  static const Color textDisabledDark = Color(0xFF49454F);
  
  // Overlay Colors
  static const Color scrim = Color(0xFF000000);
  static const Color shadow = Color(0xFF000000);
  
  // Opportunity Type Colors
  static const Color scholarshipColor = Color(0xFF1A7B7B);
  static const Color internshipColor = Color(0xFF7B5B1A);
  static const Color jobColor = Color(0xFF5B1A7B);
  
  // Application Status Colors
  static const Color statusDraft = Color(0xFF79747E);
  static const Color statusSubmitted = Color(0xFF0288D1);
  static const Color statusUnderReview = Color(0xFFF57C00);
  static const Color statusAccepted = Color(0xFF2E7D32);
  static const Color statusRejected = Color(0xFFB3261E);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
