import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/routing/navigation_helpers.dart';
import 'package:zewg/core/theme/app_button_styles.dart';

class ManageOpportunitiesPage extends StatelessWidget {
  const ManageOpportunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004D61)),
          onPressed: () => popOrGo(context, RoutePaths.onboardingScholarship),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Zewg', style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // --- ILLUSTRATION SECTION ---
                Center(
                  child: Container(
                    height: 340,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5F1F4), // Light blue background
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Main Dashboard Card
                        Positioned(
                          top: 50,
                          left: 40,
                          child: _buildDashboardCard(),
                        ),
                        
                        // "Completed" Badge
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4D2C00),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.verified, color: Colors.white, size: 14),
                                SizedBox(width: 4),
                                Text('COMPLETED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        
                        // "85% Goal Progress" Card
                        Positioned(
                          bottom: 40,
                          right: -10,
                          child: _buildProgressCard(),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // --- TEXT CONTENT ---
                const Text(
                  'Manage',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Color(0xFF1A1A1A)),
                ),
                const Text(
                  'Opportunities',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Color(0xFF004D61)),
                ),
                
                const SizedBox(height: 20),
                
                const Text(
                  'Keep track of your applications and mark opportunities as completed.',
                  style: TextStyle(fontSize: 18, color: Color(0xFF555555), height: 1.5),
                ),

                const SizedBox(height: 30),

                // --- PROGRESS DOTS (Dot - Dot - Bar) ---
                Row(
                  children: [
                    _buildDot(),
                    const SizedBox(width: 8),
                    _buildDot(),
                    const SizedBox(width: 8),
                    Container(
                      width: 30,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFF004D61),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // --- NEXT BUTTON ---
                ElevatedButton(
                  onPressed: () => context.go(RoutePaths.signIn),
                  style: primaryInteractiveButtonStyle(
                    backgroundColor: const Color(0xFF005F73),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 70),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 8,
                    shadowColor: const Color(0xFF005F73).withOpacity(0.4),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Next', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // --- SKIP BUTTON ---
                Center(
                  child: TextButton(
                    onPressed: ()=> context.go(RoutePaths.signIn),
                    child: const Text('Skip', style: TextStyle(color: Color(0xFF555555), fontSize: 16)),
                  ),
                ),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper for the "85%" card
  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('85%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF004D61))),
          Text('GOAL PROGRESS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
        ],
      ),
    );
  }

  // Helper for the Dashboard Card
  Widget _buildDashboardCard() {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFFCFDEE3), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.grid_view_rounded, size: 18, color: Color(0xFF004D61))),
              const SizedBox(width: 10),
              Container(width: 80, height: 10, decoration: BoxDecoration(color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(5))),
            ],
          ),
          const SizedBox(height: 20),
          _buildCardRow(true),
          const SizedBox(height: 12),
          _buildCardRow(false),
        ],
      ),
    );
  }

  Widget _buildCardRow(bool isActive) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: isActive ? const Border(left: BorderSide(color: Color(0xFF004D61), width: 4)) : null,
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 4, backgroundColor: Colors.grey),
          const SizedBox(width: 8),
          Container(width: 100, height: 8, decoration: BoxDecoration(color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(4))),
          const Spacer(),
          if (isActive) const Icon(Icons.check_circle, size: 14, color: Color(0xFF004D61)),
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFD1D5DB), shape: BoxShape.circle));
  }
}
