import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';

class CreateAccountPage extends StatelessWidget {
  // Global key to manage the form state without a StatefulWidget
  final _formKey = GlobalKey<FormState>();

  CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey, // Wrap the Column in a Form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text('Zewg', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF004D61))),
                const SizedBox(height: 30),
                const Text('Create Account', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
                const SizedBox(height: 8),
                const Text('Enter your details to start your journey.', style: TextStyle(fontSize: 16, color: Color(0xFF555555))),

                const SizedBox(height: 40),

                _buildLabel('Full Name'),
                _buildTextField('Alex Morgan'),

                const SizedBox(height: 24),

                _buildLabel('Email Address'),
                _buildTextField('Alex@zewg.com'),

                const SizedBox(height: 24),

                _buildLabel('I am a...'),
                _buildStudentChip(),

                const SizedBox(height: 24),

                _buildLabel('Password'),
                // The Password field now uses TextFormField for validation
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Weak password. Must include at least 8 characters and one symbol.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    filled: true,
                    fillColor: const Color(0xFFE8E8E8),
                    // Style for when there is an error
                    errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),

                const SizedBox(height: 40),

                // --- CREATE ACCOUNT BUTTON ---
                ElevatedButton(
                  onPressed: () {
                    // This triggers the red border ONLY if the field is empty
                    if (_formKey.currentState!.validate()) {
                      // If form is valid, proceed
                      context.go(RoutePaths.homeAll);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005B6E),
                    minimumSize: const Size(double.infinity, 75),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    elevation: 8,
                    shadowColor: const Color(0xFF005B6E).withOpacity(0.4),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Create Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(width: 12),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 24),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                _buildFooter(),
                const SizedBox(height: 60),
                _buildPartnerFooter(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF4A4A4A))),
    );
  }

  Widget _buildTextField(String hint) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFE8E8E8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }

  Widget _buildStudentChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      decoration: BoxDecoration(color: const Color(0xFFD9E9F2), borderRadius: BorderRadius.circular(100)),
      child: const Text('Student', style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: RichText(
        text: const TextSpan(
          style: TextStyle(color: Color(0xFF555555), fontSize: 14),
          children: [
            TextSpan(text: 'Already have an account? '),
            TextSpan(text: 'Sign In', style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('VERIFIED PARTNER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.5)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
        ),
        const Text('SECURE GATEWAY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.5)),
      ],
    );
  }
}
