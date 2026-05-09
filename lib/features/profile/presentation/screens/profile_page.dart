import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Zewg',
          style: TextStyle(
            color: Color(0xFF004D61),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            
            // Profile Image
            Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFE0E0E0),
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xFF43535E),
                  child: Icon(Icons.person, size: 80, color: Color(0xFFB0B0B0)),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Name and Role
            const Text(
              'Alex Morgan',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const Text(
              'STUDENT',
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 2.0,
                color: Color(0xFF006B7D),
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 40),

            // Statistics Grid (Submissions & Saved)
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('30', 'SUBMISSIONS', Icons.assignment_turned_in_outlined),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard('12', 'SAVED', Icons.assignment_turned_in_outlined),
                ),
              ],
            ),
            
            const SizedBox(height: 16),

            // Verified Identity Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.verified_outlined, color: Color(0xFF004D61), size: 32),
                  const SizedBox(height: 8),
                  const Text(
                    'Verified',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
                  ),
                  Text(
                    'IDENTITY',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // Logout Button
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                side: const BorderSide(color: Color(0xFFFFE0E0)),
                backgroundColor: const Color(0xFFFFF9F9),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Colors.redAccent, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Logout',
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF004D61), size: 28),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, 'HOME', false, () => context.go(RoutePaths.homeAll)),
          _buildNavItem(Icons.bookmark_outline, 'SAVED', false, () => context.go(RoutePaths.journey)),
          _buildNavItem(Icons.person, 'PROFILE', true, () => context.go(RoutePaths.profile)),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: const Color(0xFF006B7D),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? Colors.white : Colors.grey),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
