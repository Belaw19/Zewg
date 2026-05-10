import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/routing/navigation_helpers.dart';

class AddOpportunityPage extends StatefulWidget {
  const AddOpportunityPage({super.key});

  @override
  State<AddOpportunityPage> createState() => _AddOpportunityPageState();
}

class _AddOpportunityPageState extends State<AddOpportunityPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'INTERNSHIP';
  bool _isPublished = false;

  static const _types = ['INTERNSHIP', 'JOB', 'SCHOLARSHIP'];

  static const _typeColors = {
    'INTERNSHIP': Color(0xFFA2F1A2),
    'JOB': Color(0xFFD4E5EF),
    'SCHOLARSHIP': Color(0xFFFDE2C4),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004D61)),
          onPressed: () => popOrGo(context, RoutePaths.curatorDashboard),
        ),
        title: const Text(
          'Zewg',
          style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Add Opportunity',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A)),
              ),
              const SizedBox(height: 6),
              const Text(
                'Fill in the details to publish a new opportunity.',
                style: TextStyle(fontSize: 15, color: Color(0xFF555555)),
              ),
              const SizedBox(height: 28),

              _buildLabel('Title'),
              _buildTextField('e.g. UX Design Research Intern'),
              const SizedBox(height: 16),

              _buildLabel('Organization'),
              _buildTextField('e.g. Google, UNICEF'),
              const SizedBox(height: 16),

              _buildLabel('Location'),
              _buildTextField('e.g. Remote, Addis Ababa'),
              const SizedBox(height: 16),

              _buildLabel('Deadline'),
              _buildTextField('e.g. Nov 30, 2025'),
              const SizedBox(height: 16),

              _buildLabel('Application Link'),
              _buildTextField('https://'),
              const SizedBox(height: 16),

              _buildLabel('Description'),
              TextFormField(
                maxLines: 5,
                decoration: _inputDecoration('Describe the opportunity...'),
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 20),

              _buildLabel('Type'),
              const SizedBox(height: 10),
              Row(
                children: _types.map((type) {
                  final isSelected = _selectedType == type;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedType = type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? _typeColors[type] : const Color(0xFFF0F0F2),
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected ? Border.all(color: const Color(0xFF004D61).withOpacity(0.3)) : null,
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? const Color(0xFF004D61) : const Color(0xFF888888),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Switch(
                    value: _isPublished,
                    onChanged: (v) => setState(() => _isPublished = v),
                    activeColor: const Color(0xFF004D61),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _isPublished ? 'Publish immediately' : 'Save as draft',
                    style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.go(RoutePaths.curatorDashboard);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004D61),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text(
                    _isPublished ? 'Publish Opportunity' : 'Save as Draft',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF444444), letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextFormField(
      decoration: _inputDecoration(hint),
      validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFEEEEEE))),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFEEEEEE))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF004D61))),
    );
  }
}
