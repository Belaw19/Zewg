import 'package:flutter/material.dart';
// import 'app_colors.dart';
// import 'app_text_styles.dart';

/// Material 3 theme configuration for the Zewg application
ThemeData buildAppTheme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFFFAF9FB),
  );
}

// class AppTheme {
//   // Private constructor to prevent instantiation
//   AppTheme._();

//   /// Light theme configuration
//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
      
//       // Color Scheme
//       colorScheme: const ColorScheme.light(
//         primary: AppColors.primary,
//         onPrimary: Colors.white,
//         primaryContainer: AppColors.primaryContainer,
//         onPrimaryContainer: AppColors.primaryDark,
        
//         secondary: AppColors.secondary,
//         onSecondary: Colors.white,
//         secondaryContainer: AppColors.secondaryContainer,
//         onSecondaryContainer: AppColors.secondaryDark,
        
//         tertiary: AppColors.tertiary,
//         onTertiary: Colors.white,
//         tertiaryContainer: AppColors.tertiaryContainer,
//         onTertiaryContainer: AppColors.tertiaryDark,
        
//         error: AppColors.error,
//         onError: AppColors.onError,
//         errorContainer: AppColors.errorContainer,
//         onErrorContainer: AppColors.errorDark,
        
//         surface: AppColors.surface,
//         onSurface: AppColors.onSurface,
        
//         outline: AppColors.outline,
//         outlineVariant: AppColors.outlineVariant,
        
//         shadow: AppColors.shadow,
//         scrim: AppColors.scrim,
//       ),
      
//       // Typography
//       textTheme: TextTheme(
//         displayLarge: AppTextStyles.displayLarge,
//         displayMedium: AppTextStyles.displayMedium,
//         displaySmall: AppTextStyles.displaySmall,
//         headlineLarge: AppTextStyles.headlineLarge,
//         headlineMedium: AppTextStyles.headlineMedium,
//         headlineSmall: AppTextStyles.headlineSmall,
//         titleLarge: AppTextStyles.titleLarge,
//         titleMedium: AppTextStyles.titleMedium,
//         titleSmall: AppTextStyles.titleSmall,
//         bodyLarge: AppTextStyles.bodyLarge,
//         bodyMedium: AppTextStyles.bodyMedium,
//         bodySmall: AppTextStyles.bodySmall,
//         labelLarge: AppTextStyles.labelLarge,
//         labelMedium: AppTextStyles.labelMedium,
//         labelSmall: AppTextStyles.labelSmall,
//       ),
      
//       // AppBar Theme
//       appBarTheme: AppBarTheme(
//         elevation: 0,
//         centerTitle: false,
//         backgroundColor: AppColors.surface,
//         foregroundColor: AppColors.onSurface,
//         surfaceTintColor: AppColors.primary,
//         titleTextStyle: AppTextStyles.titleLarge,
//         iconTheme: const IconThemeData(
//           color: AppColors.onSurface,
//           size: 24,
//         ),
//       ),
      
//       // Card Theme
//       cardTheme: const CardThemeData(
//         elevation: 1,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(12)),
//         ),
//         color: AppColors.surface,
//         surfaceTintColor: AppColors.primary,
//         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
      
//       // Input Decoration Theme
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: AppColors.surfaceVariant,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.outline),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.outline),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.primary, width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.error),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.error, width: 2),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         hintStyle: AppTextStyles.bodyMedium.copyWith(
//           color: AppColors.textTertiary,
//         ),
//         labelStyle: AppTextStyles.bodyMedium.copyWith(
//           color: AppColors.textSecondary,
//         ),
//         errorStyle: AppTextStyles.bodySmall.copyWith(
//           color: AppColors.error,
//         ),
//       ),
      
//       // Elevated Button Theme
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           elevation: 2,
//           backgroundColor: AppColors.primary,
//           foregroundColor: Colors.white,
//           disabledBackgroundColor: AppColors.outline,
//           disabledForegroundColor: AppColors.textDisabled,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           minimumSize: const Size(88, 48),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: AppTextStyles.buttonText,
//         ),
//       ),
      
//       // Outlined Button Theme
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: AppColors.primary,
//           disabledForegroundColor: AppColors.textDisabled,
//           side: const BorderSide(color: AppColors.primary, width: 1),
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           minimumSize: const Size(88, 48),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: AppTextStyles.buttonText,
//         ),
//       ),
      
//       // Text Button Theme
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           foregroundColor: AppColors.primary,
//           disabledForegroundColor: AppColors.textDisabled,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           minimumSize: const Size(64, 48),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: AppTextStyles.buttonText,
//         ),
//       ),
      
//       // Floating Action Button Theme
//       floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         elevation: 4,
//         backgroundColor: AppColors.primary,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//       ),
      
//       // Chip Theme
//       chipTheme: ChipThemeData(
//         backgroundColor: AppColors.surfaceVariant,
//         selectedColor: AppColors.primaryContainer,
//         disabledColor: AppColors.outlineVariant,
//         labelStyle: AppTextStyles.labelMedium,
//         secondaryLabelStyle: AppTextStyles.labelSmall,
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
      
//       // Bottom Navigation Bar Theme
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: AppColors.surface,
//         selectedItemColor: AppColors.primary,
//         unselectedItemColor: AppColors.textSecondary,
//         selectedLabelStyle: AppTextStyles.labelSmall,
//         unselectedLabelStyle: AppTextStyles.labelSmall,
//         type: BottomNavigationBarType.fixed,
//         elevation: 8,
//       ),
      
//       // Snackbar Theme
//       snackBarTheme: SnackBarThemeData(
//         backgroundColor: AppColors.onSurface,
//         contentTextStyle: AppTextStyles.bodyMedium.copyWith(
//           color: AppColors.surface,
//         ),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
      
//       // Dialog Theme
//       dialogTheme: const DialogThemeData(
//         backgroundColor: AppColors.surface,
//         surfaceTintColor: AppColors.primary,
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//       ),
      
//       // Divider Theme
//       dividerTheme: const DividerThemeData(
//         color: AppColors.outlineVariant,
//         thickness: 1,
//         space: 1,
//       ),
      
//       // Icon Theme
//       iconTheme: const IconThemeData(
//         color: AppColors.onSurface,
//         size: 24,
//       ),
//     );
//   }

//   /// Dark theme configuration
//   static ThemeData get darkTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
      
//       // Color Scheme
//       colorScheme: const ColorScheme.dark(
//         primary: AppColors.primaryLight,
//         onPrimary: AppColors.primaryDark,
//         primaryContainer: AppColors.primaryDark,
//         onPrimaryContainer: AppColors.primaryContainer,
        
//         secondary: AppColors.secondaryLight,
//         onSecondary: AppColors.secondaryDark,
//         secondaryContainer: AppColors.secondaryDark,
//         onSecondaryContainer: AppColors.secondaryContainer,
        
//         tertiary: AppColors.tertiaryLight,
//         onTertiary: AppColors.tertiaryDark,
//         tertiaryContainer: AppColors.tertiaryDark,
//         onTertiaryContainer: AppColors.tertiaryContainer,
        
//         error: AppColors.errorLight,
//         onError: AppColors.errorDark,
//         errorContainer: AppColors.errorDark,
//         onErrorContainer: AppColors.errorContainer,
        
//         surface: AppColors.surfaceDark,
//         onSurface: AppColors.onSurfaceDark,
        
//         outline: AppColors.outlineDark,
//         outlineVariant: AppColors.outlineVariantDark,
        
//         shadow: AppColors.shadow,
//         scrim: AppColors.scrim,
//       ),
      
//       // Typography
//       textTheme: TextTheme(
//         displayLarge: AppTextStyles.displayLargeDark,
//         displayMedium: AppTextStyles.displayMediumDark,
//         displaySmall: AppTextStyles.displaySmallDark,
//         headlineLarge: AppTextStyles.headlineLargeDark,
//         headlineMedium: AppTextStyles.headlineMediumDark,
//         headlineSmall: AppTextStyles.headlineSmallDark,
//         titleLarge: AppTextStyles.titleLargeDark,
//         titleMedium: AppTextStyles.titleMediumDark,
//         titleSmall: AppTextStyles.titleSmallDark,
//         bodyLarge: AppTextStyles.bodyLargeDark,
//         bodyMedium: AppTextStyles.bodyMediumDark,
//         bodySmall: AppTextStyles.bodySmallDark,
//         labelLarge: AppTextStyles.labelLargeDark,
//         labelMedium: AppTextStyles.labelMediumDark,
//         labelSmall: AppTextStyles.labelSmallDark,
//       ),
      
//       // AppBar Theme
//       appBarTheme: AppBarTheme(
//         elevation: 0,
//         centerTitle: false,
//         backgroundColor: AppColors.surfaceDark,
//         foregroundColor: AppColors.onSurfaceDark,
//         surfaceTintColor: AppColors.primaryLight,
//         titleTextStyle: AppTextStyles.titleLargeDark,
//         iconTheme: const IconThemeData(
//           color: AppColors.onSurfaceDark,
//           size: 24,
//         ),
//       ),
      
//       // Card Theme
//       cardTheme: const CardThemeData(
//         elevation: 1,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(12)),
//         ),
//         color: AppColors.surfaceDark,
//         surfaceTintColor: AppColors.primaryLight,
//         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
      
//       // Input Decoration Theme
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: AppColors.surfaceVariantDark,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.outlineDark),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.outlineDark),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.errorLight),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.errorLight, width: 2),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         hintStyle: AppTextStyles.bodyMediumDark.copyWith(
//           color: AppColors.textTertiaryDark,
//         ),
//         labelStyle: AppTextStyles.bodyMediumDark.copyWith(
//           color: AppColors.textSecondaryDark,
//         ),
//         errorStyle: AppTextStyles.bodySmallDark.copyWith(
//           color: AppColors.errorLight,
//         ),
//       ),
      
//       // Elevated Button Theme
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           elevation: 2,
//           backgroundColor: AppColors.primaryLight,
//           foregroundColor: AppColors.primaryDark,
//           disabledBackgroundColor: AppColors.outlineDark,
//           disabledForegroundColor: AppColors.textDisabledDark,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           minimumSize: const Size(88, 48),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: AppTextStyles.buttonText,
//         ),
//       ),
      
//       // Outlined Button Theme
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: AppColors.primaryLight,
//           disabledForegroundColor: AppColors.textDisabledDark,
//           side: const BorderSide(color: AppColors.primaryLight, width: 1),
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           minimumSize: const Size(88, 48),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: AppTextStyles.buttonText,
//         ),
//       ),
      
//       // Text Button Theme
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           foregroundColor: AppColors.primaryLight,
//           disabledForegroundColor: AppColors.textDisabledDark,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           minimumSize: const Size(64, 48),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: AppTextStyles.buttonText,
//         ),
//       ),
      
//       // Floating Action Button Theme
//       floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         elevation: 4,
//         backgroundColor: AppColors.primaryLight,
//         foregroundColor: AppColors.primaryDark,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//       ),
      
//       // Chip Theme
//       chipTheme: ChipThemeData(
//         backgroundColor: AppColors.surfaceVariantDark,
//         selectedColor: AppColors.primaryDark,
//         disabledColor: AppColors.outlineVariantDark,
//         labelStyle: AppTextStyles.labelMediumDark,
//         secondaryLabelStyle: AppTextStyles.labelSmallDark,
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
      
//       // Bottom Navigation Bar Theme
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: AppColors.surfaceDark,
//         selectedItemColor: AppColors.primaryLight,
//         unselectedItemColor: AppColors.textSecondaryDark,
//         selectedLabelStyle: AppTextStyles.labelSmallDark,
//         unselectedLabelStyle: AppTextStyles.labelSmallDark,
//         type: BottomNavigationBarType.fixed,
//         elevation: 8,
//       ),
      
//       // Snackbar Theme
//       snackBarTheme: SnackBarThemeData(
//         backgroundColor: AppColors.onSurfaceDark,
//         contentTextStyle: AppTextStyles.bodyMediumDark.copyWith(
//           color: AppColors.surfaceDark,
//         ),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
      
//       // Dialog Theme
//       dialogTheme: const DialogThemeData(
//         backgroundColor: AppColors.surfaceDark,
//         surfaceTintColor: AppColors.primaryLight,
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//       ),
      
//       // Divider Theme
//       dividerTheme: const DividerThemeData(
//         color: AppColors.outlineVariantDark,
//         thickness: 1,
//         space: 1,
//       ),
      
//       // Icon Theme
//       iconTheme: const IconThemeData(
//         color: AppColors.onSurfaceDark,
//         size: 24,
//       ),
//     );
//   }
// }
