import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/theme/app_button_styles.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Replicating the soft blue-to-white gradient
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.0, 0.5),
            radius: 1.2,
            colors: [
              Color(0xFFE5F1F4), // Light blue center
              Colors.white,       // Fading to white
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // --- LOGO SECTION ---
              _buildLogoIcon(),

              const SizedBox(height: 40),

              // --- TEXT SECTION ---
              const Text(
                'Zewg',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF004D61),
                  letterSpacing: -1,
                ),
              ),
              const Text(
                'CONNECT TO OPPORTUNITIES',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A4A4A),
                  letterSpacing: 1.2,
                ),
              ),

              const Spacer(flex: 1),

              // --- GET STARTED BUTTON ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                  onPressed: () => context.go(RoutePaths.onboardingFuture),
                  style: primaryInteractiveButtonStyle(
                    backgroundColor: const Color(0xFF005B6E),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 75),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 10,
                    shadowColor: const Color(0xFF005B6E).withOpacity(0.5),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 24),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // --- FOOTER TEXT ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified_user_outlined, size: 16, color: Colors.grey[400]),
                  const SizedBox(width: 8),
                  Text(
                    'The Digital Curator for Students',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 1),

              // --- BOTTOM INDICATORS ---
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStepBar(true),
                    const SizedBox(width: 10),
                    _buildStepBar(false),
                    const SizedBox(width: 10),
                    _buildStepBar(false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build the stacked icon
  Widget _buildLogoIcon() {
    return SizedBox(
      height: 140,
      width: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main Teal Rounded Box
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF005B6E),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF005B6E).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.hub, // Closest match to the network/star icon
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          // Small Floating White Icon
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.unfold_more, // The double arrow icon
                color: Color(0xFF005B6E),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for the bottom bars
  Widget _buildStepBar(bool isActive) {
    return Container(
      width: 100,
      height: 3,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF004D61) : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

