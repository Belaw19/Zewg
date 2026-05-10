// import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// import 'app_colors.dart';

// /// Typography system for the Zewg application
// /// Based on Material 3 type scale
// class AppTextStyles {
//   // Private constructor to prevent instantiation
//   AppTextStyles._();



//   // Display Styles - Large, prominent text
//   static TextStyle displayLarge = GoogleFonts.inter(
//     fontSize: 57,
//     fontWeight: FontWeight.w400,
//     letterSpacing: -0.25,
//     height: 1.12,
//     color: AppColors.textPrimary,
//   );

//   static TextStyle displayMedium = GoogleFonts.inter(
//     fontSize: 45,
//     fontWeight: FontWeight.w400,
//     letterSpacing: 0,
//     height: 1.16,
//     color: AppColors.textPrimary,
//   );

//   static TextStyle displaySmall = GoogleFonts.inter(
//     fontSize: 36,
//     fontWeight: FontWeight.w400,
//     letterSpacing: 0,
//     height: 1.22,
//     color: AppColors.textPrimary,
//   );

//   // Headline Styles - High-emphasis text
//   static TextStyle headlineLarge = GoogleFonts.inter(
//     fontSize: 32,
//     fontWeight: FontWeight.w600,
//     letterSpacing: 0,
//     height: 1.25,
//     color: AppColors.textPrimary,
//   );

//   static TextStyle headlineMedium = GoogleFonts.inter(
//     fontSize: 28,
//     fontWeight: FontWeight.w600,
//     letterSpacing: 0,
//     height: 1.29,
//     color: AppColors.textPrimary,
//   );

//   static TextStyle headlineSmall = GoogleFonts.inter(
//     fontSize: 24,
//     fontWeight: FontWeight.w600,
//     letterSpacing: 0,
//     height: 1.33,
//     color: AppColors.textPrimary,
//   );

//   // Title Styles - Medium-emphasis text
//   static TextStyle titleLarge = GoogleFonts.inter(
//     fontSize: 22,
//     fontWeight: FontWeight.w500,
//     letterSpacing: 0,
//     height: 1.27,
//     color: AppColors.textPrimary,
//   );

//   static TextStyle titleMedium = GoogleFonts.inter(
//     fontSize: 16,
//     fontWeight: FontWeight.w500,
//     letterSpacing: 0.15,
//     height: 1.5,
//     color: AppColors.textPrimary,
//   );

//   static TextStyle titleSmall = GoogleFonts.inter(
//     fontSize: 14,
//     fontWeight: FontWeight.w500,
//     letterSpacing: 0.1,
//     height: 1.43,
//     color: AppColors.textPrimary,
//   );

//   // Body Styles - Main content text
//   static TextStyle bodyLarge = GoogleFonts.inter(
//     fontSize: 16,
//     fontWeight: FontWeight.w400,
//     letterSpacing: 0.5,
//     height: 1.5,
//     color: AppColors.textPrimary,
//   );

//   static TextStyle bodyMedium = GoogleFonts.inter(
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//     letterSpacing: 0.25,
//     height: 1.43,
//     color: AppColors.textPrimary,
//   );

//   static TextStyle bodySmall = GoogleFonts.inter(
//     fontSize: 12,
//     fontWeight: FontWeight.w400,
//     letterSpacing: 0.4,
//     height: 1.33,
//     color: AppColors.textSecondary,
//   );

//   // Label Styles - Buttons, tabs, and other UI elements
//   static TextStyle labelLarge = GoogleFonts.inter(
//     fontSize: 14,
//     fontWeight: FontWeight.w500,
//     letterSpacing: 0.1,
//     height: 1.43,
//     color: AppColors.textPrimary,
//   );

//   static TextStyle labelMedium = GoogleFonts.inter(
//     fontSize: 12,
//     fontWeight: FontWeight.w500,
//     letterSpacing: 0.5,
//     height: 1.33,
//     color: AppColors.textPrimary,
//   );

//   static TextStyle labelSmall = GoogleFonts.inter(
//     fontSize: 11,
//     fontWeight: FontWeight.w500,
//     letterSpacing: 0.5,
//     height: 1.45,
//     color: AppColors.textSecondary,
//   );

//   // Custom Styles for specific use cases
//   static TextStyle buttonText = GoogleFonts.inter(
//     fontSize: 14,
//     fontWeight: FontWeight.w600,
//     letterSpacing: 0.1,
//     height: 1.43,
//   );

//   static TextStyle caption = GoogleFonts.inter(
//     fontSize: 12,
//     fontWeight: FontWeight.w400,
//     letterSpacing: 0.4,
//     height: 1.33,
//     color: AppColors.textSecondary,
//   );

//   static TextStyle overline = GoogleFonts.inter(
//     fontSize: 10,
//     fontWeight: FontWeight.w500,
//     letterSpacing: 1.5,
//     height: 1.6,
//     color: AppColors.textSecondary,
//   );

//   // Dark theme variants
//   static TextStyle displayLargeDark = displayLarge.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle displayMediumDark = displayMedium.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle displaySmallDark = displaySmall.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle headlineLargeDark = headlineLarge.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle headlineMediumDark = headlineMedium.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle headlineSmallDark = headlineSmall.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle titleLargeDark = titleLarge.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle titleMediumDark = titleMedium.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle titleSmallDark = titleSmall.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle bodyLargeDark = bodyLarge.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle bodyMediumDark = bodyMedium.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle bodySmallDark = bodySmall.copyWith(
//     color: AppColors.textSecondaryDark,
//   );

//   static TextStyle labelLargeDark = labelLarge.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle labelMediumDark = labelMedium.copyWith(
//     color: AppColors.textPrimaryDark,
//   );

//   static TextStyle labelSmallDark = labelSmall.copyWith(
//     color: AppColors.textSecondaryDark,
//   );

//   static TextStyle captionDark = caption.copyWith(
//     color: AppColors.textSecondaryDark,
//   );

//   static TextStyle overlineDark = overline.copyWith(
//     color: AppColors.textSecondaryDark,
//   );
// }
