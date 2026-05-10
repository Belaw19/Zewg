import 'package:flutter/material.dart';

/// Local asset hero for onboarding; shows a soft placeholder if the file is missing or invalid.
Widget buildOnboardingHeroImage(
  String assetPath, {
  double height = 340,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(40),
    child: Image.asset(
      assetPath,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          width: double.infinity,
          color: const Color(0xFFE5F1F4),
          alignment: Alignment.center,
          child: Icon(Icons.image_outlined, size: 48, color: Colors.grey[400]),
        );
      },
    ),
  );
}
