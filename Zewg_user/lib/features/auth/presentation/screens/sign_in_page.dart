import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/theme/app_button_styles.dart';
import 'package:zewg/features/auth/domain/providers/auth_provider.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    await ref.read(authProvider.notifier).signIn(_emailCtrl.text, _passwordCtrl.text);
    // router redirect handles navigation automatically when auth state changes
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                'Zewg',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Color(0xFF004D61)),
              ),
              const Text(
                'The Digital Curator',
                style: TextStyle(fontSize: 16, color: Color(0xFF555555), letterSpacing: 0.5),
              ),
              const SizedBox(height: 60),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
                    ),
                    const SizedBox(height: 32),
                    _buildLabel('EMAIL ADDRESS'),
                    TextField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration('alex@zewg.com'),
                    ),
                    const SizedBox(height: 24),
                    _buildLabel('PASSWORD'),
                    TextField(
                      controller: _passwordCtrl,
                      obscureText: _obscure,
                      decoration: _inputDecoration('••••••••').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              color: const Color(0xFF555555)),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                    ),
                    if (auth.error != null) ...[
                      const SizedBox(height: 12),
                      Text(auth.error!, style: const TextStyle(color: Colors.red, fontSize: 13)),
                    ],
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: auth.isLoading ? null : _submit,
                      style: primaryInteractiveButtonStyle(
                        backgroundColor: const Color(0xFF005B6E),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 70),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        elevation: 6,
                        shadowColor: const Color(0xFF005B6E).withOpacity(0.4),
                      ),
                      child: auth.isLoading
                          ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Sign in', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward, color: Colors.white, size: 22),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Color(0xFF555555))),
                  GestureDetector(
                    onTap: () => context.go(RoutePaths.createAccount),
                    child: const Text('Sign Up',
                        style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold)),
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

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF555555), letterSpacing: 0.8)),
      );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
        filled: true,
        fillColor: const Color(0xFFE5E5E5).withOpacity(0.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      );
}
