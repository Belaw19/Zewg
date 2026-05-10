import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/onboarding_assets.dart';
import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/routing/navigation_helpers.dart';
import 'package:zewg/core/theme/app_button_styles.dart';
import 'package:zewg/core/widgets/onboarding_hero_image.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004D61)),
          onPressed: () => popOrGo(context, RoutePaths.welcome),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Zewg',
              style: TextStyle(
                color: Color(0xFF004D61),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      // We use SafeArea and SingleChildScrollView to prevent the overflow error
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // Image Stack Section
                Center(
                  child: SizedBox(
                    height: 380,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        // Main Background Image (replace assets/images/onboarding/onboarding_future.png)
                        buildOnboardingHeroImage(OnboardingAssets.futureHero),
                        
                        // Floating "New Opportunity" Card
                        Positioned(
                          bottom: 60,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF006B7D),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.work_outline, color: Colors.white, size: 24),
                                ),
                                const SizedBox(width: 12),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'NEW OPPORTUNITY',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Text(
                                      'UX Design Intern',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1A1A1A),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),

                        // Small Circle Check Icon
                        Positioned(
                          bottom: 30,
                          left: 70,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.check, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Text Content
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A1A),
                    ),
                    children: [
                      TextSpan(text: 'Find Your '),
                      TextSpan(
                        text: 'Future',
                        style: TextStyle(color: Color(0xFF004D61)),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 15),
                
                const Text(
                  'Browse curated jobs, internships, and scholarships tailored for students.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF555555),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 25),

                // Progress Indicators (Dots)
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFF004D61),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildDot(),
                    const SizedBox(width: 8),
                    _buildDot(),
                  ],
                ),

                // Replaced Spacer with fixed SizedBox to avoid push-out overflow
                const SizedBox(height: 50),

                // Primary Button
                ElevatedButton(
                  onPressed: () => context.go(RoutePaths.onboardingScholarship),
                  style: primaryInteractiveButtonStyle(
                    backgroundColor: const Color(0xFF005F73),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    shadowColor: const Color(0xFF005F73).withOpacity(0.4),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Skip Button
                Center(
                  child: TextButton(
                    onPressed: () => context.go(RoutePaths.signIn),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 16,
                      ),
                    ),
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

  Widget _buildDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Color(0xFFD1D5DB),
        shape: BoxShape.circle,
      ),
    );
  }
}
