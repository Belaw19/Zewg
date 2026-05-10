import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/theme/app_button_styles.dart';
// import 'package:zewg/features/auth/presentation/widgets/admin_login_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              
              // --- APP LOGO & SUBTITLE ---
              const Text(
                'Zewg',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF004D61),
                ),
              ),
              const Text(
                'The Digital Curator',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF555555),
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 60),

              // --- LOGIN CARD ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Email Field
                    _buildLabel('EMAIL ADDRESS'),
                    _buildTextField(
                      hintText: 'curator@zewg.com',
                      obscureText: false,
                    ),

                    const SizedBox(height: 24),

                    // Password Field
                    _buildLabel('PASSWORD'),
                    _buildTextField(
                      hintText: '••••••••',
                      obscureText: true,
                      suffixIcon: Icons.visibility_outlined,
                    ),

                    const SizedBox(height: 40),

                    // Sign In Button
                    ElevatedButton(
                      onPressed: () => context.go(RoutePaths.homeAll),
                      style: primaryInteractiveButtonStyle(
                        backgroundColor: const Color(0xFF005B6E),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: 6,
                        shadowColor: const Color(0xFF005B6E).withOpacity(0.4),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 22),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // --- FOOTER LINKS ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Color(0xFF555555)),
                  ),
                  GestureDetector(
                    onTap: () => context.go(RoutePaths.createAccount),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF004D61),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFF555555),
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required bool obscureText,
    IconData? suffixIcon,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
        filled: true,
        fillColor: const Color(0xFFE5E5E5).withOpacity(0.5),
        suffixIcon: suffixIcon != null 
            ? Icon(suffixIcon, color: const Color(0xFF555555)) 
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
