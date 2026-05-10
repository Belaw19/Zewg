import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/routing/navigation_helpers.dart';

class EditOpportunityPage extends StatefulWidget {
  const EditOpportunityPage({super.key});

  @override
  State<EditOpportunityPage> createState() => _EditOpportunityPageState();
}

class _EditOpportunityPageState extends State<EditOpportunityPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'INTERNSHIP';
  bool _isPublished = true;

  static const _types = ['INTERNSHIP', 'JOB', 'SCHOLARSHIP'];

  static const _typeColors = {
    'INTERNSHIP': Color(0xFFA2F1A2),
    'JOB': Color(0xFFD4E5EF),
    'SCHOLARSHIP': Color(0xFFFDE2C4),
  };

  // Pre-filled values simulating editing an existing opportunity
  final _titleController = TextEditingController(text: 'UX Design Research Intern');
  final _orgController = TextEditingController(text: 'Design Curators Ltd.');
  final _locationController = TextEditingController(text: 'Remote');
  final _deadlineController = TextEditingController(text: 'Nov 15');
  final _linkController = TextEditingController(text: 'https://opportunity.com/apply');
  final _descController = TextEditingController(
    text: 'Join our team as a UX Design Research Intern and help shape the future of student-facing products. You will conduct user interviews, synthesize findings, and collaborate with designers.',
  );

  @override
  void dispose() {
    _titleController.dispose();
    _orgController.dispose();
    _locationController.dispose();
    _deadlineController.dispose();
    _linkController.dispose();
    _descController.dispose();
    super.dispose();
  }

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () => _showDeleteDialog(context),
              child: const Text('Delete', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
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
                'Edit Opportunity',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A)),
              ),
              const SizedBox(height: 6),
              const Text(
                'Update the details of this opportunity.',
                style: TextStyle(fontSize: 15, color: Color(0xFF555555)),
              ),
              const SizedBox(height: 28),

              _buildLabel('Title'),
              _buildTextField(_titleController),
              const SizedBox(height: 16),

              _buildLabel('Organization'),
              _buildTextField(_orgController),
              const SizedBox(height: 16),

              _buildLabel('Location'),
              _buildTextField(_locationController),
              const SizedBox(height: 16),

              _buildLabel('Deadline'),
              _buildTextField(_deadlineController),
              const SizedBox(height: 16),

              _buildLabel('Application Link'),
              _buildTextField(_linkController),
              const SizedBox(height: 16),

              _buildLabel('Description'),
              TextFormField(
                controller: _descController,
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
                    _isPublished ? 'Published' : 'Draft',
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
                  child: const Text('Save Changes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Opportunity', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to delete this opportunity? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF004D61))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go(RoutePaths.curatorDashboard);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
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

  Widget _buildTextField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(''),
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
