import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class AddOpportunityScreen extends StatefulWidget {
  const AddOpportunityScreen({super.key});

  @override
  State<AddOpportunityScreen> createState() => _AddOpportunityScreenState();
}

class _AddOpportunityScreenState extends State<AddOpportunityScreen> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _jobController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _workContextController = TextEditingController();
  final _compensationController = TextEditingController();
  final _locationController = TextEditingController();
  final _requirementsController = TextEditingController();
  final _experienceController = TextEditingController();
  final _skillsController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _applicationUrlController = TextEditingController();

  String _selectedCategory = 'Internship';
  String _selectedWorkType = 'Remote';
  String _selectedCompensation = 'Paid';

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _jobController.dispose();
    _deadlineController.dispose();
    _workContextController.dispose();
    _compensationController.dispose();
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
          'Add Opportunity',
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Curate Excellence',
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Create a new entry for the global student community. Our platform helps shape professional futures.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            
            // Opportunity Title
            _buildSectionLabel('Opportunity Title'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _titleController,
              hint: 'Senior UX Research Intern',
              label: null,
            ),
            const SizedBox(height: 24),
            
            // Category
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
            
            // Job
            _buildSectionLabel('Job'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _jobController,
              hint: 'UX Research',
              label: null,
            ),
            const SizedBox(height: 24),
            
            // Deadline
            _buildSectionLabel('Deadline'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _deadlineController,
              hint: 'MM/DD/YYYY',
              label: null,
              suffixIcon: Icons.calendar_today,
              onSuffixIconTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  _deadlineController.text = '${date.month}/${date.day}/${date.year}';
                }
              },
            ),
            const SizedBox(height: 24),
            
            // Work Context
            _buildSectionLabel('Work Context'),
            const SizedBox(height: 8),
            _buildWorkContextChips(),
            const SizedBox(height: 24),
            
            // Compensation
            _buildSectionLabel('Compensation'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedCompensation,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.outline),
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
            
            // Location
            _buildSectionLabel('Location'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _locationController,
              hint: 'San Francisco, CA',
              label: null,
              prefixIcon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 24),
            
            // Key Requirements
            _buildSectionLabel('Key Requirements'),
            const SizedBox(height: 8),
            CustomTextField.multiline(
              controller: _requirementsController,
              hint: 'Enrolled in a PhD candidate in CS, Psychology...',
              label: null,
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            
            // Experience
            _buildSectionLabel('Experience'),
            const SizedBox(height: 8),
            CustomTextField.multiline(
              controller: _experienceController,
              hint: '2+ years of industry experience conducting...',
              label: null,
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            
            // Skills
            _buildSectionLabel('Skills'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _skillsController,
              hint: 'design, research, user-testing',
              label: null,
              helperText: 'Separate skills with commas',
            ),
            const SizedBox(height: 24),
            
            // Detailed Description
            _buildSectionLabel('Detailed Description'),
            const SizedBox(height: 8),
            CustomTextField.multiline(
              controller: _descriptionController,
              hint: 'As a Senior UX Research Intern, you will be embedded within our Core Experience team...',
              label: null,
              maxLines: 6,
            ),
            const SizedBox(height: 24),
            
            // Application Roadmap
            _buildSectionLabel('Application Roadmap'),
            const SizedBox(height: 8),
            _buildRoadmapSteps(),
            const SizedBox(height: 24),
            
            // Application URL
            _buildSectionLabel('Application URL'),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _applicationUrlController,
              hint: 'https://careers.zewg.com/apply',
              label: null,
              prefixIcon: Icons.link,
            ),
            const SizedBox(height: 32),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton.secondary(
                    text: 'Save as Draft',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saved as draft')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton.primary(
                    text: 'Publish Opportunity',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opportunity published!')),
                      );
                      Navigator.pop(context);
                    },
                    icon: Icons.send,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
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
}
