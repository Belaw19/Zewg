import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';

Widget buildMainBottomNav(BuildContext context, {required bool isHome}) {
  return Container(
    height: 90,
    decoration: BoxDecoration(
      color: const Color(0xFFF8F9FB),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        mainBottomNavItem(Icons.home, 'HOME', isActive: isHome, onTap: () => context.go(RoutePaths.homeAll)),
        mainBottomNavItem(Icons.bookmark_border, 'SAVED', isActive: false, onTap: () => context.go(RoutePaths.journey)),
        mainBottomNavItem(Icons.person_outline, 'PROFILE', isActive: false, onTap: () => context.go(RoutePaths.profile)),
      ],
    ),
  );
}

Widget mainBottomNavItem(IconData icon, String label, {required bool isActive, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF005B71) : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: isActive ? Colors.white : Colors.black54),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isActive ? const Color(0xFF005B71) : Colors.black54,
          ),
        ),
      ],
    ),
  );
}
