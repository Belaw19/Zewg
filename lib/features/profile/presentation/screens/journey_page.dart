import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';

class JourneyPage extends StatelessWidget {
  const JourneyPage({super.key});

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => context.go(RoutePaths.profile),
              behavior: HitTestBehavior.opaque,
              child: const CircleAvatar(
                backgroundColor: Color(0xFFE0E0E0),
                child: Icon(Icons.person, color: Color(0xFF4A4A4A)),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Your Journey',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tracking your curated academic and career opportunities.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF555555),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 30),
            
            // Toggle Switch
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Saved',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D61)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () => context.go(RoutePaths.applied),
                        behavior: HitTestBehavior.opaque,
                        child: const Text(
                          'Applied',
                          style: TextStyle(color: Color(0xFF666666)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Card 1: Global Leadership Program
            _buildOpportunityCard(
              icon: Icons.school_outlined,
              iconBg: const Color(0xFFD9E9F2),
              title: 'Global Leadership Program',
              subtitle: 'University of Oxford',
              tag: 'SAVED',
              tagBg: const Color(0xFFD9E9F2),
              tagTextColor: const Color(0xFF7B9FB6),
              isSaved: true,
            ),

            const SizedBox(height: 16),

            // Card 2: UX Design Research Intern
            _buildOpportunityCard(
              icon: Icons.work_outline,
              iconBg: const Color(0xFFFFEAD2),
              title: 'UX Design Research Intern',
              subtitle: 'Design Curators Ltd.',
              tag: 'IN REVIEW',
              tagBg: const Color(0xFF004D61),
              tagTextColor: Colors.white,
              footer: 'Applied 4 days ago',
              isSaved: false,
            ),

            const SizedBox(height: 16),

            // New Match Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF006B7D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.verified_outlined, color: Colors.white),
                      ),
                      const Text(
                        'NEW MATCH',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Editorial Fellowship 2024',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Based on your saved interests in academic publishing and design.',
                    style: TextStyle(color: Colors.white, height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go(RoutePaths.homeAll),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF004D61),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      child: const Text('Review Match', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, 'HOME', false, () => context.go(RoutePaths.homeAll)),
            _buildNavItem(Icons.bookmark, 'SAVED', true, () => context.go(RoutePaths.journey)),
            _buildNavItem(Icons.person_outline, 'PROFILE', false, () => context.go(RoutePaths.profile)),
          ],
        ),
      ),
    );
  }

  Widget _buildOpportunityCard({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    required String tag,
    required Color tagBg,
    required Color tagTextColor,
    String? footer,
    required bool isSaved,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF4A4A4A)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tagBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: TextStyle(color: tagTextColor, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (footer != null)
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(footer, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            )
          else
            SizedBox(
  width: 40, // Fixed width to contain the overlap
  height: 24,
  child: Stack(
    children: [
      const CircleAvatar(
        radius: 12, 
        backgroundColor: Color(0xFF2E4352),
      ),
      Positioned(
        left: 14, // This creates the overlap without negative widths
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const CircleAvatar(
            radius: 10, 
            backgroundColor: Color(0xFF1B2B36),
          ),
        ),
      ),
    ],
  ),
),
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
