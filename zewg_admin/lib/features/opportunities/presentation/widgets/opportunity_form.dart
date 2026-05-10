import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/opportunity.dart';

class OpportunityForm extends StatelessWidget {
  final Opportunity? existing;
  final void Function(Opportunity) onSubmit;
  final VoidCallback? onDelete;
  late final TextEditingController _titleCtrl;
  late final TextEditingController _locationCtrl;
  late final TextEditingController _compensationAmtCtrl;
  late final TextEditingController _educationCtrl;
  late final TextEditingController _experienceCtrl;
  late final TextEditingController _skillsCtrl;
  late final TextEditingController _descriptionCtrl;
  late final TextEditingController _urlCtrl;
  late final List<_StepEntry> _steps;
  late final String _category;
  late final String _workType;
  late final String _compensation;
  late final DateTime? _deadline;

  OpportunityForm({
    super.key,
    this.existing,
    required this.onSubmit,
    this.onDelete,
  }) {
    final e = existing;
    _titleCtrl = TextEditingController(text: e?.title ?? '');
    _locationCtrl = TextEditingController(text: e?.location ?? '');
    _compensationAmtCtrl =
        TextEditingController(text: e?.compensationAmount ?? '');
    _educationCtrl = TextEditingController(text: e?.education ?? '');
    _experienceCtrl = TextEditingController(text: e?.experience ?? '');
    _skillsCtrl = TextEditingController(text: e?.skills.join(', ') ?? '');
    _descriptionCtrl = TextEditingController(text: e?.description ?? '');
    _urlCtrl = TextEditingController(text: e?.applicationUrl ?? '');
    _category = e?.category ?? 'Job';
    _workType = e?.workType ?? 'Remote';
    _compensation = e?.compensation ?? 'Paid';
    _deadline = e?.deadline;

    final existingSteps = e?.applicationSteps ??
        [
          ApplicationStep(title: '', description: ''),
          ApplicationStep(title: '', description: ''),
        ];
    _steps = existingSteps
        .map((s) => _StepEntry(
              titleCtrl: TextEditingController(text: s.title),
              descCtrl: TextEditingController(text: s.description),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) => _build(context);
}

class _StepEntry {
  final TextEditingController titleCtrl;
  final TextEditingController descCtrl;
  _StepEntry({required this.titleCtrl, required this.descCtrl});
  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
  }
}

extension on OpportunityForm {
  bool get _isEditMode => existing != null;

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: ZewgTheme.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Date changes are disabled in this view')),
      );
    }
  }

  void _submit(BuildContext context) async {
    if (_titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an opportunity title')),
      );
      return;
    }
    await Future.delayed(const Duration(milliseconds: 600));

    final skills = _skillsCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final steps = _steps
        .where((s) => s.titleCtrl.text.isNotEmpty)
        .map((s) => ApplicationStep(
            title: s.titleCtrl.text, description: s.descCtrl.text))
        .toList();

    final opp = Opportunity(
      id: existing?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleCtrl.text.trim(),
      category: _category,
      deadline: _deadline,
      workType: _workType,
      compensation: _compensation,
      compensationAmount: _compensationAmtCtrl.text.trim(),
      location: _locationCtrl.text.trim(),
      education: _educationCtrl.text.trim(),
      experience: _experienceCtrl.text.trim(),
      skills: skills,
      description: _descriptionCtrl.text.trim(),
      applicationSteps: steps,
      applicationUrl: _urlCtrl.text.trim(),
      company: existing?.company ?? 'The Academic Curator',
      views: existing?.views ?? 0,
      postedAt: existing?.postedAt ?? DateTime.now(),
    );

    onSubmit(opp);
  }

  Widget _build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Title section ────────────────────────────────────────────────
        if (_isEditMode)
          _sectionCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _sectionHeader('Core Details', Icons.tune),
              const SizedBox(height: 20),
              const FieldLabel(text: 'Position Title'),
              TextField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                    hintText: 'e.g. Senior Research Fellow'),
              ),
            ]),
          )
        else ...[
          const Text(
            'Curate Excellence',
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: ZewgTheme.textPrimary),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create a new entry for the global student community. Your precision helps shape professional futures.',
            style: TextStyle(
                fontSize: 14, color: ZewgTheme.textSecondary, height: 1.5),
          ),
          const SizedBox(height: 24),
          const FieldLabel(text: 'Opportunity Title'),
          TextField(
            controller: _titleCtrl,
            decoration: const InputDecoration(
                hintText: 'e.g. Senior Research Fellowship 2024'),
          ),
        ],
        const SizedBox(height: 16),

        // Category
        const FieldLabel(text: 'Category'),
        ZewgDropdown(
          value: _category,
          items: const ['Job', 'Internship', 'Scholarship'],
          onChanged: (_) {},
        ),
        const SizedBox(height: 16),

        // Deadline
        FieldLabel(text: _isEditMode ? 'Application Deadline' : 'Deadline'),
        GestureDetector(
          onTap: () => _pickDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: ZewgTheme.inputFill,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _deadline != null
                        ? DateFormat('MM/dd/yyyy').format(_deadline!)
                        : 'mm/dd/yyyy',
                    style: TextStyle(
                      fontSize: 15,
                      color: _deadline != null
                          ? ZewgTheme.textPrimary
                          : ZewgTheme.textMuted,
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today_outlined,
                    size: 18, color: ZewgTheme.textSecondary),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // ── Work Context ─────────────────────────────────────────────────
        _sectionCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _sectionHeader('Work Context', Icons.work_outline),
            const SizedBox(height: 20),
            const FieldLabel(text: 'Work Type'),
            ZewgDropdown(
              value: _workType,
              items: const ['Remote', 'On-site', 'Hybrid'],
              onChanged: (_) {},
            ),
            const SizedBox(height: 16),
            const FieldLabel(text: 'Compensation'),
            ZewgDropdown(
              value: _compensation,
              items: const ['Paid', 'Unpaid', 'Stipend'],
              onChanged: (_) {},
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _compensationAmtCtrl,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.attach_money,
                    size: 18, color: ZewgTheme.textSecondary),
                hintText: 'Amount or range (e.g. 50k - 70k)',
              ),
            ),
            const SizedBox(height: 16),
            const FieldLabel(text: 'Location'),
            TextField(
              controller: _locationCtrl,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined,
                    size: 18, color: ZewgTheme.textSecondary),
                hintText: 'e.g. San Francisco, CA or Global',
              ),
            ),
          ]),
        ),
        const SizedBox(height: 16),

        // ── Key Requirements ─────────────────────────────────────────────
        _sectionCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _sectionHeader('Key Requirements', Icons.checklist_outlined),
            const SizedBox(height: 20),
            const Text('Education',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ZewgTheme.textPrimary)),
            const SizedBox(height: 8),
            TextField(
              controller: _educationCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                  hintText: 'Degree, major, or specific academic standing...'),
            ),
            const SizedBox(height: 16),
            const Text('Experience',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ZewgTheme.textPrimary)),
            const SizedBox(height: 8),
            TextField(
              controller: _experienceCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                  hintText: 'Years of experience, specific industry roles...'),
            ),
            const SizedBox(height: 16),
            const Text('Skills',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ZewgTheme.textPrimary)),
            const SizedBox(height: 8),
            if (_isEditMode && _skillsCtrl.text.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ..._skillsCtrl.text
                      .split(',')
                      .map((s) => s.trim())
                      .where((s) => s.isNotEmpty)
                      .map((s) => TagChip(label: s)),
                  GestureDetector(
                    onTap: () => _showEditSkillsDialog(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: ZewgTheme.primary),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '+ Edit Skills',
                        style: TextStyle(
                            fontSize: 12,
                            color: ZewgTheme.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              )
            else
              TextField(
                controller: _skillsCtrl,
                decoration: const InputDecoration(
                  hintText:
                      'Technical proficiencies, soft skills, or certifications...',
                ),
              ),
          ]),
        ),
        const SizedBox(height: 16),

        // ── Detailed Description ─────────────────────────────────────────
        const FieldLabel(text: 'Detailed Description'),
        TextField(
          controller: _descriptionCtrl,
          maxLines: 6,
          decoration: const InputDecoration(
            hintText:
                'Describe the benefits and expectations of this opportunity...',
          ),
        ),
        const SizedBox(height: 24),

        // ── Application Roadmap ──────────────────────────────────────────
        _sectionCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              _sectionHeader('Application Roadmap', Icons.route_outlined),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Row(children: [
                  Icon(Icons.add, size: 16, color: ZewgTheme.primary),
                  SizedBox(width: 4),
                  Text('ADD STEP',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: ZewgTheme.primary,
                          letterSpacing: 0.5)),
                ]),
              ),
            ]),
            const SizedBox(height: 16),
            ..._steps.asMap().entries.map((entry) {
              final i = entry.key;
              final step = entry.value;
              final hints = ['Submit Portfolio', 'Interview', 'Final Review'];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        margin: const EdgeInsets.only(top: 10, right: 12),
                        decoration: const BoxDecoration(
                            color: ZewgTheme.primary, shape: BoxShape.circle),
                        child: Center(
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Expanded(
                        child: Column(children: [
                          TextField(
                            controller: step.titleCtrl,
                            decoration: InputDecoration(
                              hintText:
                                  'Step Title (e.g. ${i < hints.length ? hints[i] : "Next Step"})',
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: step.descCtrl,
                            maxLines: 2,
                            decoration: const InputDecoration(
                                hintText: 'Brief description of this phase...'),
                          ),
                        ]),
                      ),
                    ]),
              );
            }),
          ]),
        ),
        const SizedBox(height: 16),

        // ── Application URL ──────────────────────────────────────────────
        const FieldLabel(text: 'Application URL'),
        TextField(
          controller: _urlCtrl,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            prefixIcon:
                Icon(Icons.link, size: 18, color: ZewgTheme.textSecondary),
            hintText: 'https://opportunity.com/apply',
          ),
        ),
        const SizedBox(height: 24),

        // ── Cover Image ──────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: ZewgTheme.inputFill,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ZewgTheme.border),
          ),
          child: Column(children: [
            const Icon(Icons.add_photo_alternate_outlined,
                size: 36, color: ZewgTheme.textSecondary),
            const SizedBox(height: 8),
            Text(
              _isEditMode ? 'Change cover photo' : 'Upload Cover Image',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ZewgTheme.textPrimary),
            ),
            const Text('Recommended: 1200 x 600px',
                style: TextStyle(fontSize: 12, color: ZewgTheme.textMuted)),
          ]),
        ),
        const SizedBox(height: 32),

        // ── Submit button ────────────────────────────────────────────────
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _submit(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: ZewgTheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      _isEditMode ? 'Save Changes' : 'Publish Opportunity',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                        _isEditMode
                            ? Icons.check_circle_outline
                            : Icons.send_outlined,
                        size: 18),
                  ]),
          ),
        ),

        // Delete button (edit mode only)
        if (_isEditMode && onDelete != null) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline,
                  size: 18, color: ZewgTheme.danger),
              label: const Text('Delete Post',
                  style: TextStyle(
                      color: ZewgTheme.danger, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: ZewgTheme.danger),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'LAST EDITED\nToday at ${TimeOfDay.now().format(context)} by Admin',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 11, color: ZewgTheme.textMuted, height: 1.6),
            ),
          ),
        ] else ...[
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'SAVED AS DRAFT AUTOMATICALLY',
              style: TextStyle(
                  fontSize: 11, color: ZewgTheme.textMuted, letterSpacing: 0.5),
            ),
          ),
        ],

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ZewgTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Row(children: [
      Icon(icon, size: 18, color: ZewgTheme.primary),
      const SizedBox(width: 8),
      Text(title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: ZewgTheme.textPrimary)),
    ]);
  }

  void _showEditSkillsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        final ctrl = TextEditingController(text: _skillsCtrl.text);
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Edit Skills',
              style: TextStyle(fontWeight: FontWeight.w700)),
          content: TextField(
            controller: ctrl,
            decoration:
                const InputDecoration(hintText: 'Comma-separated skills'),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
