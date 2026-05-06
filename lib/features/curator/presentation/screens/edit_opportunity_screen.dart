import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class EditOpportunityScreen extends StatefulWidget {
  final String opportunityId;

  const EditOpportunityScreen({
    super.key,
    required this.opportunityId,
  });

  @override
  State<EditOpportunityScreen> createState() => _EditOpportunityScreenState();
}

class _EditOpportunityScreenState extends State<EditOpportunityScreen> {
  final _titleController = TextEditingController(text: 'Senior UX Research Intern');
  final _categoryController = TextEditingController();
  final _jobController = TextEditingController(text: 'UX Research');
  final _deadlineController = TextEditingController(text: '10/24/2023');
  final _locationController = TextEditingController(text: 'San Francisco, CA');
  final _requirementsController = TextEditingController(
    text: 'Enrolled in a PhD candidate in CS, Psychology, HCI, or a related technical field',
  );
  final _experienceController = TextEditingController(
    text: '2+ years of industry experience conducting UX research in a professional setting',
  );
  final _skillsController = TextEditingController(text: 'design, research, user-testing, prototyping');
  final _descriptionController = TextEditingController(
    text: 'As a Senior UX Research Intern, you will be embedded within our Core Experience team...',
  );
  final _applicationUrlController = TextEditingController(text: 'https://careers.zewg.com/apply');

  String _selectedCategory = 'Internship';
  String _selectedWorkType = 'Remote';
  String _selectedCompensation = 'Paid';

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _jobController.dispose();
    _deadlineController.dispose();
    _locationController.dispose();
    _requirementsController.dispose();
    _experienceController.dispose();
    _skillsController.dispose();
    _descriptionController.dispose();
    _applicationUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Opportunity',
          style: AppTextStyles.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.error),
            onPressed: () {
              _showDeleteConfirmation(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Core Details Section
            _buildSectionHeader('Core Details'),
            const SizedBox(height: 16),
            
            _buildSectionLabel('Opportunity Title'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _titleController,
              label: null,
            ),
            const SizedBox(height: 24),
            
            _buildSectionLabel('Category'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.outline),
                ),
              ),
              items: ['Internship', 'Job', 'Scholarship'].map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            
            _buildSectionLabel('Application Deadline'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _deadlineController,
              label: null,
              suffixIcon: Icons.calendar_today,
            ),
            const SizedBox(height: 32),
            
            // Work Context Section
            _buildSectionHeader('Work Context'),
            const SizedBox(height: 16),
            
            _buildSectionLabel('Work Type'),
            const SizedBox(height: 8),
            _buildWorkContextChips(),
            const SizedBox(height: 24),
            
            _buildSectionLabel('Compensation'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedCompensation,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: ['Paid', 'Unpaid', 'Stipend'].map((comp) {
                return DropdownMenuItem(
                  value: comp,
                  child: Text(comp),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCompensation = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            
            _buildSectionLabel('Location'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _locationController,
              label: null,
              prefixIcon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 32),
            
            // Key Requirements Section
            _buildSectionHeader('Key Requirements'),
            const SizedBox(height: 16),
            
            _buildSectionLabel('Education'),
            const SizedBox(height: 8),
            CustomTextField.multiline(
              controller: _requirementsController,
              label: null,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            
            _buildSectionLabel('Experience'),
            const SizedBox(height: 8),
            CustomTextField.multiline(
              controller: _experienceController,
              label: null,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            
            _buildSectionLabel('Skills'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _skillsController,
              label: null,
            ),
            const SizedBox(height: 32),
            
            // Detailed Description Section
            _buildSectionHeader('Detailed Description'),
            const SizedBox(height: 16),
            CustomTextField.multiline(
              controller: _descriptionController,
              label: null,
              maxLines: 6,
            ),
            const SizedBox(height: 32),
            
            // Application Roadmap Section
            _buildSectionHeader('Application Roadmap'),
            const SizedBox(height: 16),
            _buildRoadmapSteps(),
            const SizedBox(height: 32),
            
            // Application URL
            _buildSectionLabel('Application URL'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _applicationUrlController,
              label: null,
              prefixIcon: Icons.link,
            ),
            const SizedBox(height: 32),
            
            // Action Buttons
            CustomButton.primary(
              text: 'Save Changes',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Changes saved successfully!')),
                );
                Navigator.pop(context);
              },
              isFullWidth: true,
              icon: Icons.check,
            ),
            const SizedBox(height: 16),
            CustomButton.secondary(
              text: 'Delete Post',
              onPressed: () {
                _showDeleteConfirmation(context);
              },
              isFullWidth: true,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.titleMedium.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label.toUpperCase(),
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.textSecondary,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildWorkContextChips() {
    final workTypes = ['Remote', 'On-site', 'Hybrid'];
    return Wrap(
      spacing: 8,
      children: workTypes.map((type) {
        final isSelected = _selectedWorkType == type;
        return FilterChip(
          label: Text(type),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedWorkType = type;
            });
          },
          backgroundColor: Colors.white,
          selectedColor: AppColors.primary,
          labelStyle: AppTextStyles.labelMedium.copyWith(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
          side: BorderSide(
            color: isSelected ? AppColors.primary : AppColors.outline,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRoadmapSteps() {
    return Column(
      children: [
        _buildRoadmapStep(1, 'Portfolio Review', 'Submit your portfolio and previous work'),
        const SizedBox(height: 12),
        _buildRoadmapStep(2, 'Technical Interview', 'Demonstrate your technical skills'),
        const SizedBox(height: 12),
        _buildRoadmapStep(3, 'Executive Panel', 'Final interview with leadership'),
      ],
    );
  }

  Widget _buildRoadmapStep(int number, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Opportunity'),
        content: const Text(
          'Are you sure you want to delete this opportunity? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to dashboard
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opportunity deleted')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
