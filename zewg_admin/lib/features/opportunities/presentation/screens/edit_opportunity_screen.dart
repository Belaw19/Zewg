import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/opportunity.dart';
import '../providers/opportunity_provider.dart';
import '../widgets/opportunity_form.dart';

class EditOpportunityScreen extends ConsumerWidget {
  final Opportunity opportunity;

  const EditOpportunityScreen({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ZewgTheme.background,
      appBar: AppBar(
        backgroundColor: ZewgTheme.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: ZewgTheme.textPrimary, size: 20),
        ),
        title: const Text(
          'Edit Opportunity',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: ZewgTheme.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: OpportunityForm(
          existing: opportunity,
          onSubmit: (updated) async {
            final result = await ref.read(adminOpportunitiesProvider.notifier).updateOpportunity(updated);
            if (!context.mounted) return;
            if (result != null) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opportunity updated'), backgroundColor: ZewgTheme.primary),
              );
            }
          },
          onDelete: () async {
            final ok = await ref.read(adminOpportunitiesProvider.notifier).delete(opportunity.id);
            if (!context.mounted) return;
            if (ok) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opportunity deleted'), backgroundColor: ZewgTheme.danger),
              );
            }
          },
        ),
      ),
    );
  }
}
