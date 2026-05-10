import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/opportunity.dart';
import '../widgets/opportunity_form.dart';

class EditOpportunityScreen extends StatelessWidget {
  final Opportunity opportunity;

  const EditOpportunityScreen({
    super.key,
    required this.opportunity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZewgTheme.background,
      appBar: AppBar(
        backgroundColor: ZewgTheme.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ZewgTheme.textPrimary,
            size: 20,
          ),
        ),
        title: const Text(
          'Edit Opportunity',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: ZewgTheme.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: OpportunityForm(
          existing: opportunity,
          onSubmit: (updated) {
            context.pop(updated);
          },
          onDelete: () {
            context.pop();
          },
        ),
      ),
    );
  }
}
