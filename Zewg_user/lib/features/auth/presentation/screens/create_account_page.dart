import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/theme/app_button_styles.dart';
import 'package:zewg/features/auth/domain/providers/auth_provider.dart';

class CreateAccountPage extends ConsumerStatefulWidget {
  const CreateAccountPage({super.key});

  @override
  ConsumerState<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends ConsumerState<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await ref
        .read(authProvider.notifier)
        .signUp(_nameCtrl.text, _emailCtrl.text, _passwordCtrl.text);
    if (ok && mounted) context.go(RoutePaths.homeAll);
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text('Zewg',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF004D61))),
                const SizedBox(height: 30),
                const Text('Create Account',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
                const SizedBox(height: 8),
                const Text('Enter your details to start your journey.',
                    style: TextStyle(fontSize: 16, color: Color(0xFF555555))),
                const SizedBox(height: 40),
                _buildLabel('Full Name'),
                TextFormField(
                  controller: _nameCtrl,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required.' : null,
                  decoration: _inputDecoration('Alex Morgan'),
                ),
                const SizedBox(height: 24),
                _buildLabel('Email Address'),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) =>
                      (v == null || !v.contains('@')) ? 'Enter a valid email.' : null,
                  decoration: _inputDecoration('alex@zewg.com'),
                ),
                const SizedBox(height: 24),
                _buildLabel('I am a...'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD9E9F2), borderRadius: BorderRadius.circular(100)),
                  child: const Text('Student',
                      style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 24),
                _buildLabel('Password'),
                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: true,
                  validator: (v) => (v == null || v.length < 8)
                      ? 'Weak password. Must be at least 8 characters.'
                      : null,
                  decoration: _inputDecoration('Enter Password').copyWith(
                    errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red, width: 2)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red, width: 2)),
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
                    minimumSize: const Size(double.infinity, 75),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    elevation: 8,
                    shadowColor: const Color(0xFF005B6E).withOpacity(0.4),
                  ),
                  child: auth.isLoading
                      ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Create Account',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(width: 12),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 24),
                          ],
                        ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Already have an account? ',
                          style: TextStyle(color: Color(0xFF555555), fontSize: 14)),
                      GestureDetector(
                        onTap: () => context.go(RoutePaths.signIn),
                        child: const Text('Sign In',
                            style: TextStyle(
                                color: Color(0xFF004D61), fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF4A4A4A))),
      );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFE8E8E8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.all(20),
      );
}
